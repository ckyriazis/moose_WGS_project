#!/bin/bash
#$ -l highp,h_rt=24:00:00,h_data=8G
#$ -pe shared 1
#$ -N SNPs
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/14_getSNPsFromVCF/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/14_getSNPsFromVCF/jobfiles
#$ -M ckyriazi



#REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna
#indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/13_MergeChroms
#outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/14_getSNPsFromVCF

REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/hogdeer_reference/GCA_003798545.1_ASM379854v1_genomic.fna
indir=/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/genotyping_pipeline/13_MergeChroms
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/genotyping_pipeline/14_getSNPsFromVCF



#infile=21Moose_joint_FilterB_Round1_autosomes.vcf.gz
infile=9Moose_joint_FilterB_Round2_192_scaffolds2.vcf.gz

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77 

GATK="/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar"

java -jar -Xmx4G ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-V ${indir}/${infile} \
--restrictAllelesTo BIALLELIC \
--selectTypeToInclude SNP \
-o ${outdir}/'SNPs_'${infile}
