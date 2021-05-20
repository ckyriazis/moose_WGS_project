#! /bin/bash
#$ -cwd
#$ -l highp,h_rt=48:00:00,h_data=2G 
#$ -N moose_VEP
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/10_VEP
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/10_VEP
#$ -m abe
#$ -M ckyriazi


# Step 10: Annotate variants with Variant Effect Predictor from Ensembl

# Usage: ./10_VEP.sh [chromosome]


if [ $SGE_TASK_ID == 1 ]
then
        Chrom=NC_037328.1
elif [ $SGE_TASK_ID == 2 ]
then
        Chrom=NC_037329.1
elif [ $SGE_TASK_ID == 3 ]
then
        Chrom=NC_037330.1
elif [ $SGE_TASK_ID == 4 ]
then
        Chrom=NC_037331.1
elif [ $SGE_TASK_ID == 5 ]
then
        Chrom=NC_037332.1
elif [ $SGE_TASK_ID == 6 ]
then
        Chrom=NC_037333.1
elif [ $SGE_TASK_ID == 7 ]
then
        Chrom=NC_037334.1
elif [ $SGE_TASK_ID == 8 ]
then
        Chrom=NC_037335.1
elif [ $SGE_TASK_ID == 9 ]
then
        Chrom=NC_037336.1
elif [ $SGE_TASK_ID == 10 ]
then
        Chrom=NC_037337.1
elif [ $SGE_TASK_ID == 11 ]
then
        Chrom=NC_037338.1
elif [ $SGE_TASK_ID == 12 ]
then
        Chrom=NC_037339.1
elif [ $SGE_TASK_ID == 13 ]
then
        Chrom=NC_037340.1
elif [ $SGE_TASK_ID == 14 ]
then
        Chrom=NC_037341.1
elif [ $SGE_TASK_ID == 15 ]
then
        Chrom=NC_037342.1
elif [ $SGE_TASK_ID == 16 ]
then
        Chrom=NC_037343.1
elif [ $SGE_TASK_ID == 17 ]
then
        Chrom=NC_037344.1
elif [ $SGE_TASK_ID == 18 ]
then
        Chrom=NC_037345.1
elif [ $SGE_TASK_ID == 19 ]
then
        Chrom=NC_037346.1
elif [ $SGE_TASK_ID == 20 ]
then
        Chrom=NC_037347.1
elif [ $SGE_TASK_ID == 21 ]
then
        Chrom=NC_037348.1
elif [ $SGE_TASK_ID == 22 ]
then
        Chrom=NC_037349.1
elif [ $SGE_TASK_ID == 23 ]
then
        Chrom=NC_037350.1
elif [ $SGE_TASK_ID == 24 ]
then
        Chrom=NC_037351.1
elif [ $SGE_TASK_ID == 25 ]
then
        Chrom=NC_037352.1
elif [ $SGE_TASK_ID == 26 ]
then
        Chrom=NC_037353.1
elif [ $SGE_TASK_ID == 27 ]
then
        Chrom=NC_037354.1
elif [ $SGE_TASK_ID == 28 ]
then
        Chrom=NC_037355.1
elif [ $SGE_TASK_ID == 29 ]
then
        Chrom=NC_037356.1
elif [ $SGE_TASK_ID == 30 ]
then
        Chrom=NC_037357.1
fi


source /u/local/Modules/default/init/modules.sh
module load perl

VEPDIR=/u/home/c/ckyriazi/project-klohmuel/software/ensembl-vep-97
BGZIP=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/bgzip
TABIX=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/tabix

INDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/09_TrimAlternates_VariantAnnotator
OUTDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/10_VEP

INFILE=${INDIR}/21Moose_joint_VariantAnnotator_${Chrom}.vcf.gz
OUTFILE=${OUTDIR}/21Moose_joint_VEP_${Chrom}.vcf.gz

perl ${VEPDIR}/vep \
--dir ${VEPDIR} --cache --vcf --offline --sift b --species bos_taurus \
--canonical --allow_non_variant --symbol --force_overwrite \
--dir_cache /u/home/c/ckyriazi/project-klohmuel/software/ensembl-vep-97 \
-i ${INFILE} \
-o STDOUT \
--stats_file ${OUTFILE}_stats.html | \
sed 's/ /_/g' | ${BGZIP} > ${OUTFILE}

$TABIX -p vcf ${OUTFILE}
