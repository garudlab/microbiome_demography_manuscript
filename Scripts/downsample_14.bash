#!/bin/bash
#$ -cwd
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=25G
#$ -l h_rt=02:00:00
#$ -t 1-41
#$ -N compute_downsample_14

# SGE_TASK_ID=1

# i=0
# while read line;
# do
#    i=$((i+1))
#    if [ $i -eq $SGE_TASK_ID ]
#    then
#       species=$line
#    fi
# done < ../Data/good_species_list.txt

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

python compute_downsampled_sfs.py ${species} ../SupplementaryAnalysis/${species} ${sample_size}
