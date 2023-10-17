#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=20G
#$ -l h_rt=2:00:00
#$ -t 1-30
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N fit_demographic_model_gut_accessory

# SGE_TASK_ID=1

i=0
while read line;
do
  i=$((i+1))
  if [ $i -eq $SGE_TASK_ID ]
    then
      species=$line
  fi
done < ../Data/good_species_list.txt

### Comment out the appropriate line to perform analysis over core genes vs. over accessory genes

# Core genes
# python fit_demographic_model.py ../Analysis/${species}_downsampled_14/core_empirical_syn_downsampled_sfs.txt ../Analysis/${species}_downsampled_14/core

# Accessory genes
# python fit_demographic_model.py ../Analysis/${species}_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt ../Analysis/${species}_downsampled_14/accessory
