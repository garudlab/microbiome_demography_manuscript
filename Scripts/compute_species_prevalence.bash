#!/bin/bash
#$ -N MIDAS_snps.bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -l h_data=15G
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l time=0:10:00

i=0
while read line;
do
   i=$((i+1))
   file=$line
   # OUTDIR=../Data/microbiome_data/snps/${file}
   INDIR=/u/project/ngarud/Garud_lab/metagenomic_fastq_files/HMP1_2_Kuleshov_Qin_Twins_Korpela/snps/${file}
   echo -n $file >> ../Summary/HighRecombination_species_prevalence.txt
   echo -n ", " >> ../Summary/HighRecombination_species_prevalence.txt
   bzcat ${INDIR}/snps_ref_freq.txt.bz2 | head -n1 | uniq -c | wc -w >> ../Summary/HighRecombination_species_prevalence.txt
# done < ../Data/microbiome_data/snps/species_snps_list.txt
done < /u/project/ngarud/Garud_lab/metagenomic_fastq_files/HMP1_2_Kuleshov_Qin_Twins_Korpela/snps/species_snps.txt

# echo $file >> ../Summary/species_prevalence.txt
# bzcat ${OUTDIR}/snps_ref_freq.txt.bz2 | head -n1 | uniq -c | wc -w >> ../Summary/species_prevalence.txt
