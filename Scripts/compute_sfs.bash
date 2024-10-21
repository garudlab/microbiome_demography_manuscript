#!/bin/bash
#$ -N compute_sfs_supplementary
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -cwd
#$ -V
#$ -l h_data=25G
#$ -l h_rt=2:00:00
#$ -t 1:40

# SGE_TASK_ID=2

# readarray good_spec < ../Data/good_species_list.txt
# readarray good_spec < ../HighRecombinationData/good_species_list.txt
readarray good_spec < ../SupplementaryAnalysis/supplementary_species_list.txt
good_spec=( null ${good_spec[@]} )

# python compute_sfs.py ${good_spec[$SGE_TASK_ID]} ../Analysis/${good_spec[$SGE_TASK_ID]}/
# python compute_sfs.py ${good_spec[$SGE_TASK_ID]} ../HighRecombinationAnalysis/${good_spec[$SGE_TASK_ID]}/ --core
# python compute_sfs.py ${good_spec[$SGE_TASK_ID]} ../Analysis/${good_spec[$SGE_TASK_ID]}/ --accessory
# echo ${good_spec[SGE_TASK_ID]}
# python compute_sfs.py ${good_spec[$SGE_TASK_ID]} ../SupplementaryAnalysis/${good_spec[$SGE_TASK_ID]}/ --core
python compute_sfs.py ${good_spec[$SGE_TASK_ID]} ../SupplementaryAnalysis/${good_spec[$SGE_TASK_ID]}/ --accessory
