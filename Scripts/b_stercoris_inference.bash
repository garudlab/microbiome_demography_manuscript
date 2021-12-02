#!/bin/bash
#$ -cwd
#$ -V
#$ -m ea
#$ -l h_data=5G
#$ -l h_rt=02:00:00

# This script infers the demography of a given example synonymous sfs.

python fit_demographic_model.py ../Data/Bacteroides_stercoris_56735_syn.sfs  ../Analysis/Bacteroides_stercoris_56735/ --mask_singletons

# two_epoch and exponential
# upper_bound = [8, 0.00005]
# lower_bound = [0, 0]
# initial_guess = [0.1, 0.00001]
