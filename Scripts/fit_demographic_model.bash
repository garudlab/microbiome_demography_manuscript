#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=20G
#$ -l h_rt=2:00:00
#$ -t 1-39
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N fit_demographic_model

# SGE_TASK_ID=1

i=0
while read line;
do
  i=$((i+1))
  if [ $i -eq $SGE_TASK_ID ]
    then
      species=$line
  fi
done < ../SupplementaryAnalysis/supplementary_species_list.txt

### Comment out the appropriate line to perform analysis over core genes vs. over accessory genes


# High Recombination core
# python fit_one_epoch.py ../HighRecombinationAnalysis/${species}/core_0.5_empirical_syn_14_downsampled_sfs.txt ../HighRecombinationAnalysis/${species}/core_0.5

# Supplementary Analysis (FD) core and accessory
# python fit_one_epoch.py ../SupplementaryAnalysis/${species}/core_empirical_syn_downsampled_sfs.txt ../SupplementaryAnalysis/${species}/
# python fit_one_epoch.py ../SupplementaryAnalysis/${species}/accessory_empirical_syn_downsampled_sfs.txt ../SupplementaryAnalysis/${species}/accessory
