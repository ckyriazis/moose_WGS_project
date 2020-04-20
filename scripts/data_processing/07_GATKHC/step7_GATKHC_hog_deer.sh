#!/bin/bash
#$ -l highp,h_rt=48:00:00,h_data=12G
#$ -pe shared 2
#$ -N moose_GATKHC
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/07_GATKHC/
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/07_GATKHC/
#$ -M ckyriazi



# This script is for all chromosomes

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK="/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar"

#REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/hogdeer_reference/GCA_003798545.1_ASM379854v1_genomic.fna
BED=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/hogdeer_reference/hog_deer_scaffold_groups/scaffold_${SGE_TASK_ID}.bed


Individual=$1
BamDir=$2
OutDir=$3

java -jar -Xmx16G ${GATK} \
-T HaplotypeCaller \
-R ${REFERENCE} \
-ERC BP_RESOLUTION \
-mbq 20 \
-mmq 20 \
-out_mode EMIT_ALL_SITES \
--dontUseSoftClippedBases \
-L ${BED} \
-I ${BamDir}/${Individual}/${Individual}_RemoveBadReads.bam \
-o ${OutDir}/${Individual}/${Individual}_${SGE_TASK_ID}_GATK_HC.g.vcf.gz
