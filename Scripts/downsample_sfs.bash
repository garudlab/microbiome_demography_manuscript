#!/bin/bash
#$ -N downsample_sfs.bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:20:00
#$ -t 1-30

i=0
while read line;
do
   i=$((i+1))
   if [ $i -eq $SGE_TASK_ID ]
   then
      species=$line
   fi
done < ../Data/good_species_list.txt

# sample_size=14

python downsample_sfs.py ../Analysis/${species}/empirical_syn_sfs.txt 14 ../Analysis/${species}_downsampled_14/empirical_syn
python downsample_sfs.py ../Analysis/${species}/core_empirical_syn_sfs.txt 14 ../Analysis/${species}_downsampled_14/core_empirical_syn
python downsample_sfs.py ../Analysis/${species}/accessory_empirical_syn_sfs.txt 14 ../Analysis/${species}_downsampled_14/accessory_empirical_syn

python downsample_sfs.py ../Analysis/${species}/empirical_nonsyn_sfs.txt 14 ../Analysis/${species}_downsampled_14/empirical_nonsyn
python downsample_sfs.py ../Analysis/${species}/core_empirical_nonsyn_sfs.txt 14 ../Analysis/${species}_downsampled_14/core_empirical_nonsyn
python downsample_sfs.py ../Analysis/${species}/accessory_empirical_nonsyn_sfs.txt 14 ../Analysis/${species}_downsampled_14/accessory_empirical_nonsyn
