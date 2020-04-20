#!/bin/bash
#$ -l highp,h_rt=50:00:00,h_data=6G
#$ -pe shared 4
#$ -N moose_GenotypeGVCFs
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/08_GenotypeGVCFs/
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/08_GenotypeGVCFs/
#$ -M ckyriazi



# This script is for all chromosomes (autosomes, X, MT)

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK="/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar"

REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/hogdeer_reference/GCA_003798545.1_ASM379854v1_genomic.fna

BED=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/hogdeer_reference/hog_deer_scaffold_groups/scaffold_${SGE_TASK_ID}.bed


OutDir=$1

AllIndividuals=(IR3925 IR3927 IR3928 IR3929 IR3931 MN31 MN41 MN54 MN96)

java -jar -Xmx16G ${GATK} \
-T GenotypeGVCFs \
-R ${REFERENCE} \
-allSites \
-stand_call_conf 0 \
-L ${BED} \
$(for Individual in "${AllIndividuals[@]}"; do echo "-V /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/07_GATKHC/${Individual}/${Individual}_${SGE_TASK_ID}_GATK_HC.g.vcf.gz"; done) \
-o ${OutDir}/9Moose_joint_${SGE_TASK_ID}.vcf.gz
