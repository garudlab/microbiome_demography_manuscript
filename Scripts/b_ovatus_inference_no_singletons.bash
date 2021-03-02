#!/bin/bash
#$ -cwd
#$ -V
#$ -m ea
#$ -l h_data=5G
#$ -l h_rt=02:00:00

# This script infers the demography of a given example synonymous sfs.

python fit_demographic_model.py ../Data/Bacteroides_ovatus_58035_syn.sfs ../Analysis/Bacteroides_ovatus_58035_no_singletons/ --mask_singletons
