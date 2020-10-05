#! /bin/bash
#$ -cwd
#$ -l highp,h_rt=2:00:00,h_data=8G 
#$ -pe shared 1
#$ -N het_dist
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/het_dist/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/het_dist/jobfiles
#$ -m abe
#$ -M ckyriazi


indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/11_FilterVCFfile/
#indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/10_VEP/
infile=18Moose_joint_FilterB_Round12_NC_037354.1.vcf.gz

cd ${indir}


python /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/het_dist/make_dist_het_sites.py ${infile} 

mv het_dist_${infile}.txt /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/11_FilterVCFfile/het_dist
