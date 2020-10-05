#!/bin/bash
#$ -l highp,h_rt=6:00:00,h_data=8G
#$ -N getAnnotations
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/10_VEP/annotation_tables
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/10_VEP/annotation_tables
#$ -M ckyriazi

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77



GATK=/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna
WKDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/10_VEP
CHR=NC_037328.1



cd ${WKDIR}

java -Xmx1g -jar ${GATK} -T SelectVariants -R ${REFERENCE} -V 18Moose_joint_VEP_${CHR}.vcf.gz -selectType SNP -o annotation_tables/${CHR}_snps.vcf



java -Xmx1g -jar ${GATK} -R ${REFERENCE} -T VariantsToTable -V annotation_tables/${CHR}_snps.vcf --allowMissingData -F AN -F BaseQRankSum -F DP -F FS -F MQ -F MQRankSum -F QD -F ReadPosRankSum -F SOR --out annotation_tables/${CHR}_SNPs_table.txt

