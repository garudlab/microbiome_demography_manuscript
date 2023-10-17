#!/bin/bash
#$ -cwd
#$ -V
#$ -m a
#$ -l h_data=25G
#$ -l h_rt=12:00:00
#$ -l highp
#$ -t 1-30
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N fit_dfe

# SGE_TASK_ID=27

i=0
while read line;
do
  i=$((i+1))
  if [ $i -eq $SGE_TASK_ID ]
   then
     species=$line
  fi
done < ../Data/good_species_list.txt

sample_size=14

# python fit_dfe.py ../Analysis/${species}_downsampled_${sample_size}/core_empicial_syn_downsampled_sfs.txt ../Analysis/${species}_downsampled_${sample_size}/core_empirical_nonsyn_downsampled_sfs.txt ../Analysis/${species}_downsampled_${sample_size}/core_one_epoch_demography.txt one_epoch ../Analysis/${species}_downsampled_${sample_size}/core
# python fit_dfe.py ../Analysis/${species}_downsampled_${sample_size}/core_empirical_syn_downsampled_sfs.txt ../Analysis/${species}_downsampled_${sample_size}/core_empirical_nonsyn_downsampled_sfs.txt ../Analysis/${species}_downsampled_${sample_size}/core_two_epoch_demography.txt two_epoch ../Analysis/${species}_downsampled_${sample_size}/core
# python fit_dfe.py ../Analysis/${species}_downsampled_${sample_size}/core_empirical_syn_downsampled_sfs.txt ../Analysis/${species}_downsampled_${sample_size}/core_empirical_nonsyn_downsampled_sfs.txt ../Analysis/${species}_downsampled_${sample_size}/core_three_epoch_demography.txt three_epoch ../Analysis/${species}_downsampled_${sample_size}/core
# python fit_dfe.py ../Analysis/${species}_downsampled_${sample_size}/accessory_empirical_syn_downsampled_sfs.txt ../Analysis/${species}_downsampled_${sample_size}/accessory_empirical_nonsyn_downsampled_sfs.txt ../Analysis/${species}_downsampled_${sample_size}/accessory_two_epoch_demography.txt two_epoch ../Analysis/${species}_downsampled_${sample_size}/accessory
