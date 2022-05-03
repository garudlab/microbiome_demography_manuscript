#!/bin/bash
#$ -cwd
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=36:00:00
#$ -l highp

# This script infers the demography of a given example synonymous sfs.

python fit_one_epoch.py ../Data/Bacteroides_fragilis_54507_syn.sfs  ../Analysis/Bacteroides_fragilis_54507/ --mask_singletons

# two_epoch and exponential
# upper_bound = [8, 0.00005]
# lower_bound = [0, 0]
# initial_guess = [0.1, 0.00001]

