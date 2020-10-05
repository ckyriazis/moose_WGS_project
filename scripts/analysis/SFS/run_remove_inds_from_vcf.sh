#!/bin/bash
#$ -l highp,h_rt=200:00:00,h_data=16G
#$ -pe shared 2
#$ -N remove_inds
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS/runfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS/runfiles
#$ -M ckyriazi

. /u/local/Modules/default/init/modules.sh
module load vcftools

cd /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/13_MergeChroms
#cd /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/11_FilterVCFfile/round8

VCF=18Moose_joint_FilterB_Round9_autosomes
#VCF=18Moose_joint_FilterB_Round8_NC_037328.1


vcftools --gzvcf ${VCF}.vcf.gz --remove-indv MN31 --remove-indv MN41 --remove-indv MN54 --remove-indv MN96 --remove-indv MN15 --remove-indv MN178 --remove-indv MN72 --remove-indv MN76 --remove-indv MN92 --out ${VCF}_IR --recode


vcftools --gzvcf ${VCF}.vcf.gz --remove-indv IR3925 --remove-indv IR3927 --remove-indv IR3928 --remove-indv IR3929 --remove-indv IR3931 --remove-indv IR3920 --remove-indv IR3921 --remove-indv IR3930 --remove-indv IR3934 --out ${VCF}_MN --recode

wait

gzip *recode* 

wait

mv *recode* /u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SFS/vcfs/ 
