"""
Computes SNP matrix from a given `*snps_ref_freq.txt.bz2`.

Recall that pi is the expected heterozygosity.
Recall that heterozygosity is the probability of grabbing
    two disinct alleles, i.e., randomly selecting a
    heterozygote.

JCM 20220809
Adapted from code by Leah Briscoe
"""


import sys
import os
import logging
import time
import argparse
import warnings

import pandas as pd
from bz2 import BZ2File as bzopen
import itertools
import matplotlib
matplotlib.use('agg')
import matplotlib.pyplot as plt
import statistics
from datetime import datetime
import numpy as np
from plot_stats_helpers import calc_pi, calc_schloissnig_pi, calc_Fst,pi_stats_single,vector_stats,fst_stats_all_focalpairs


class ArgumentParserNoArgHelp(argparse.ArgumentParser):
    """Like *argparse.ArgumentParser*, but prints help when no arguments."""

    def error(self, message):
        """Print error message, then help."""
        sys.stderr.write('error: %s\n\n' % message)
        self.print_help()
        sys.exit(2)


class ComputePi():
    """Wrapper class to allow functions to reference each other."""

    def ExistingFile(self, fname):
        """Return *fname* if existing file, otherwise raise ValueError."""
        if os.path.isfile(fname):
            return fname
        else:
            raise ValueError("%s must specify a valid file name" % fname)

    def computePiParser(self):
        """Return *argparse.ArgumentParser* for ``fitdadi_infer_DFE.py``."""
        parser = ArgumentParserNoArgHelp(
            description=(
                'Given a specified `*snps_ref_freq.txt.bz2, this script '
                'computes average Pi across samples matrix for that species.'),
            formatter_class=argparse.ArgumentDefaultsHelpFormatter)
        parser.add_argument(
            'input_depth', type=self.ExistingFile,
            help=('Annotated SNPs document in the format output by Midas'))
        parser.add_argument(
            'input_ref_freq', type=self.ExistingFile,
            help=('Reference SNP frequency document in the format output '
                  'by Midas'))
        parser.add_argument(
            'outprefix', type=str,
            help='The file prefix for the output files')
        parser.add_argument(
            '--sample_id', help='sample id', type=str,default='')
        parser.add_argument(
            '--sample_id2', help='Minimal tester mode? (0 or 1)', type=str,default='')
        parser.add_argument(
            '--end_index', , default=5163190, help='Minimum read depth for a valid allele frequency',type = int)
        parser.add_argument(
            '--species', help='Strain to study', type=str)
        parser.add_argument(
            '--calc_type', help='Method to calculate Pi', type=str)
        parser.add_argument(
            '--statistic', help='Nucleotide diversity', default='pi', type=str)
        parser.add_argument(
            '--cov_min', help='Coverage minimum', default=10, type=int)
        parser.add_argument(
            '--custom', help='Minimal tester mode? (0 or 1)', default=False, action='store_true')
        return parser

    def calc_pi(ref_freq):
        """For given ref_freq, compute pi for single sample."""
        return(ref_freq * (1-ref_freq) * float(2))

    def calc_schloissnig_pi(ref_freq, ref_depth):
        """For given ref_freq, compute pi using Schloissnig method."""
        n_nucleotide1 = int(ref_freq * ref_depth)
        n_nucleotide2 = ref_depth - n_nucleotide1
        c = ref_depth
        return((n_nucleotide1/c * n_nucleotide2/(c-1)) + (n_nucleotide2/c * n_nucleotide1/(c-1)))

    def pi_stats_single(depth_path_, freq_path_, gene_path_, sample_id_, end_index,
                        calc_type_, statistic_, coverage_min, core_genes_only):
        """Compute nucleotide diversity for single sample."""
        statistic_vec = []
        statistic_vec2 = []
        statistic_vec3 = []
        pi1_vec = []
        pi2_vec = []
        allele_counts_array1 = []
        allele_counts_array2 = []
        with bzopen(depth_path_, "r") as bzdepth, bzopen(freq_path_, "r") as bzfreq:
            for i, (depth_line, freq_line) in enumerate(zip(bzdepth,bzfreq)):
                if i == end_index: break
                if i == 0:
                    colnames = depth_line.decode().rstrip().split("\t")
                    if (len(sample_id_) == 1) or (statistic_ == 'Fst'):
                        if sample_id_[0] not in colnames and (statistic_ == 'Fst'):
                            print("first not here")
                            return("Nothing","Nothing", "Nothing","Nothing","Nothing")
                        if sample_id_[0] not in colnames and (statistic_ == 'pi'):
                            print("first not here")
                            return("Nothing","Nothing")
                        sample_location = colnames.index(sample_id_[0]) # for individual pi
                    else:
                        print("length ids")
                        print(len(sample_id_))
                        intersection_acc = list(set(colnames).intersection(set(sample_id_)))
                        print("length intersection")
                        print(len(intersection_acc))
                        sample_location = [colnames.index(k) for k in intersection_acc]
                        print("sample locations")
                        print(sample_location)
                    if statistic_ == 'Fst':
                        if sample_id_[1] not in colnames:
                            print("second not here")
                            return("Nothing","Nothing", "Nothing","Nothing","Nothing")
                        sample_location2 = colnames.index(sample_id_[1]) # for individual pi
                    continue
                # CORE GENE CONSTRAINT APPLIES TO BOTH Fst And PI the same way so let's deal with it here.
                if i > 0 and core_genes_only:
                    prettified_gene_presab = gene_line.decode().rstrip().split("\t")
                    gene_presence_absence =    [int(k) for k in prettified_gene_presab[1:len(prettified_gene_presab)]]
                    print("Percent present")
                    presence_percentage = sum(gene_presence_absence)/len(gene_presence_absence)
                    print(presence_percentage)
                    if presence_percentage < 0.80:
                        print("skip!")
                        continue
                if i%10000 == 0:
                    print(i)
                if statistic_ == 'pi':
                    if len(sample_id_) == 1:
                        sample_depth = int(depth_line.decode().rstrip().split("\t")[sample_location ])
                        if sample_depth < coverage_min:continue
                        sample_freq = float(freq_line.decode().rstrip().split("\t")[sample_location ])
                    else:
                        prettified_depth = depth_line.decode().rstrip().split("\t")
                        prettified_freq = freq_line.decode().rstrip().split("\t")
                        sample_freq = [float(prettified_freq[k]) for k in sample_location if int(prettified_depth[k]) >= coverage_min ]
                        sample_temp_depth = [int(prettified_depth[k]) for k in sample_location if int(prettified_depth[k]) >= coverage_min ]
                        sample_depth = sample_temp_depth
                        # for multiple samples into pi, it can be one sample, but for piared pi, it needs to be at least two samples
                        if (len(sample_id_) > 2 and len(sample_freq) < 1) or    (len(sample_id_) == 2 and len(sample_freq) < 2):
                            print("only one sample at this site valid")
                            continue
                        #if I instead use per site coverage conspeciests, then I need to update this vector later based on per sample depth --> DONE?
                        alt_freq = [1-k for k in sample_freq]
                        ref_depth = [a*b for a,b in zip(sample_depth,sample_freq)]
                        ref_depth = sum(ref_depth)
                        sample_depth = sum(sample_depth)
                        # POOL READS TO CALCULATE FREQUENCY
                        if sample_depth < coverage_min:continue
                        sample_freq = ref_depth/ sample_depth
                        #sample_freq = sum(sample_freq)
                    if calc_type_ == "Regular":
                        pi = calc_pi(sample_freq)
                    else:
                        pi = calc_schloissnig_pi(sample_freq,sample_depth)
                    print("pi " + str(pi))
                    statistic_vec.append(pi)
                # print pi and fst both
        if calc_type_ == "allel":
            ac1 = allel.AlleleCountsArray(allele_counts_array1)
            ac2 = allel.AlleleCountsArray(allele_counts_array2)
            num, den = allel.hudson_fst(ac1, ac2)
            fst = np.sum(num) / np.sum(den)
        if statistic_ == 'pi':
            if len(statistic_vec) == 0:
                return("Nothing","Nothing")
            else:
                return(len(statistic_vec),np.mean(statistic_vec))

    def vector_stats(depth_path_,freq_path_,end_index, calc_type_, statistic_,coverage_min):
        """Compute vector of given statistic."""
        statistic_vec = []
        colnames= []
        rownames= []
        with bzopen(depth_path_, "r") as bzdepth, bzopen(freq_path_, "r") as bzfreq:
            for i, (depth_line, freq_line) in enumerate(zip(bzdepth,bzfreq)):
                if i == end_index: break
                if i == 0:
                    colnames = depth_line.decode().rstrip().split("\t")[1:]
                    continue
                if i%10000 == 0:
                    print(i)
                #VECTORIZED VERSION
                rn = depth_line.decode().rstrip().split("\t")[0]
                sample_depth = [int(i) for i in depth_line.decode().rstrip().split("\t")[1:]]
                sample_freq = [float(i) for i in freq_line.decode().rstrip().split("\t")[1:]]
                # get indices for samples with sufficient depth
                good_samples = [ind for ind, s in enumerate(sample_depth) if s >= coverage_min]
                if len(good_samples) == 0 :continue
                sample_freq_ =[sample_freq[ind] if s >= coverage_min else float("nan") for ind, s in enumerate(sample_depth)]
                sample_depth_ =[sample_depth[ind] if s >= coverage_min else float("nan") for ind, s in enumerate(sample_depth)]
                sample_freq = sample_freq_
                sample_depth = sample_depth_
                if statistic_ == 'pi':
                    rownames.append(rn)
                    if calc_type_ == "Regular":
                        pi = list(map(calc_pi, sample_freq))
                    statistic_vec.append(pi)
        if statistic_ == 'pi':
            if len(statistic_vec) == 0:
                return("Nothing",["Nothing","Nothing"])
            else:
                print("statistic_vec.shape")
                # print(len(statistic_vec))
                # print("First 5")
                # print(statistic_vec[0:5])
                statistic_vec = np.array(statistic_vec)
                statistic_vec = np.nanmean(statistic_vec, axis=0)
                return(colnames,len(statistic_vec),statistic_vec)

    def plot_vector(out_dir,data_vector,file_name):
        """Generate plot for given vector."""
        fig = plt.figure()
        ax = fig.add_axes([0.1,0.1,0.75,0.75])
        ax.set_title(file_name + " Coverage in "+ species)
        ax.set_xlabel("Read depth per site")
        ax.hist(data_vector)
        plt.savefig(out_dir + species + file_name + '.png')


    def main(self):
        """Execute main function."""
        # Parse command line arguments
        parser = self.computePiParser()
        args = vars(parser.parse_args())
        prog = parser.prog
        core_genes_only_ = False

        # Assign arguments
        input_depth = args['input_depth']
        input_ref_freq = args['input_ref_freq']
        outprefix = args['outprefix']
        sample_id = args['sample_id']
        sample_id2 = args['sample_id2']
        end_index = args['end_index']
        species = args['species']
        calc_type = args['calc_type']
        calc_statistic = args['statistic']
        cov_min = args['cov_min']
        custom = args['custom']
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
        output_matrix = \
            '{0}{1}output_matrix.csv'.format(
                args['outprefix'], underscore)
        logfile = '{0}{1}compute_pi.log'.format(args['outprefix'], underscore)
        to_remove = [logfile, output_matrix]
        for f in to_remove:
            if os.path.isfile(f):
                os.remove(f)

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
        depth_path = snp_dir + "snps_depth.txt.bz2"
        freq_path = snp_dir + "snps_ref_freq.txt.bz2"
        gene_path = gene_dir + "genes_presabs.txt.bz2"

        if calc_statistic == "pi":
            output_dir = input_dir + "/corrected_pi_data_cov" + str(cov_min ) + "_core_" + str(core_genes_only_) + "/"
        else:
            output_dir = input_dir + "/corrected_Fst_data_cov" + str(cov_min) + "_core_" + str(core_genes_only_) +    "/"

        if not os.path.exists(output_dir):
            os.makedirs(output_dir)
        start = datetime.now()
        print(start )
        if calc_statistic == "pi":
            if sample_id == "":
                colnames,length_calc,mean_pi = vector_stats(depth_path,freq_path,end_index,calc_type,calc_statistic,coverage_min = cov_min)
                print("mean_pi[1:5]")
                print(mean_pi[1:5])
                mfileName = output_dir + calc_statistic + "-" + species + "-" + calc_type + "-" + "vecmeta"    + '.txt'
                mfileName_ = output_dir + calc_statistic + "-" +    species    + "-" + "vecmeta"    + '.txt'
                fileName = output_dir + calc_statistic + "-" + species + "-" + calc_type + "-" + "vecstats"    + '.txt'
                fileName_ = output_dir + calc_statistic + "-" +    species    + "-" + "vecstats"    + '.txt'
                if mean_pi[0] == "Nothing":
                    print("not enough data")
                    with open(fileName_, 'w') as f:
                        f.write("Nothing")
                        f.write('\n')
                        f.close()
                    print(datetime.now() - start)
                    sys.exit()
                rounded_mean_pi = [round(p,7) for p in mean_pi]
                together = pd.Series(index = colnames,data = mean_pi)
                print(together)
                together.to_csv(fileName, sep='\t')
            else:
                if custom:
                    print("CUSTOM sample ID")
                    print(sample_id)
                    #input_dir = "/Users/leahbriscoe/Documents/FEASTX/SuezMontassierFiles/"
                    if "Pertissue" in sample_id:
                        tissue_record = pd.read_csv(input_dir +"Pertissue_pi.txt",index_col = 0,sep = "\t")
                    elif "Multitissue" in sample_id:
                        tissue_record = pd.read_csv(input_dir +"Multitissue_pi.txt",index_col = 0,sep = "\t")
                    select_accessions = list(set(tissue_record.loc[sample_id]))
                    length_calc,mean_pi = pi_stats_single(depth_path,freq_path,gene_path,select_accessions,end_index,calc_type,calc_statistic,coverage_min = cov_min,core_genes_only = core_genes_only_)
                    print(mean_pi)
                    fileName = output_dir + calc_statistic + "-" + species + "-" + calc_type    + "-" + sample_id    + '.txt'
                    fileName_ = output_dir + calc_statistic + "-" +    species    +    "-" + sample_id + "-"    + '.txt'
                if sample_id2 == "":
                    length_calc,mean_pi = pi_stats_single(depth_path,freq_path, gene_path,[sample_id],end_index,calc_type,calc_statistic,coverage_min = cov_min,core_genes_only = core_genes_only_)
                    fileName = output_dir + calc_statistic + "-" + species + "-" + calc_type + "-" + sample_id    + '.txt'
                    fileName_ = output_dir + calc_statistic + "-" +    species    +"-" + sample_id + "-"    + '.txt'
                else:
                    print("two sample pi")
                    length_calc,mean_pi = pi_stats_single(depth_path,freq_path, gene_path,[sample_id,sample_id2],end_index,calc_type,calc_statistic,coverage_min = cov_min,core_genes_only = core_genes_only_)
                    fileName = output_dir + calc_statistic + "-" + species + "-" + calc_type + "-" + sample_id + "-"    + sample_id2 + '.txt'
                    fileName_ = output_dir + calc_statistic + "-" +    species    + "-" + sample_id + "-"    + sample_id2 + '.txt'
                if mean_pi == "Nothing":
                    print("not enough data")
                    with open(fileName_, 'w') as f:
                        f.write("Nothing")
                        f.write('\n')
                        f.close()
                    print(datetime.now() - start)
                    sys.exit()
                output_string = str(end_index) + "," + str(length_calc) + "," + str(round(mean_pi,7))
                print(output_string)
                with open(fileName, 'w') as f:
                    f.write(output_string)
                    f.write('\n')
                    f.close()
        print(datetime.now() - start)


