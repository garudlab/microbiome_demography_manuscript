"""
Summarizes the average pi values per sample across species and populations.

JCM 20211118
"""


import sys
import os
import logging
import time
import argparse
import warnings

import numpy
import bz2
import pandas as pd
sys.path.insert(0, '../microbiome_evolution-master')
import diversity_utils
import parse_midas_data as pmd

class ArgumentParserNoArgHelp(argparse.ArgumentParser):
    """Like *argparse.ArgumentParser*, but prints help when no arguments."""

    def error(self, message):
        """Print error message, then help."""
        sys.stderr.write('error: %s\n\n' % message)
        self.print_help()
        sys.exit(2)


class ComputeDownSampledSFS():
    """Wrapper class to allow functions to reference each other."""

    def ExistingFile(self, fname):
        """Return *fname* if existing file, otherwise raise ValueError."""
        if os.path.isfile(fname):
            return fname
        else:
            raise ValueError("%s must specify a valid file name" % fname)

    def computeDownSampledSFSParser(self):
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

    def main(self):
        """Execute main function."""
        # Parse command line arguments
        parser = self.computeDownSampledSFSParser()
        args = vars(parser.parse_args())
        prog = parser.prog

        # Assign arguments
        outprefix = args['outprefix']
        species = args['species']

        # Numpy options
        numpy.set_printoptions(linewidth=numpy.inf)

        # Output files: logfile, snp_matrix.csv
        # Remove output files if they already exist
        underscore = '' if args['outprefix'][-1] == '/' else '_'
        output_matrix = \
            '{0}{1}{2}_downsampled_sfs.csv'.format(
                args['outprefix'], underscore, species)

        core_genes = pmd.load_core_genes(species)
        print(core_genes)
        print('test1')
        desired_samples, allele_counts_map, passed_sites_map, final_line_number = pmd.parse_snps(species, allowed_genes=core_genes)
        allowed_genes = set(passed_sites_map.keys())
        print(allele_counts_map.values()[0])

        allowed_sample_idxs = numpy.array([True for i in xrange(0,allele_counts_map.values()[0].values()[0]['alleles'].shape[1])])

        print(allowed_sample_idxs)
     
        allowed_genes = set(passed_sites_map.keys())
        allowed_genes = allowed_genes & set(passed_sites_map.keys())        
        for gene_name in allowed_genes:
        
            for variant_type in allele_counts_map[gene_name].keys():
            
                # if variant_type not in allowed_variant_types:
                #     continue
                
                allele_counts = allele_counts_map[gene_name][variant_type]['alleles']
        
                if len(allele_counts)==0:
                    continue
            
            print(allele_counts_map[gene_name][variant_type]['alleles'].shape)
            # print allowed_sample_idxs.shape
                
            # allele_counts = allele_counts[:,allowed_sample_idxs.astype(int),:]
            
            genotype_matrix, passed_sites_matrix = diversity_utils.calculate_consensus_genotypes(allele_counts)

        print('test2')


if __name__ == '__main__':
    ComputeDownSampledSFS().main()
