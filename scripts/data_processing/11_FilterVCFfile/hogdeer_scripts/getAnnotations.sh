#!/bin/bash
#$ -l highp,h_rt=24:00:00,h_data=8G
#$ -N getAnnotations
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/11_FilterVCFfile/annotation_tables
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/11_FilterVCFfile/annotation_tables
#$ -M ckyriazi

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77



GATK=/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/hogdeer_reference/GCA_003798545.1_ASM379854v1_genomic.fna
WKDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/09_TrimAlternates_VariantAnnotator
CHR="6"



cd ${WKDIR}

java -Xmx1g -jar ${GATK} -T SelectVariants -R ${REFERENCE} -V 9Moose_joint_VariantAnnotator_${CHR}.vcf.gz -selectType SNP -o SG_${CHR}_snps.vcf



java -Xmx1g -jar ${GATK} -R ${REFERENCE} -T VariantsToTable -V SG_${CHR}_snps.vcf --allowMissingData -F AN -F BaseQRankSum -F DP -F FS -F MQ -F MQRankSum -F QD -F ReadPosRankSum -F SOR --out SG_${CHR}_SNPs_table.txt

mv SG_${CHR}_* /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/11_FilterVCFfile/annotation_tables/

