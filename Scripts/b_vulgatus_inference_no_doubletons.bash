#!/bin/bash
#$ -cwd
#$ -V
#$ -m ea
#$ -l h_data=5G
#$ -l h_rt=02:00:00

# This script infers the demography of a given example synonymous sfs.

python fit_demographic_model.py ../Data/Bacteroides_vulgatus_57955_syn.sfs ../Analysis/Bacteroides_vulgatus_57955_no_doubletons/ --mask_singletons --mask_doubletons