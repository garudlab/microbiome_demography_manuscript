"""
Parses the haplotypes catalogue from UHGG to an SFS formatted for Dadi.

JCM 20230303
"""


import sys
import os
import logging
import time
import argparse
import warnings
import random

import pandas as pd
import numpy as np


class ArgumentParserNoArgHelp(argparse.ArgumentParser):
    """Like *argparse.ArgumentParser*, but prints help when no arguments."""

    def error(self, message):
        """Print error message, then help."""
        sys.stderr.write('error: %s\n\n' % message)
        self.print_help()
        sys.exit(2)


class ParseSnpsCatalogues():
    """Wrapper class to allow functions to reference each other."""

    def ExistingFile(self, fname):
        """Return *fname* if existing file, otherwise raise ValueError."""
        if os.path.isfile(fname):
            return fname
        else:
            raise ValueError("%s must specify a valid file name" % fname)

    def ParseSnpsCataloguesParser(self):
        """Return *argparse.ArgumentParser* for ``fitdadi_infer_DFE.py``."""
        parser = ArgumentParserNoArgHelp(
            description=(
                'Parses a given `*.snps catalogue` file into human-readable format.'),
            formatter_class=argparse.ArgumentDefaultsHelpFormatter)
        parser.add_argument(
            'input_haplotype_catalogue', type=self.ExistingFile,
            help='The input `*.snps catalogue` file output by MUMmer.')
        parser.add_argument(
            'input_clade_identification', type=self.ExistingFile,
            help='The input manual clade identification  `.txt` file')
        parser.add_argument(
            'species', type=str,
            help='The species for which we are parsing haplotypes')
        parser.add_argument(
            'outprefix', type=str,
            help='The file prefix for the output files.')
        return parser

    def main(self):
        """Execute main function."""
        # Parse command line arguments
        parser = self.ParseSnpsCataloguesParser()
        args = vars(parser.parse_args())
        prog = parser.prog

        # Assign arguments
        input_haplotype_catalogue  = args['input_haplotype_catalogue']
        input_clade = args['input_clade_identification']
        species = args['species']
        outprefix = args['outprefix']

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
        output_sfs = \
            '{0}{1}output_sfs.txt'.format(
                args['outprefix'], underscore)
        logfile = '{0}{1}parse_haplotype_catalogue.log'.format(args['outprefix'], underscore)
        to_remove = [logfile, output_sfs]
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

        # Initialize dict object for snps catalogue
        sfs_dict = {}

        # with open(input_clade, 'r') as f:
        input_clade = open(input_clade, 'r')
        lines = input_clade.readlines()


        max_clade_size = 0
        species_bool = False
        this_clade = []

        for line in lines:
            if '--------'  in line:
                if len(this_clade) > max_clade_size:
                    largest_clade = this_clade.copy()
                    max_clade_size = len(largest_clade)
                    del this_clade
                    this_clade = []
            elif line.count(" ") == 0 and line.strip() == species:
                species_bool = True
                this_clade = []
            elif line.count(" ") == 0 and line.strip() != species:
                species_bool = False
            else:
                if species_bool:
                    this_clade.append(line.split()[1].strip())

        input_clade.close()

        logger.info('Parsing input snps catalogue.')
        # Open snps catalogue
        df = pd.read_csv(input_haplotype_catalogue, na_values='')
        df = df.drop(columns=['site_pos'])
        df = df[df.site_type == 'syn']
        # Set index based on first four rows
        df.set_index(['contig', 'gene_id', 'site_type'], inplace=True)

        # Dropping columns unrelated to largest clade
        df = df[df.columns.intersection(largest_clade)]
        logger.info('The largest clade has ' + str(max_clade_size) + ' hosts.')
        logger.info('Subsetting pandas dataframe to ' + str(len(df.columns)) + ' hosts.')
        nrows = len(df.index)

        logger.info('Computing SFS.')
        for i in range(nrows):
            this_snp_count = df.iloc[i].sum()
            if this_snp_count in sfs_dict.keys():
                sfs_dict[this_snp_count] += 1
            else:
                sfs_dict[this_snp_count] = 1

        logger.info('Formatting SFS.')

        # Max bins for the dictionary
        max_bins =  int(len(df.axes[1]))
        num_bins = max_bins + 1 # For Dadi formatting, which includes 0-tons
        sfs_list = []
        mask_list = [1] + [0] * max_bins # For Dadi formatting
        for i in range(num_bins):
            if float(i) in sfs_dict.keys():
                sfs_list.append(sfs_dict[float(i)])
            else:
                sfs_list.append(0)

        logger.info('Outputting SFS.')

        with open(output_sfs, 'w') as f:
            f.write((str(num_bins)  + ' unfolded "output_sfs"\n'))
            f.write(' '.join(map(str, sfs_list)) + '\n')
            f.write(' '.join(map(str, mask_list)) +'\n')

        logger.info('Pipeline executed successfully.')


if __name__ == '__main__':
    ParseSnpsCatalogues().main()
