#!/bin/bash
#$ -cwd
#$ -V
#$ -m a
#$ -l h_data=25G
#$ -l h_rt=72:00:00
#$ -l highp
#$ -t 27-40
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N constant_s

# SGE_TASK_ID=27

i=0
while read line;
do
  i=$((i+1))
  if [ $i -eq $SGE_TASK_ID ]
   then
     species=$line
  fi
done < ../SupplementaryAnalysis/supplementary_species_list.txt

# python cross_species_dfe_inference.py ../Analysis/${species}_downsampled_14/core_two_epoch_demography.txt ../Analysis/${species}_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt ../Analysis/cross_species_dfe/
# python cross_species_dfe_inference.py ../Analysis/${species}_downsampled_14/core_three_epoch_demography.txt ../Analysis/${species}_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt ../Analysis/cross_species_dfe/
# python cross_species_dfe_inference.py ../Analysis/${species}_downsampled_14/accessory_two_epoch_demography.txt ../Analysis/${species}_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt ../Analysis/accessory_cross_species_dfe/

# python cross_species_dfe_inference.py ../SupplementaryAnalysis/${species}/two_epoch_demography.txt ../SupplementaryAnalysis/${species}/core_empirical_nonsyn_downsampled_sfs.txt ../SupplementaryAnalysis/cross_species_dfe/
# python cross_species_dfe_inference.py ../SupplementaryAnalysis/${species}/accessory_two_epoch_demography.txt ../SupplementaryAnalysis/${species}/accessory_empirical_nonsyn_downsampled_sfs.txt ../SupplementaryAnalysis/accessory_cross/

python constant_s_dfe.py ../SupplementaryAnalysis/${species}/two_epoch_demography.txt ../SupplementaryAnalysis/${species}/core_empirical_syn_downsampled_sfs.txt ../SupplementaryAnalysis/${species}/core_empirical_nonsyn_downsampled_sfs.txt ../SupplementaryAnalysis/cross_species_dfe/
# python constant_s_dfe.py ../SupplementaryAnalysis/${species}/accessory_two_epoch_demography.txt ../SupplementaryAnalysis/${species}/accessory_empirical_syn_downsampled_sfs.txt ../SupplementaryAnalysis/${species}/accessory_empirical_nonsyn_downsampled_sfs.txt ../SupplementaryAnalysis/accessory_constant_s/
