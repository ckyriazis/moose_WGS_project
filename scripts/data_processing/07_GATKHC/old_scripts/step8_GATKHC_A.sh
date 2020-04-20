#!/bin/bash
#$ -l highp,h_rt=14:00:00,h_data=24G
#$ -pe shared 4
#$ -N caracals_GATKHG
#$ -cwd
#$ -m bea
#$ -o /u/flashscratch/c/ckyriazi/caracals/analyses/step8_GATKHG/
#$ -e /u/flashscratch/c/ckyriazi/caracals/analyses/step8_GATKHG/
#$ -M ckyriazi



# This script is for the autosomes

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK="/u/home/c/ckyriazi/kirk-bigdata/software/gatk_37/GenomeAnalysisTK.jar"

REFERENCE=/u/flashscratch/c/ckyriazi/caracals/reference/GCF_000181335.3_Felis_catus_9.0_genomic.fna


if [ $SGE_TASK_ID == 1 ]
then
	Chrom=chrA1
elif [ $SGE_TASK_ID == 2 ]
then    
        Chrom=chrA2
elif [ $SGE_TASK_ID == 3 ]
then
        Chrom=chrA3
elif [ $SGE_TASK_ID == 4 ]
then
        Chrom=chrB1
elif [ $SGE_TASK_ID == 5 ]
then
        Chrom=chrB1
elif [ $SGE_TASK_ID == 6 ]
then
        Chrom=chrB2
elif [ $SGE_TASK_ID == 7 ]
then
        Chrom=chrB3
elif [ $SGE_TASK_ID == 8 ]
then
        Chrom=chrB4
elif [ $SGE_TASK_ID == 9 ]
then
        Chrom=chrC1
elif [ $SGE_TASK_ID == 10 ]
then
        Chrom=chrC2
elif [ $SGE_TASK_ID == 11 ]
then
        Chrom=chrD1
elif [ $SGE_TASK_ID == 12 ]
then
        Chrom=chrD2
elif [ $SGE_TASK_ID == 13 ]
then
        Chrom=chrD3
elif [ $SGE_TASK_ID == 14 ]
then
        Chrom=chrD4
elif [ $SGE_TASK_ID == 15 ]
then
        Chrom=chrE1
elif [ $SGE_TASK_ID == 16 ]
then
        Chrom=chrE2
elif [ $SGE_TASK_ID == 17 ]
then
        Chrom=chrE3
elif [ $SGE_TASK_ID == 18 ]
then
        Chrom=chrF1
elif [ $SGE_TASK_ID == 19 ]
then
        Chrom=chrF2
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
-I ${BamDir}/${Individual}/${Individual}_BQSR_round3_recal.bam \
-o ${OutDir}/${Individual}/${Individual}_${Chrom}_GATK_HC.g.vcf.gz
