#!/bin/bash
#$ -cwd
#$ -V
#$ -m a
#$ -l h_data=50G
#$ -l h_rt=12:00:00
#$ -l highp
#$ -t 21
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N fit_dfe_FD_accessory

SGE_TASK_ID=21
#### Python 3
# i=0
# while read line;
# do
#   i=$((i+1))
#   if [ $i -eq $SGE_TASK_ID ]
#    then
#      species=$line
#   fi
# done < ../Data/good_species_list.txt

# i=0
# while read line;
# do
#   i=$((i+1))
#   if [ $i -eq $SGE_TASK_ID ]
#     then
#       species=$line
#   fi
# done < ../HighRecombinationData/good_species_list.txt

i=0
while read line;
do
  i=$((i+1))
  if [ $i -eq $SGE_TASK_ID ]
   then
     species=$line
  fi
done < ../SupplementaryAnalysis/supplementary_species_list.txt

sample_size=14


# Core FD
# python fit_dfe.py ../SupplementaryAnalysis/${species}/core_empirical_syn_downsampled_sfs.txt ../SupplementaryAnalysis/${species}/core_empirical_nonsyn_downsampled_sfs.txt ../SupplementaryAnalysis/${species}/two_epoch_demography.txt two_epoch ../SupplementaryAnalysis/${species}/core

# Accessory FD
# python fit_dfe.py ../SupplementaryAnalysis/${species}/accessory_empirical_syn_downsampled_sfs.txt ../SupplementaryAnalysis/${species}/accessory_empirical_nonsyn_downsampled_sfs.txt ../SupplementaryAnalysis/${species}/accessory_two_epoch_demography.txt two_epoch ../SupplementaryAnalysis/${species}/accessory

# HR core
# python fit_dfe.py ../HighRecombinationAnalysis/${species}/core_0.5_empirical_syn_14_downsampled_sfs.txt ../HighRecombinationAnalysis/${species}/core_0.5_empirical_nonsyn_14_downsampled_sfs.txt ../HighRecombinationAnalysis/${species}/core_0.5_two_epoch_demography.txt two_epoch ../HighRecombinationAnalysis/${species}/core_0.5
