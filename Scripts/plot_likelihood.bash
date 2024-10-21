#!/bin/bash
#$ -cwd
#$ -V
#$ -N supplementary_likelihood
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_rt=8:00:00
#$ -l highp
#$ -t 1-40

# SGE_TASK_ID=1

# Complete SFS
# i=0
# while read line;
#   do
#     i=$((i+1))
#     # echo $line
#     if [ $i -eq $SGE_TASK_ID ]; then
#         species=$line
#     fi
# done < ../Data/good_species_list.txt

# Complete SFS
# i=0
# while read line;
#   do
#     i=$((i+1))
#     # echo $line
#     if [ $i -eq $SGE_TASK_ID ]; then
#         species=$line
#     fi
# done < ../HighRecombinationData/good_species_list.txt

# Supplementary species
i=0
while read line;
  do
    i=$((i+1))
    # echo $line
    if [ $i -eq $SGE_TASK_ID ]; then
      species=$line
    fi
done < ../SupplementaryAnalysis/supplementary_species_list.txt

# python plot_likelihood.py ../Analysis/${species}_downsampled_14/core_empirical_syn_downsampled_sfs.txt ../Analysis/${species}_downsampled_14/core_two_epoch_demography.txt ../Analysis/${species}_downsampled_14/core
# python plot_likelihood.py ../Analysis/${species}_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt ../Analysis/${species}_downsampled_14/accessory_two_epoch_demography.txt ../Analysis/${species}_downsampled_14/accessory
# python plot_likelihood.py ../HighRecombinationAnalysis/${species}/core_0.5_empirical_syn_14_downsampled_sfs.txt ../HighRecombinationAnalysis/${species}/core_0.5_two_epoch_demography.txt ../HighRecombinationAnalysis/${species}/
# python plot_likelihood.py ../SupplementaryAnalysis/${species}/core_empirical_syn_downsampled_sfs.txt ../SupplementaryAnalysis/${species}/two_epoch_demography.txt ../SupplementaryAnalysis/${species}/
python plot_likelihood.py ../SupplementaryAnalysis/${species}/accessory_empirical_syn_downsampled_sfs.txt ../SupplementaryAnalysis/${species}/accessory_two_epoch_demography.txt ../SupplementaryAnalysis/${species}/accessory