if __name__ == '__main__':
    ComputePi().main()


#python plot_stats.py --sample_id ERR2749245 --end_index 5163190 --species Bacteroides_vulgatus_57955 --study SuezMontassier --calc_type Schloissnig --statistic pi

#python plot_stats.py --sample_id ERR2749245 --end_index 100 --species Bacteroides_vulgatus_57955 --study SuezMontassier --calc_type Schloissnig --statistic pi
# sample person, but first id is stooll, second is cecum lumen earlier time
##python plot_stats.py --sample_id ERR2749231 --sample_id2 ERR2749492 --end_index 5163190 --species Bacteroides_vulgatus_57955 --study SuezMontassier --calc_type Regular --statistic Fst
##python plot_stats.py --sample_id ERR2749219 --sample_id2 ERR2749343 --end_index 1000 --species Bacteroides_vulgatus_57955 --study SuezMontassier --calc_type Schloissnig --statistic Fst


# python plot_stats.py --sample_id ERR2749219 --sample_id2 ERR2749343 --end_index 10 --species Bacteroides_vulgatus_57955 --study SuezMontassier --calc_type Regular --statistic pi --cov_min 4 --local

##python plot_stats.py --sample_id ERR2749219 --end_index 5163190 --species Bacteroides_vulgatus_57955 --study SuezMontassier --calc_type Regular --statistic pi --cov_min 4 --local
#python plot_stats.py --end_index 122 --species Bacteroides_vulgatus_57955 --study SuezMontassier --calc_type Regular --statistic Fst
#python plot_stats.py --end_index 122 --species Bacteroides_vulgatus_57955 --study SuezMontassier --calc_type Regular --statistic pi --cov_min 4
#python plot_stats.py --sample_id 700117303 --sample_id2 700173483 --end_index 5163190 --species Bacteroides_vulgatus_57955 --study HMP --calc_type Schloissnig --statistic Fst --cov_min 4

