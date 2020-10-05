#!/bin/bash
#$ -l highp,h_rt=8:00:00,h_data=8G
#$ -pe shared 3
#$ -N moose_MarkAdapters
#$ -cwd
#$ -o /u/flashscratch/c/ckyriazi/moose/output/02_MarkAdapters/
#$ -e /u/flashscratch/c/ckyriazi/moose/output/02_MarkAdapters/
#$ -m bea
#$ -M ckyriazi

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

Individual=$1
BamDir=$2
OutDir=$3

java -jar /u/local/apps/picard-tools/2.9.0/picard.jar MarkIlluminaAdapters \
I=${BamDir}/${Individual}/${Individual}_FastqToSam.bam \
O=${OutDir}/${Individual}/${Individual}_MarkAdapters.bam \
M=${OutDir}/${Individual}/${Individual}_MarkAdapters.bam_metrics.txt


