#!/bin/bash
#$ -N compute_pangenome_size
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -cwd
#$ -V
#$ -l h_data=25G
#$ -l h_rt=3:50:00
#$ -l highp
#$ -t 1:30

# SGE_TASK_ID=1

readarray good_spec < ../Data/good_species_list.txt

good_spec=( null ${good_spec[@]} )

python compute_pangenome_size.py ${good_spec[$SGE_TASK_ID]} ../Analysis/${good_spec[$SGE_TASK_ID]}/
# python compute_pangenome_size.py ${good_spec[$SGE_TASK_ID]} ../Analysis/${good_spec[$SGE_TASK_ID]}/ --core
# python compute_pangenome_size.py ${good_spec[$SGE_TASK_ID]} ../Analysis/${good_spec[$SGE_TASK_ID]}/ --accessory
