#! /bin/bash
#$ -cwd
#$ -l highp,h_rt=36:00:00,h_data=8G
#$ -N getCoding
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/countVariants/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/countVariants/jobfiles
#$ -m abe
#$ -M ckyriazi

BGZIP=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/bgzip

indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/13_MergeChroms/
vcf=21Moose_joint_FilterB_Round1_autosomes.vcf.gz
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/countVariants/

cd ${outdir}
#rm -r ${vcf%.vcf.gz}_results
#mkdir ${vcf%.vcf.gz}_results
cd ${vcf%.vcf.gz}_results

#zgrep "PASS"  ${indir}${vcf} | grep "protein_coding" | ${BGZIP} > ${vcf%.vcf.gz}_proteincoding.vcf.gz

#zgrep -e start_lost -e stop_gained -e splice_acceptor_variant -e splice_donor_variant ${vcf%.vcf.gz}_proteincoding.vcf.gz | ${BGZIP} > ${vcf%.vcf.gz}_proteincoding_LOF.vcf.gz

#zgrep "deleterious" ${vcf%.vcf.gz}_proteincoding.vcf.gz | ${BGZIP} > ${vcf%.vcf.gz}_proteincoding_deleterious.vcf.gz

zgrep "deleterious(" ${vcf%.vcf.gz}_proteincoding.vcf.gz | ${BGZIP} > ${vcf%.vcf.gz}_proteincoding_deleteriousHighConf.vcf.gz

#zgrep "synonymous" ${vcf%.vcf.gz}_proteincoding.vcf.gz | ${BGZIP} > ${vcf%.vcf.gz}_proteincoding_synonymous.vcf.gz

#zgrep "tolerated" ${vcf%.vcf.gz}_proteincoding.vcf.gz | ${BGZIP} > ${vcf%.vcf.gz}_proteincoding_tolerated.vcf.gz

#zgrep "missense" ${vcf%.vcf.gz}_proteincoding.vcf.gz | ${BGZIP} > ${vcf%.vcf.gz}_proteincoding_missense.vcf.gz


