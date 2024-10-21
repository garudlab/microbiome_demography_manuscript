#!/bin/bash
#$ -cwd
#$ -V
#$ -m a
#$ -l h_data=15G
#$ -l h_rt=00:10:00
#$ -t 1-14
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N summary_statistics_for_peter

# SGE_TASK_ID=1

i=0
while read line;
do
  i=$((i+1))
  if [ $i -eq $SGE_TASK_ID ]
   then
     species=$line
  fi
done < ./species_list_for_peter.txt

python return_theta_and_pi_per_bp.py ../Analysis/${species}_downsampled_14/core_empirical_syn_downsampled_sfs.txt ./$species
