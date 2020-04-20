#!/bin/bash
#$ -l highp,h_rt=24:00:00,h_data=8G
#$ -pe shared 1
#$ -N SNPs
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/14_getSNPsFromVCF
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/14_getSNPsFromVCF
#$ -M ckyriazi



REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna
#indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/11_FilterVCFfile/filtering_round4
#indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/08_GenotypeGVCFs
indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/13_MergeChroms
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/14_getSNPsFromVCF


#Chrom=NC_037355.1
#infile=9Moose_joint_Filter_B_${Chrom}.vcf.gz
infile=9Moose_joint_Filter_B_round4_allchrom.vcf.gz

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
