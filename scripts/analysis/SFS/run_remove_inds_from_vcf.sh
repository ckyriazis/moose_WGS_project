#!/bin/bash
#$ -l highp,h_rt=96:00:00,h_data=16G
#$ -N remove_inds
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS
#$ -M ckyriazi

. /u/local/Modules/default/init/modules.sh
module load vcftools

#cd /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/13_MergeChroms/
cd /u/home/c/ckyriazi/kirk-bigdata/moose/output/13_MergeChroms/
#cd /u/home/c/ckyriazi/kirk-bigdata/moose/output/11_FilterVCFfile/filtering_round4

VCF=9Moose_joint_Filter_B_round4_allchrom
#VCF=9Moose_joint_FilterB_hogdeer_round1_192_scaffolds


#vcftools --gzvcf ${VCF}.vcf.gz --remove-indv MN31 --remove-indv MN41 --remove-indv MN54 --remove-indv MN96 --out ${VCF}_IR --recode


vcftools --gzvcf ${VCF}.vcf.gz --remove-indv IR3925 --remove-indv IR3927 --remove-indv IR3928 --remove-indv IR3929 --remove-indv IR3931 --out ${VCF}_MN --recode

wait

gzip *recode* 

wait

mv *recode* /u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SFS/vcfs/ 
