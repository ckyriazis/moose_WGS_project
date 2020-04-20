#This script is for running vcftools lroh given the input of each chromosome
# no other settings can be altered

. /u/local/Modules/default/init/modules.sh
module load vcftools

indir=/u/home/c/ckyriazi/kirk-bigdata/caracal_pipeline/analyses/FINAL_VCFs/vcfs_bespoke
#infile=6_bespokefixed_v4_minRGQ1minGQ20minDP10maxHet0.99missing2_5_v4_mergeGaTKfiltered_varnonvar_4Caracals_joint__jointcalled_allchr.vcf.gz
infile=8_SNPs_rmFixedNonRef_bespokefixed_v4_minRGQ1minGQ20minDP10maxHet0.99missing2_5_v4_mergeGaTKfiltered_4Caracals_joint_allchr.recode.vcf.gz
#outfile_suffix=_vcftools_lroh_varnovar_out
outfile_suffix=_vcftools_lroh_SNPs_rmFixedNonRef_out

if [ $SGE_TASK_ID == 1 ]
then
        Chrom=NC_018723.3
elif [ $SGE_TASK_ID == 2 ]
then
        Chrom=NC_018724.3
elif [ $SGE_TASK_ID == 3 ]
then
        Chrom=NC_018725.3
elif [ $SGE_TASK_ID == 4 ]
then
        Chrom=NC_018726.3
elif [ $SGE_TASK_ID == 5 ]
then
        Chrom=NC_018727.3
elif [ $SGE_TASK_ID == 6 ]
then
        Chrom=NC_018728.3
elif [ $SGE_TASK_ID == 7 ]
then
        Chrom=NC_018729.3
elif [ $SGE_TASK_ID == 8 ]
then
        Chrom=NC_018730.3
elif [ $SGE_TASK_ID == 9 ]
then
        Chrom=NC_018731.3
elif [ $SGE_TASK_ID == 10 ]
then
        Chrom=NC_018732.3
elif [ $SGE_TASK_ID == 11 ]
then
        Chrom=NC_018733.3
elif [ $SGE_TASK_ID == 12 ]
then
        Chrom=NC_018734.3
elif [ $SGE_TASK_ID == 13 ]
then
        Chrom=NC_018735.3
elif [ $SGE_TASK_ID == 14 ]
then
        Chrom=NC_018736.3
elif [ $SGE_TASK_ID == 15 ]
then
        Chrom=NC_018737.3
elif [ $SGE_TASK_ID == 16 ]
then
        Chrom=NC_018738.3
elif [ $SGE_TASK_ID == 17 ]
then
        Chrom=NC_018739.3
elif [ $SGE_TASK_ID == 18 ]
then
        Chrom=NC_018740.3
fi


vcftools --LROH --gzvcf ${indir}/${infile} --chr ${Chrom} --out ${Chrom}${outfile_suffix}


