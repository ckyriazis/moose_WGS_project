#!/bin/bash
#$ -l highp,h_rt=24:00:00,h_data=8G
#$ -N bcftools_roh
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/analysis/ROH_IBD/
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/analysis/ROH_IBD/
#$ -M ckyriazi



# This script is for running bcftools roh given vcf input
# see here https://samtools.github.io/bcftools/bcftools.html#roh and here https://samtools.github.io/bcftools/howtos/roh-calling.html for details


. /u/local/Modules/default/init/modules.sh
module load bcftools


indir=/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/13_MergeChroms/
#indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/11_FilterVCFfile/filtering_round4/
infile=9Moose_joint_FilterB_hogdeer_round1_192_scaffolds.vcf.gz
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/analysis/ROH_IBD/
outfile=moose_roh_bcftools_hogdeer_round1_G30_2.out

# need -G flag to indicate genotypes rather than genotype likelihoods
# do i also need to add a flag for calculating allele frequencies????

bcftools roh -G30 ${indir}${infile} --include 'FILTER="PASS"' -o ${outdir}${outfile}








