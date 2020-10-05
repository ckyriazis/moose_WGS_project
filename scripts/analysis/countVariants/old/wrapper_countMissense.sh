#! /bin/bash
#$ -cwd
#$ -l highp,h_rt=36:00:00,h_data=8G
#$ -N countVariants
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/countVariants
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/countVariants
#$ -m abe
#$ -M ckyriazi

BGZIP=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/bgzip

indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/13_MergeChroms/
vcf=18Moose_joint_FilterB_Round1_autosomes.vcf.gz
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/countVariants/

cd ${outdir}${vcf%.vcf.gz}_results


source /u/local/Modules/default/init/modules.sh
module load python/2.7


suffix=

script=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/countVariants/count_missense.py

#python $script --vcf  ${vcf%.vcf.gz}_proteincoding_LOF.vcf.gz  --outdir ${outdir}${vcf%.vcf.gz}_results --outPREFIX LOF${suffix}

#python $script --vcf  ${vcf%.vcf.gz}_proteincoding_deleterious.vcf.gz  --outdir ${outdir}${vcf%.vcf.gz}_results --outPREFIX deleterious${suffix}


python $script --vcf  ${vcf%.vcf.gz}_proteincoding_missense.vcf.gz  --outdir ${outdir}${vcf%.vcf.gz}_results --outPREFIX missense${suffix}


#python $script --vcf  ${vcf%.vcf.gz}_proteincoding_tolerated.vcf.gz  --outdir ${outdir}${vcf%.vcf.gz}_results --outPREFIX tolerated${suffix}




