#!/bin/bash
#$ -N MIDAS_genes.bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -l h_data=15G
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l time=24:00:00
#$ -l highp
#$ -t 293

# SGE_TASK_ID=1

# module load python/2.7
export PYTHONPATH=$PYTHONPATH:/u/project/ngarud/Garud_lab/MIDAS
export PATH=$PATH:/u/project/ngarud/Garud_lab/MIDAS/scripts
export MIDAS_DB=/u/project/ngarud/Garud_lab/midas_db_v1.2

# SGE_TASK_ID=1

i=0
while read line;
do
   i=$((i+1))
   # echo $line
   if [ $i -eq $SGE_TASK_ID ]
   then
      file=$line
   fi
done < ./oral_file_list.txt

OUTDIR=../Data/oral_microbiome_data/midas_output/${file}
INDIR=../Data/oral_microbiome_data/fastq_MIDAS_intermediate/${file}


if [ ! -d $OUTDIR/genes ]
then
    mkdir $OUTDIR/genes
fi


file_1=${INDIR}/${file}.denovo_duplicates_marked.trimmed.1.fastq.gz
file_2=${INDIR}/${file}.denovo_duplicates_marked.trimmed.2.fastq.gz
species_union=../Data/oral_microbiome_data/species_union/${file}/species_union.txt


# module load python/2.7.18
# module load midas
# . /u/local/apps/midas/1.3.2/python-2.7.18-MIDAS-VE/bin/activate

singularity exec $H2_CONTAINER_LOC/MIDAS-mod.sif run_midas.py genes $OUTDIR -1 $file_1 -2 $file_2 --extra_species_file $species_union --remove_temp

# run_midas.py genes $OUTDIR -1 ${file_1} -2 ${file_2} --extra_species_file $species_union --remove_temp
