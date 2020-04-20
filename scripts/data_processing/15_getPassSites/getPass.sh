# script for getting only "PASS" sites from vcf
# just uses grep but could probably also do with GATK etc

BGZIP=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/bgzip

indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/14_getSNPsFromVCF
infile=9Moose_joint_Filter_B_round4_allchrom_SNPs.vcf.gz
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/15_getPassSites
outfile=9Moose_joint_Filter_B_round4_allchrom_SNPs_PASS.vcf.gz


zgrep -e "PASS" -e "#" ${indir}/${infile} | ${BGZIP} > ${outdir}/${outfile} 
