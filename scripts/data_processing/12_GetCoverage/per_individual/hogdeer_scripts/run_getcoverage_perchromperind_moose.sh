#!/bin/bash
#$ -l highp,h_rt=24:00:00,h_data=2G
#$ -pe shared 1
#$ -N covMoose
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/12_GetCoverage
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/12_GetCoverage
#$ -M ckyriazi



. /u/local/Modules/default/init/modules.sh
module load python/2.7.13_shared

python getcoverage_perchromperind_moose.py ${SGE_TASK_ID}
sleep 200s