## # 700117303 700173483 700165311
# 700161872 700172555
#700106946 700171390
# python plot_stats.py --sample_id NoAbx_Participant413 --end_index 1000 --species Bacteroides_vulgatus_57955 --study SuezMontassier --calc_type Regular --statistic pi --cov_min 4 --custom
## python plot_stats.py --sample_id Multitissue_NoAbx_Participant413 --end_index 1000 --species Bacteroides_vulgatus_57955 --study SuezMontassier --calc_type Regular --statistic pi --cov_min 4 --custom --local
## python plot_stats.py --sample_id Multitissue_NoAbx_Participant420 --end_index 100 --species Sutterella_wadsworthensis_56828 --study SuezMontassier --calc_type Regular --statistic pi --cov_min 4 --custom --local
# python plot_stats.py --sample_id Stool1AntibioticsStool2_603 --sample_id2 Stool1AntibioticsStool2_603 --end_index 1000 --species Bacteroides_vulgatus_57955 --study SuezMontassier --calc_type Schloissnig --statistic Fst --cov_min 4 --custom --local


#Multitissue_NoAbx_Participant420

# same host
#python plot_stats.py --sample_id 700117303 --sample_id2 700173483 --end_index 2000 --species Bacteroides_vulgatus_57955 --study HMP --calc_type allel --statistic Fst --cov_min 4
# focal method
#python plot_stats.py --sample_id 700117303 --end_index 100 --species Bacteroides_vulgatus_57955 --study HMP --calc_type allel --statistic Fst --cov_min 4
##python plot_stats.py --sample_id 700117303 --end_index 100 --species Bacteroides_vulgatus_57955 --study HMP --calc_type Schloissnig --statistic Fst --cov_min 4
#700114911
#python plot_stats.py --sample_id 700114911 --end_index 4717498 --species Bacteroides_uniformis_57318 --study HMP --calc_type Schloissnig --statistic Fst --cov_min 4

#python plot_stats.py --sample_id 700117303 --sample_id2 700173483 --end_index 30 --species Bacteroides_vulgatus_57955 --study HMP --calc_type Schloissnig --statistic Fst --cov_min 4

#python plot_stats.py --sample_id 700013588 --sample_id2 700013597 --end_index 5163190 --species Bacteroides_vulgatus_57955 --study HMP --calc_type Schloissnig --statistic Fst --cov_min 4
if __name__ == "__main__":
    main()
