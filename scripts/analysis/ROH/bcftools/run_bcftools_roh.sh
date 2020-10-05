#!/bin/bash
#$ -l highp,h_rt=24:00:00,h_data=8G
#$ -N bcftools_roh
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/ROH/bcftools/jobfiles	
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/ROH/bcftools/jobfiles
#$ -M ckyriazi



# This script is for running bcftools roh given vcf input
# see here https://samtools.github.io/bcftools/bcftools.html#roh and here https://samtools.github.io/bcftools/howtos/roh-calling.html for details


. /u/local/Modules/default/init/modules.sh
module load bcftools


indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/13_MergeChroms/
infile=18Moose_joint_FilterB_Round9_autosomes.vcf.gz
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/ROH_IBD/
outfile=18moose_round9_roh_bcftools_G30.out

# need -G flag to indicate genotypes rather than genotype likelihoods
# do i also need to add a flag for calculating allele frequencies????

bcftools roh -G30 ${indir}${infile} --include 'FILTER="PASS"' -o ${outdir}${outfile}








