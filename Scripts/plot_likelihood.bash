#!/bin/bash
#$ -cwd
#$ -V
#$ -N accessory_likelihood
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=12:00:00
#$ -l highp
#$ -t 29

# SGE_TASK_ID=1

# Complete SFS
i=0
while read line;
  do
    i=$((i+1))
    # echo $line
    if [ $i -eq $SGE_TASK_ID ]; then
        species=$line
    fi
done < ../Data/good_species_list.txt

python plot_likelihood.py ../Analysis/${species}_downsampled_14/core_empirical_syn_downsampled_sfs.txt ../Analysis/${species}_downsampled_14/core_two_epoch_demography.txt ../Analysis/${species}_downsampled_14/core
# python plot_likelihood.py ../Analysis/${species}_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt ../Analysis/${species}_downsampled_14/accessory_two_epoch_demography.txt ../Analysis/${species}_downsampled_14/accessory
