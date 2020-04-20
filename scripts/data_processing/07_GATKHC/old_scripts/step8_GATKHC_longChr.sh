#!/bin/bash
#$ -l highp,h_rt=150:00:00,h_data=6G
#$ -pe shared 4
#$ -N caracals_GATKHG
#$ -cwd
#$ -m bea
#$ -o /u/flashscratch/c/ckyriazi/caracals/analyses/step8_GATKHG/
#$ -e /u/flashscratch/c/ckyriazi/caracals/analyses/step8_GATKHG/
#$ -M ckyriazi



# This script is for re-running long chromosomes that timed out

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK="/u/home/c/ckyriazi/kirk-bigdata/software/gatk_37/GenomeAnalysisTK.jar"

REFERENCE=/u/flashscratch/c/ckyriazi/caracals/reference/GCF_000181335.3_Felis_catus_9.0_genomic.fna


if [ $SGE_TASK_ID == 1 ]
then
	Chrom=NC_018726.3
elif [ $SGE_TASK_ID == 2 ]
then    
        Chrom=NC_018731.3
fi


Individual=$1
BamDir=$2
OutDir=$3

java -jar -Xmx16G ${GATK} \
-T HaplotypeCaller \
-R ${REFERENCE} \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
--dontUseSoftClippedBases \
-L ${Chrom} \
-I ${BamDir}/${Individual}/${Individual}_BQSR_round1_recal.bam \
-o ${OutDir}/${Individual}/${Individual}_${Chrom}_GATK_HC.g.vcf.gz
