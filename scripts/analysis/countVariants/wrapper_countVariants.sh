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
vcf=9Moose_joint_Filter_B_round4_allchrom.vcf.gz
#indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/11_FilterVCFfile/filtering_round4/
#vcf=9Moose_joint_Filter_B_NC_037356.1.vcf.gz
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/countVariants/

cd ${outdir}
#rm -r ${vcf%.vcf.gz}_results
#mkdir ${vcf%.vcf.gz}_results
cd ${vcf%.vcf.gz}_results

#zgrep "PASS"  ${indir}${vcf} | grep "protein_coding" | ${BGZIP} > ${vcf%.vcf.gz}_proteincoding.vcf.gz

#zgrep -e start_lost -e stop_gained -e splice_acceptor_variant -e splice_donor_variant ${vcf%.vcf.gz}_proteincoding.vcf.gz | ${BGZIP} > ${vcf%.vcf.gz}_proteincoding_LOF.vcf.gz

#zgrep "deleterious" ${vcf%.vcf.gz}_proteincoding.vcf.gz | ${BGZIP} > ${vcf%.vcf.gz}_proteincoding_deleterious.vcf.gz

#zgrep "synonymous" ${vcf%.vcf.gz}_proteincoding.vcf.gz | ${BGZIP} > ${vcf%.vcf.gz}_proteincoding_synonymous.vcf.gz

#zgrep "tolerated" ${vcf%.vcf.gz}_proteincoding.vcf.gz | ${BGZIP} > ${vcf%.vcf.gz}_proteincoding_tolerated.vcf.gz





source /u/local/Modules/default/init/modules.sh
module load python/2.7


suffix=_remove_fixed

script=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/countVariants/count_variants.py

python $script --vcf  ${vcf%.vcf.gz}_proteincoding_LOF.vcf.gz  --outdir ${outdir}${vcf%.vcf.gz}_results --outPREFIX LOF${suffix}

python $script --vcf  ${vcf%.vcf.gz}_proteincoding_deleterious.vcf.gz  --outdir ${outdir}${vcf%.vcf.gz}_results --outPREFIX deleterious${suffix}


python $script --vcf  ${vcf%.vcf.gz}_proteincoding_synonymous.vcf.gz  --outdir ${outdir}${vcf%.vcf.gz}_results --outPREFIX synonymous${suffix}


python $script --vcf  ${vcf%.vcf.gz}_proteincoding_tolerated.vcf.gz  --outdir ${outdir}${vcf%.vcf.gz}_results --outPREFIX tolerated${suffix}




