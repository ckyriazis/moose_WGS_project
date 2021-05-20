#!/bin/bash
#$ -l highp,h_rt=12:00:00,h_data=16G
#$ -N getPass
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/15_getPassSites/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/15_getPassSites/jobfiles
#$ -M ckyriazi





# script for getting only "PASS" sites from vcf
# just uses grep but could probably also do with GATK etc

BGZIP=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/bgzip

#indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/14_getSNPsFromVCF
#infile=21Moose_joint_FilterB_Round1_autosomes_SNPs
#outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/15_getPassSites


indir=/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/genotyping_pipeline/14_getSNPsFromVCF
infile=SNPs_9Moose_joint_FilterB_Round2_192_scaffolds2.vcf.gz
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/genotyping_pipeline/15_getPassSites



zgrep -e "PASS" -e "#" ${indir}/${infile}.vcf.gz | ${BGZIP} > ${outdir}/${infile}_PASS.vcf.gz
