#! /bin/bash
#$ -cwd
#$ -l highp,h_rt=12:00:00,h_data=8G
#$ -pe shared 4
#$ -N countAlleles
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/countVariants/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/countVariants/jobfiles
#$ -m abe
#$ -M ckyriazi

BGZIP=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/bgzip

indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/13_MergeChroms/
vcf=21Moose_joint_FilterB_Round1_autosomes.vcf.gz
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/countVariants/

cd ${outdir}${vcf%.vcf.gz}_results

source /u/local/Modules/default/init/modules.sh
module load python/2.7


suffix=_remove_fixed

script=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/countVariants/count_alleles.py



python $script --vcf  ${vcf%.vcf.gz}_proteincoding.vcf.gz  --outdir ${outdir}${vcf%.vcf.gz}_results --outPREFIX coding${suffix}


python $script --vcf  ${vcf%.vcf.gz}_proteincoding_LOF.vcf.gz  --outdir ${outdir}${vcf%.vcf.gz}_results --outPREFIX LOF${suffix}

python $script --vcf  ${vcf%.vcf.gz}_proteincoding_deleterious.vcf.gz  --outdir ${outdir}${vcf%.vcf.gz}_results --outPREFIX deleterious${suffix}


python $script --vcf  ${vcf%.vcf.gz}_proteincoding_synonymous.vcf.gz  --outdir ${outdir}${vcf%.vcf.gz}_results --outPREFIX synonymous${suffix}


python $script --vcf  ${vcf%.vcf.gz}_proteincoding_tolerated.vcf.gz  --outdir ${outdir}${vcf%.vcf.gz}_results --outPREFIX tolerated${suffix}


python $script --vcf  ${vcf%.vcf.gz}_proteincoding_missense.vcf.gz  --outdir ${outdir}${vcf%.vcf.gz}_results --outPREFIX missense${suffix}


