#!/bin/bash
#$ -l highp,h_rt=72:00:00,h_data=2G
#$ -pe shared 2
#$ -N remove_inds
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS/jobfiles
#$ -M ckyriazi

. /u/local/Modules/default/init/modules.sh
module load bcftools

cd /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/13_MergeChroms
#cd /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/11_FilterVCFfile/

VCF=


#bcftools view -s ^SMoose -O z ${VCF}.vcf.gz -o ${VCF}_noSMoose.vcf.gz

bcftools view -s MN15 -s MN178 -s MN31 -s MN41 -s MN54 -s MN72 -s MN76 -s MN92 -s MN96 -O z ${VCF}.vcf.gz -o ${VCF}_MN.vcf.gz

bcftools view -s IR3925 -s IR3927 -s IR3928 -s IR3929 -s IR3930 -s IR3931 -s IR3934 -O z ${VCF}.vcf.gz -o ${VCF}_IR.vcf.gz


#wait

#mv *recode* /u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SFS/vcfs/ 

