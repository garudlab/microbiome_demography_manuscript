#!/bin/bash
#$ -N downsample_sfs.bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:20:00
#$ -t 1-40

# python downsample_sfs.py ../Data/UHGG/UHGG_Akkermansia_muciniphila_B/full_sfs.txt 14 ../Data/UHGG/UHGG_Akkermansia_muciniphila_B/
# python downsample_sfs.py ../Data/UHGG/UHGG_Alistipes_finegoldii/full_sfs.txt 14 ../Data/UHGG/UHGG_Alistipes_finegoldii/
# python downsample_sfs.py ../Data/UHGG/UHGG_Alistipes_onderdonkii/full_sfs.txt 14 ../Data/UHGG/UHGG_Alistipes_onderdonkii/
# python downsample_sfs.py ../Data/UHGG/UHGG_Alistipes_putredinis/full_sfs.txt 14 ../Data/UHGG/UHGG_Alistipes_putredinis/
# python downsample_sfs.py ../Data/UHGG/UHGG_Alistipes_shahii/full_sfs.txt 14 ../Data/UHGG/UHGG_Alistipes_shahii/
# python downsample_sfs.py ../Data/UHGG/UHGG_Bacteroides_fragilis/full_sfs.txt 14 ../Data/UHGG/UHGG_Bacteroides_fragilis/
# python downsample_sfs.py ../Data/UHGG/UHGG_Bacteroides_ovatus/full_sfs.txt 14 ../Data/UHGG/UHGG_Bacteroides_ovatus/
# python downsample_sfs.py ../Data/UHGG/UHGG_Bacteroides_stercoris/full_sfs.txt 14 ../Data/UHGG/UHGG_Bacteroides_stercoris/
# python downsample_sfs.py ../Data/UHGG/UHGG_Bacteroides_thetaiotaomicron/full_sfs.txt 14 ../Data/UHGG/UHGG_Bacteroides_thetaiotaomicron/
# python downsample_sfs.py ../Data/UHGG/UHGG_Bacteroides_xylanisolvens/full_sfs.txt 14 ../Data/UHGG/UHGG_Bacteroides_xylanisolvens/
# python downsample_sfs.py ../Data/UHGG/UHGG_Barnesiella_intestinihominis/full_sfs.txt 14 ../Data/UHGG/UHGG_Barnesiella_intestinihominis/
# python downsample_sfs.py ../Data/UHGG/UHGG_Dialister_invisus/full_sfs.txt 14 ../Data/UHGG/UHGG_Dialister_invisus/
# python downsample_sfs.py ../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/full_sfs.txt 14 ../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/
# python downsample_sfs.py ../Data/UHGG/UHGG_Odoribacter_splanchnicus/full_sfs.txt 14 ../Data/UHGG/UHGG_Odoribacter_splanchnicus/
# python downsample_sfs.py ../Data/UHGG/UHGG_Parabacteroides_distasonis/full_sfs.txt 14 ../Data/UHGG/UHGG_Parabacteroides_distasonis/
# python downsample_sfs.py ../Data/UHGG/UHGG_Parabacteroides_merdae/full_sfs.txt 14 ../Data/UHGG/UHGG_Parabacteroides_merdae/
# python downsample_sfs.py ../Data/UHGG/UHGG_Prevotella_copri/full_sfs.txt 14 ../Data/UHGG/UHGG_Prevotella_copri/
# python downsample_sfs.py ../Data/UHGG/UHGG_Ruminococcus_E_bromii_B/full_sfs.txt 14 ../Data/UHGG/UHGG_Ruminococcus_E_bromii_B/

# SGE_TASK_ID=1

i=0
while read line;
do
   i=$((i+1))
   if [ $i -eq $SGE_TASK_ID ]
   then
      species=$line
   fi
   # done < ../Data/good_species_list.txt
done < ../SupplementaryAnalysis/supplementary_species_list.txt
# sample_size=14

# python downsample_sfs.py ../Analysis/${species}/empirical_syn_sfs.txt 14 ../Analysis/${species}_downsampled_14/empirical_syn
# python downsample_sfs.py ../Analysis/${species}/core_empirical_syn_sfs.txt 14 ../Analysis/${species}_downsampled_14/core_empirical_syn
# python downsample_sfs.py ../Analysis/${species}/accessory_empirical_syn_sfs.txt 14 ../Analysis/${species}_downsampled_14/accessory_empirical_syn

# python downsample_sfs.py ../Analysis/${species}/empirical_nonsyn_sfs.txt 14 ../Analysis/${species}_downsampled_14/empirical_nonsyn
# python downsample_sfs.py ../Analysis/${species}/core_empirical_nonsyn_sfs.txt 14 ../Analysis/${species}_downsampled_14/core_empirical_nonsyn
# python downsample_sfs.py ../Analysis/${species}/accessory_empirical_nonsyn_sfs.txt 14 ../Analysis/${species}_downsampled_14/accessory_empirical_nonsyn

# python downsample_sfs.py ../SupplementaryAnalysis/${species}/core_empirical_syn_sfs.txt 14 ../SupplementaryAnalysis/${species}/core_empirical_syn
# python downsample_sfs.py ../SupplementaryAnalysis/${species}/core_empirical_nonsyn_sfs.txt 14 ../SupplementaryAnalysis/${species}/core_empirical_nonsyn

python downsample_sfs.py ../SupplementaryAnalysis/${species}/accessory_empirical_syn_sfs.txt 14 ../SupplementaryAnalysis/${species}/accessory_empirical_syn
python downsample_sfs.py ../SupplementaryAnalysis/${species}/accessory_empirical_nonsyn_sfs.txt 14 ../SupplementaryAnalysis/${species}/accessory_empirical_nonsyn
