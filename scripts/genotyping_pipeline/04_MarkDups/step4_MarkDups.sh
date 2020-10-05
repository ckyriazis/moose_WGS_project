#!/bin/bash
#$ -l highp,h_rt=24:00:00,h_data=8G
#$ -pe shared 4
#$ -N moose_MarkDups
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/04_MarkDups/
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/04_MarkDups
#$ -M ckyriazi


PICARD=/u/local/apps/picard-tools/2.9.0/picard.jar

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

Individual=$1
InDir=$2
OutDir=$3

java -Xmx26G -jar ${PICARD} MarkDuplicates \
INPUT=${InDir}/${Individual}/${Individual}_AlignCleanBam.bam \
OUTPUT=${OutDir}/${Individual}/${Individual}_MarkDups.bam \
METRICS_FILE=${OutDir}/${Individual}/${Individual}_MarkDups.bam_metrics.txt \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
CREATE_INDEX=true \
