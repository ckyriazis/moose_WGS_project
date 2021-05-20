#!/bin/bash
#$ -l highp,h_rt=6:00:00,h_data=8G
#$ -N getAnnotations
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/get_annotations/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/get_annotations/jobfiles
#$ -M ckyriazi

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77



GATK=/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna
OUTDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/11_FilterVCFfile/annotation_tables
WKDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/10_VEP
VCF=21Moose_joint_VEP_
CHR=NC_037328.1



cd ${WKDIR}

java -Xmx1g -jar ${GATK} -T SelectVariants -R ${REFERENCE} -V ${VCF}${CHR}.vcf.gz -selectType SNP -o ${OUTDIR}/${VCF}${CHR}_snps.vcf



java -Xmx1g -jar ${GATK} -R ${REFERENCE} -T VariantsToTable -V ${OUTDIR}/${VCF}${CHR}_snps.vcf --allowMissingData -F AN -F BaseQRankSum -F DP -F FS -F MQ -F MQRankSum -F QD -F ReadPosRankSum -F SOR --out ${OUTDIR}/${VCF}${CHR}_SNPs_table.txt

