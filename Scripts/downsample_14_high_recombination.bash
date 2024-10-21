#!/bin/bash
#$ -cwd
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=25G
#$ -l h_rt=00:10:00
#$ -t 1-22
#$ -N downsample_14_high_recombination

# SGE_TASK_ID=1

i=0
while read line;
do
   i=$((i+1))
   if [ $i -eq $SGE_TASK_ID ]
   then
      species=$line
   fi
done < ../HighRecombinationData/good_species_list.txt

sample_size=14

python downsample_sfs.py ../HighRecombinationAnalysis/${species}/core_0.5_empirical_syn_sfs.txt ${sample_size} ../HighRecombinationAnalysis/${species}/core_0.5_empirical_syn_${sample_size}
python downsample_sfs.py ../HighRecombinationAnalysis/${species}/core_0.5_empirical_nonsyn_sfs.txt ${sample_size} ../HighRecombinationAnalysis/${species}/core_0.5_empirical_nonsyn_${sample_size}
