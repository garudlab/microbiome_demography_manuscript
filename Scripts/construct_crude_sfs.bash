#!/bin/bash
#$ -N construct_crude_sfs.bash
#$ -cwd # Run qsub script from desired working directory
#$ -l highp
#$ -l h_data=25G
#$ -l time=00:05:00
#$ -m be

python construct_crude_sfs.py ../Data/oral_microbiome_data/merged_data/snps/ Veillonell_parvul_57794 --min_depth 2 ../Data/oral_microbiome_data/Veillonella_parvula_57794_sfs
