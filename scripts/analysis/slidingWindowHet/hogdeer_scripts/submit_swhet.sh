#!/bin/bash
#$ -l h_rt=24:00:00,h_data=4G
#$ -pe shared 4
#$ -N swHet
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/slidingWindowHet/hogdeer_scripts/runfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/slidingWindowHet/hogdeer_scripts/runfiles
#$ -M ckyriazi






# EXAMPLE USAGE:
# SCRIPT=/wynton/home/walllab/robinsonj/project/scripts/SlidingWindowHet/SlidingWindowHet_20190910_submit_condor_20190910.sh
# cd /wynton/scratch/robinsonj/condor/Filter/condor_joint_3
# cp /wynton/home/walllab/robinsonj/project/condor/reference/chrom_lengths.txt .
# NUMJOBS=30
# qsub -t 1-${NUMJOBS} ${SCRIPT}

. /u/local/Modules/default/init/modules.sh
module load python/2.7

SCRIPT=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/slidingWindowHet/hogdeer_scripts/SlidingWindowHet.py
INDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/genotyping_pipeline/11_FilterVCFfile
CHROM=$(cut -f1 chrom_lengths.txt | head -n ${SGE_TASK_ID} | tail -n 1 )
SG=${SGE_TASK_ID}
VCF=${INDIR}/9Moose_joint_FilterB_Round2_${SG}.vcf.gz

python ${SCRIPT} ${VCF} 1000000 1000000 ${CHROM}

mv ${INDIR}/9Moose_joint_FilterB_Round2_${SG}*txt /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/analysis/slidingWindowHet

