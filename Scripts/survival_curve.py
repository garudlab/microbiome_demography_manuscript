"""
Compute the SFS of a given HMP1-2 species.

JCM 20230404
Adapted from code by Richard Wolff
"""


import sys
import os
import logging
import time
import argparse
import warnings
import random

import numpy
import itertools
import glob
import pandas as pd
import config
from utils import parse_midas_data, diversity_utils
from utils import clade_utils, parse_HMP_data
from utils import gene_diversity_utils
import numpy as np
import matplotlib
matplotlib.use('agg')
import matplotlib.pyplot as plt
import gzip
import dadi
import scipy.stats.distributions
import scipy.integrate
import scipy.optimize


class ArgumentParserNoArgHelp(argparse.ArgumentParser):
    """Like *argparse.ArgumentParser*, but prints help when no arguments."""

    def error(self, message):
        """Print error message, then help."""
        sys.stderr.write('error: %s\n\n' % message)
        self.print_help()
        sys.exit(2)


class HighRecombination():
    """Wrapper class to allow functions to reference each other."""

    def ExistingFile(self, fname):
        """Return *fname* if existing file, otherwise raise ValueError."""
        if os.path.isfile(fname):
            return fname
        else:
            raise ValueError("%s must specify a valid file name" % fname)

    def computeSFSParser(self):
        """Return *argparse.ArgumentParser* for ``fitdadi_infer_DFE.py``."""
        parser = ArgumentParserNoArgHelp(
            description=(
                'Computes a downsampled SFS for a given species.'),
            formatter_class=argparse.ArgumentDefaultsHelpFormatter)
        parser.add_argument(
            'species', type=str,
            help=('String describing the species being analyzed.'))
        parser.add_argument(
            'outprefix', type=str,
            help='The file prefix for the output files')
        return parser

    def read_sites(self, species):
        """Read sites from given species."""
        # Read input snps csv
        df_sites = pd.read_csv(str(config.snps_directory) + '/' +
                               str(species) + '/snps_info.txt.bz2', sep='\t',
                               index_col=0, na_values = 'NaN')

        # Gain list of contigs and assign row value
        df_sites["contig"] = [d.split("|")[0] for d in df_sites.index]
        df_sites.index = [d.split("|")[1] for d in df_sites.index]

        # Ignore non coding sites
        df_sites["gene_id"] = df_sites["gene_id"].fillna("non coding")
        gene_ids = df_sites["gene_id"].values

        gene_breaks = [0] # Initialize list

        gc = gene_ids[0] # Initialize list

        unq_genes = [gc] # Unique genes
        unq_cont = [df_sites["contig"][0]] # Unique contigs

        # append unique genes and contigs to initialized lists
        for i,g in enumerate(gene_ids):
            if g is not gc:
                gene_breaks.append(i)
                gc = g
                unq_genes.append(gc)
                unq_cont.append(df_sites["contig"][i])

        gene_breaks = np.array(gene_breaks) # Cast as array
        # Compute gene lengths from gene breakpoints
        gene_lengths = gene_breaks[1:] - gene_breaks[:-1]

        df_sites.index.set_names("site_pos",inplace=True) # Rename index

        # Multi-index dataframe
        df_sites.set_index('gene_id', append=True, inplace=True)
        df_sites.set_index('contig', append=True, inplace=True)

        df_sites = df_sites.reorder_levels(["contig",'gene_id', 'site_pos'])

        return(df_sites,gene_lengths,unq_genes,unq_cont)

    def load_substitution_rate_map(self, species):
        """Read pre-computed substitution rate map for species."""
        # data_directory = os.path.expanduser(
        #     "/u/project/ngarud/Garud_lab/metagenomic_fastq_files/HMP1-2/data")
        # data_directory = config.data_directory
        data_directory = "/u/project/ngarud/Garud_lab/metagenomic_fastq_files/HMP1_2_Kuleshov_Qin_Twins_Korpela"
        substitution_rate_directory = '%s/substitution_rates/' % data_directory
        intermediate_filename_template = '%s%s.txt.gz'

        intermediate_filename = intermediate_filename_template % (
            substitution_rate_directory, species)

        substitution_rate_map = {}

        # print(intermediate_filename)

        if not os.path.isfile(intermediate_filename):
            print('empty map')
            return substitution_rate_map

        file = gzip.open(intermediate_filename,"r")
        file.readline() # header
        for line in file:
            items = line.split(",")
            if items[0].strip()!=species:
                continue

            record_strs = [", ".join(['Species', 'Sample1', 'Sample2', 'Type',
                                      'Num_muts', 'Num_revs',
                                      'Num_mut_opportunities',
                                      'Num_rev_opportunities'])]

            sample_1 = items[1].strip()
            sample_2 = items[2].strip()
            type = items[3].strip()
            num_muts = float(items[4])
            num_revs = float(items[5])
            num_mut_opportunities = float(items[6])
            num_rev_opportunities = float(items[7])

            num_changes = num_muts+num_revs
            num_opportunities = num_mut_opportunities+num_rev_opportunities

            sample_pair = (sample_1, sample_2)

            if type not in substitution_rate_map:
                substitution_rate_map[type] = {}

            substitution_rate_map[type][sample_pair] = (num_muts, num_revs,
                num_mut_opportunities, num_rev_opportunities)

        return substitution_rate_map

    def calculate_mutrev_matrices_from_substitution_rate_map(self, substitution_rate_map, type, allowed_samples=[]):
        # Rewritten to preserve order of allowed samples
        # If allowed samples contains things that are not in DB, it returns zero opportunities

        total_sample_set = set([])
        for sample_1, sample_2 in substitution_rate_map[type].keys():
            total_sample_set.add(sample_1)
            total_sample_set.add(sample_2)

        if len(allowed_samples)==0:
            allowed_samples = list(sorted(total_sample_set))

        # allows us to go from sample name to idx in allowed samples (to preserve order)
        sample_idx_map = {allowed_samples[i]:i for i in xrange(0,len(allowed_samples))}

        mut_difference_matrix = numpy.zeros((len(allowed_samples), len(allowed_samples)))*1.0
        rev_difference_matrix = numpy.zeros_like(mut_difference_matrix)

        mut_opportunity_matrix = numpy.zeros_like(mut_difference_matrix)
        rev_opportunity_matrix = numpy.zeros_like(mut_difference_matrix)

        for sample_pair in substitution_rate_map[type].keys():

            sample_i = sample_pair[0]
            sample_j = sample_pair[1]

            if not ((sample_i in sample_idx_map) and (sample_j in sample_idx_map)):
                continue

            i = sample_idx_map[sample_i]
            j = sample_idx_map[sample_j]

            num_muts, num_revs, num_mut_opportunities, num_rev_opportunities = substitution_rate_map[type][sample_pair]

            mut_difference_matrix[i,j] = num_muts
            rev_difference_matrix[i,j] = num_revs

            mut_opportunity_matrix[i,j] = num_mut_opportunities
            rev_opportunity_matrix[i,j] = num_rev_opportunities

        return allowed_samples, mut_difference_matrix, rev_difference_matrix, mut_opportunity_matrix, rev_opportunity_matrix

    def calculate_matrices_from_substitution_rate_map(self, substitution_rate_map, type, allowed_samples=[]):
        # once the map is loaded, then we can compute rate matrices in this definition (so, it relies on the previous def)

        samples, mut_difference_matrix, rev_difference_matrix, mut_opportunity_matrix, rev_opportunity_matrix = self.calculate_mutrev_matrices_from_substitution_rate_map( substitution_rate_map, type, allowed_samples)

        difference_matrix = mut_difference_matrix+rev_difference_matrix
        opportunity_matrix = mut_opportunity_matrix+rev_opportunity_matrix

        return samples, difference_matrix, opportunity_matrix

    def calculate_unique_samples(self, subject_sample_map, sample_list=[]):

        if len(sample_list)==0:
            sample_list = list(sorted(flatten_samples(subject_sample_map).keys()))

        # invert subject sample map
        sample_subject_map = {}
        for subject in subject_sample_map.keys():
            for sample in subject_sample_map[subject].keys():
                sample_subject_map[sample] = subject

        subject_idx_map = {}

        for i in xrange(0,len(sample_list)):
            sample = sample_list[i]
            if sample.endswith('c'):
                sample = sample[:-1]
            subject = sample_subject_map[sample]
            if not subject in subject_idx_map:
                subject_idx_map[subject] = i

        unique_idxs = numpy.zeros(len(sample_list),dtype=numpy.bool_)
        for i in subject_idx_map.values():
            unique_idxs[i]=True

        return

    def load_core_genes(self, desired_species_name, min_copynum=0.3, max_copynum=3.0, min_prevalence=0.95, max_prevalence=1.0, min_marker_coverage=20, unique_individuals=False):

        # Load subject and sample metadata
        subject_sample_map = parse_HMP_data.parse_subject_sample_map()

        # Load reference genes
        reference_genes = parse_midas_data.load_reference_genes(desired_species_name)

        gene_samples, gene_names, gene_presence_matrix, gene_depth_matrix, marker_coverages, gene_reads_matrix = parse_midas_data.parse_pangenome_data(desired_species_name)

        gene_names = numpy.array(gene_names)

        reference_gene_idxs = numpy.array([gene_name in reference_genes for gene_name in gene_names])

        # print(len(gene_names))

        if unique_individuals:
            sample_idxs = (self.calculate_unique_samples(subject_sample_map, gene_samples))*(marker_coverages>=min_marker_coverage)
        else:
            sample_idxs = marker_coverages>=min_marker_coverage

        prevalences = gene_diversity_utils.calculate_fractional_gene_prevalences(gene_depth_matrix[:,sample_idxs], marker_coverages[sample_idxs], min_copynum)

        over_prevalence = prevalences >= min_prevalence
        under_prevalence = prevalences <= max_prevalence

        accessory_prevalence = [over_prevalence[i] and under_prevalence[i] for i in range(len(prevalences))]
        accessory_gene_idxs = reference_gene_idxs*(accessory_prevalence)

        return set(gene_names[accessory_gene_idxs])

    def load_accessory_genes(self, desired_species_name, min_copynum=0.3, max_copynum=3.0, min_prevalence=0.3, max_prevalence=0.7, min_marker_coverage=20, unique_individuals=False):

        # Load subject and sample metadata
        subject_sample_map = parse_HMP_data.parse_subject_sample_map()

        # Load reference genes
        reference_genes = parse_midas_data.load_reference_genes(desired_species_name)

        gene_samples, gene_names, gene_presence_matrix, gene_depth_matrix, marker_coverages, gene_reads_matrix = parse_midas_data.parse_pangenome_data(desired_species_name)

        gene_names = numpy.array(gene_names)

        reference_gene_idxs = numpy.array([gene_name in reference_genes for gene_name in gene_names])

        # print(len(gene_names))

        if unique_individuals:
            sample_idxs = (self.calculate_unique_samples(subject_sample_map, gene_samples))*(marker_coverages>=min_marker_coverage)
        else:
            sample_idxs = marker_coverages>=min_marker_coverage

        prevalences = gene_diversity_utils.calculate_fractional_gene_prevalences(gene_depth_matrix[:,sample_idxs], marker_coverages[sample_idxs], min_copynum)

        over_prevalence = prevalences >= min_prevalence
        under_prevalence = prevalences <= max_prevalence

        accessory_prevalence = [over_prevalence[i] and under_prevalence[i] for i in range(len(prevalences))]
        accessory_gene_idxs = reference_gene_idxs*(accessory_prevalence)

        return set(gene_names[accessory_gene_idxs])


    def main(self):
        """Execute main function."""
        # Parse command line arguments
        parser = self.computeSFSParser()
        args = vars(parser.parse_args())
        prog = parser.prog

        # Assign arguments
        outprefix = args['outprefix']
        species = args['species']
        random.seed(1)

        # Numpy options
        numpy.set_printoptions(linewidth=numpy.inf)

        # create output directory if needed
        outdir = os.path.dirname(args['outprefix'])
        if outdir:
            if not os.path.isdir(outdir):
                if os.path.isfile(outdir):
                    os.remove(outdir)
                os.mkdir(outdir)

        # Output files: logfile, snp_matrix.csv
        # Remove output files if they already exist
        underscore = '' if args['outprefix'][-1] == '/' else '_'
        survival_curve_csv = \
           '{0}{1}survival_curve.csv'.format(
                args['outprefix'], underscore)
        logfile = '{0}{1}survival_curve.log'.format(
            args['outprefix'], underscore)
        to_remove = [logfile, survival_curve_csv]
        # for f in to_remove:
        #     if os.path.isfile(f):
        #         os.remove(f)

        # Set up to log everything to logfile.
        logging.shutdown()
        logging.captureWarnings(True)
        logging.basicConfig(
            format='%(asctime)s - %(levelname)s - %(message)s',
            level=logging.INFO)
        logger = logging.getLogger(prog)
        warning_logger = logging.getLogger("py.warnings")
        logfile_handler = logging.FileHandler(logfile)
        logger.addHandler(logfile_handler)
        warning_logger.addHandler(logfile_handler)
        formatter = logging.Formatter(
            '%(asctime)s - %(levelname)s - %(message)s')
        logfile_handler.setFormatter(formatter)
        logger.setLevel(logging.INFO)

        # print some basic information
        logger.info('Beginning execution of {0} in directory {1}\n'.format(
            prog, os.getcwd()))
        logger.info('Progress is being logged to {0}\n'.format(logfile))
        logger.info('Parsed the following arguments:\n{0}\n'.format(
            '\n'.join(['\t{0} = {1}'.format(*tup) for tup in args.items()])))

        LG = pd.read_csv("../HighRecombinationData/LiuGood2024TableS3.csv", index_col=1)
        iLDS = pd.read_csv("../HighRecombinationData/RW_TableS4.csv", index_col=1)

        # Remove potential duplicates
        LG = LG.loc[LG["Potential duplicate of other events?"] == False]
        # print(LG)

        LG = LG.loc[species]
        # print(species)

        iLDS = iLDS.loc[iLDS['Species'] == species]
        iLDS_site_pos = iLDS.get('SNV position (genome)')

        LG = LG.loc[(LG["between clade?"] == "N") | (LG["between clade?"].isna())]

        # set window size
        ws = 30000

        # sp = LG.index.get_level_values("Reference genome end loc")
        ref_sp_max = LG["Reference genome end loc"].max()
        ref_sp_min = LG["Reference genome start loc"].min()
        # print(ref_sp_max)
        # print(ref_sp_min)
        ref_sp = np.arange(ref_sp_min, ref_sp_max, 1)

        num_transfers = {}
        for i in range(len(ref_sp)):
            if i + ws < len(ref_sp):
                n = ((LG["Reference genome start loc"] >= ref_sp[i])&(LG["Reference genome start loc"] < ref_sp[int(i+ws)])).sum()
                num_transfers[(ref_sp[int(i)],ref_sp[int(i+ws)])] = n
            else:
                n = ((LG["Reference genome start loc"] >= ref_sp[i])&(LG["Reference genome start loc"] < ref_sp[-1])).sum()
                num_transfers[(ref_sp[int(i)], ref_sp[-1])] = n

        num_transfers = pd.Series(num_transfers)
        num_transfers.index.names = ["ref_start", "ref_end"]
        # print(num_transfers)

        midpoints = num_transfers.index.get_level_values("ref_start") + (num_transfers.index.get_level_values("ref_end") - num_transfers.index.get_level_values("ref_start"))/2

        # Initialize pass_positions with False
        pass_positions = np.full(len(midpoints), False, dtype=bool)

        # Check each midpoint against all iLDS_site_pos values
        for i, midpoint in enumerate(midpoints):
            for pos in iLDS_site_pos:
                if abs(midpoint - pos) <= 1000:
                    pass_positions[i] = True
                    break  # No need to check further if we found a iLDS_site_pos within 1000 units

        # Output the pass_positions vector


        fig, ax = plt.subplots(figsize=(16, 8))
        transfer_rate = num_transfers.values / (num_transfers.index.get_level_values("ref_end") - num_transfers.index.get_level_values("ref_start"))
        transfer_rate = pd.Series(transfer_rate, index=num_transfers.index)

        percentiles = np.arange(0.0, 1.01, 0.01)
        survival_sites = []

        for percentile in percentiles:
            high_recombination_sites = transfer_rate[transfer_rate > transfer_rate.quantile(percentile)]
            high_recombination_midpoints = high_recombination_sites.index.get_level_values("ref_start") + \
                (high_recombination_sites.index.get_level_values("ref_end") - high_recombination_sites.index.get_level_values("ref_start"))/2
            high_recombination_sites_set = set()
            for site_index in high_recombination_midpoints:
                lower_bound = site_index - 1000
                upper_bound = site_index + 1000
                sites_to_add = range(lower_bound, upper_bound, 1)
                for site in sites_to_add:
                    high_recombination_sites_set.add(site)
            # print(high_recombination_sites_set)
            # print(midpoints[pass_positions])

            high_selection_sites_set = set()
            for site_index in midpoints[pass_positions]:
                lower_bound = site_index - 1000
                upper_bound = site_index + 1000
                sites_to_remove = range(lower_bound, upper_bound, 1)
                for site in sites_to_remove:
                     high_selection_sites_set.add(site)

            sites_for_sfs = high_recombination_sites_set - high_selection_sites_set
            survival_sites.append(len(sites_for_sfs))

        data = {'Recombination percentile': percentiles,
                'Remaining sites': survival_sites}
        survival_curve = pd.DataFrame(data)
        survival_curve.to_csv(survival_curve_csv, index=False)

        logger.info('The 25th percentile of recombination is: {0}'.format(transfer_rate.quantile(0.25)))
        logger.info('The 50th percentile of recombination is: {0}'.format(transfer_rate.quantile(0.50)))
        logger.info('The 75th percentile of recombination is: {0}'.format(transfer_rate.quantile(0.75)))
        logger.info('Pipeline executed succesfully.')


if __name__ == '__main__':
    HighRecombination().main()
