#!/bin/bash
#$ -l h_rt=6:00:00,h_data=2G
#$ -pe shared 4
#$ -N FST
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/FST/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/FST/jobfiles
#$ -M ckyriazi

# script for calculating FST between two or more populations from a vcf
# for each population, need to supply a file with all individuals listed
# not sure if this will automatically skip filtered sites, 
# so perhaps best to use "PASS" vcf to be safe
# note that this needs to be done for each population pair separately
# and that 2+ inds from each pop are required

# usage: qsub calc_FST_vcftools.sh 

. /u/local/Modules/default/init/modules.sh
module load vcftools



#vcf=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/11_FilterVCFfile/21Moose_joint_FilterB_Round1_NC_037352.1.vcf.gz
vcfdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/15_getPassSites/
vcf=21Moose_joint_FilterB_Round1_autosomes_SNPs_PASS
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/FST


#vcftools --gzvcf ${vcfdir}/${vcf}.vcf.gz --weir-fst-pop pop_files/IR_inds.txt --weir-fst-pop pop_files/MN_inds.txt  --out ${outdir}/IR_MN_${vcf}

vcftools --gzvcf ${vcfdir}/${vcf}.vcf.gz --weir-fst-pop pop_files/MN_inds.txt --weir-fst-pop pop_files/Rockies_inds.txt --out ${outdir}/MN_Rockies_${vcf}




wait

# remove lines that contain "nan" - the vast majority do
cd ${outdir}

#awk '!/nan/' IR_MN_${vcf}.weir.fst > IR_MN_${vcf}.weir.fst.removeNaN.txt
awk '!/nan/' MN_Rockies_${vcf}.weir.fst > MN_Rockies_${vcf}.weir.fst.removeNaN.txt


