#! /bin/bash
#$ -cwd
#$ -l highp,h_rt=2:00:00,h_data=8G 
#$ -pe shared 1
#$ -N filter_counts
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/get_filter_count
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/get_filter_count
#$ -m abe
#$ -M ckyriazi


indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/11_FilterVCFfile/round13
infile=18Moose_joint_FilterB_Round13_NC_037328.1.vcf.gz

cd ${indir}


python /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/get_filter_count/count_filters.py ${infile} 

mv filter_counts_${infile}.txt /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/11_FilterVCFfile/filter_counts/
