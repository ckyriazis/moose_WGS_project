#!/bin/bash
#$ -l highp,h_rt=12:00:00,h_data=16G
#$ -N getPass
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/15_getPassSites
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/15_getPassSites
#$ -M ckyriazi





# script for getting only "PASS" sites from vcf
# just uses grep but could probably also do with GATK etc

BGZIP=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/bgzip

indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/14_getSNPsFromVCF
infile=SNPs_18Moose_joint_FilterB_Round9_autosomes.vcf.gz
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/15_getPassSites
outfile=18Moose_joint_FilterB_Round9_autosomes_SNPs_PASS.vcf.gz


zgrep -e "PASS" -e "#" ${indir}/${infile} | ${BGZIP} > ${outdir}/${outfile} 
