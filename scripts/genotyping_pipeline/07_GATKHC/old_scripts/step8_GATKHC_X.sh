#! /bin/bash

# This script is for the X chromosomes (chrX)

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK="/u/home/c/ckyriazi/kirk-bigdata/software/gatk_37/GenomeAnalysisTK.jar"

REFERENCE=/u/flashscratch/c/ckyriazi/caracals/reference/GCF_000181335.3_Felis_catus_9.0_genomic.fna

Chrom='chrX'
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
