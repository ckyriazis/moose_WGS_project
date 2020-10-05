#! /bin/bash
#$ -cwd
#$ -l highp,h_rt=100:00:00,h_data=12G 
#$ -pe shared 4
#$ -N moose_filtering
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/cow_scripts/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/cow_scripts/jobfiles
#$ -m bea
#$ -M ckyriazi



# Step 11: Apply mask and hard filters to VCF file

# Filtering DP > 701 - 99% of chr1 DP


. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK=/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar
BGZIP=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/bgzip
TABIX=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/tabix
INDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/10_VEP
OUTDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/11_FilterVCFfile
ROUND=7

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


### A. Apply mask and hard filters with VariantFiltration

MASK=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/masks/masking_coordinates.bed
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna


INFILE=${INDIR}/18Moose_joint_VEP_${Chrom}.vcf.gz
OUTFILE=${OUTDIR}/18Moose_joint_FilterA_Round${ROUND}_${Chrom}.vcf.gz

java -jar ${GATK} \
-T VariantFiltration \
-R ${REFERENCE} \
--logging_level ERROR \
-filter "(QD < 10.0) || (FS > 12.0) || (MQ < 40.0) || (MQRankSum < -12.5) || (ReadPosRankSum < -8.0) || (SOR > 3.0)" \
--filterName "FAIL_6f" \
--mask ${MASK} --maskName "FAIL_Rep" \
-filter "QUAL < 30.0" --filterName "FAIL_qual" \
-filter "DP >701 " --filterName "FAIL_DP" \
-L ${Chrom} \
-V ${INFILE} \
-o ${OUTFILE}


### B. Apply custom site- and genotype-level filters

FILTER_SCRIPT=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/cow_scripts/customVCFfilter_old.py

INFILE2=${OUTDIR}/18Moose_joint_FilterA_Round${ROUND}_${Chrom}.vcf.gz
OUTFILE2=${OUTDIR}/18Moose_joint_FilterB_Round${ROUND}_${Chrom}.vcf.gz

set -o pipefail

python ${FILTER_SCRIPT} ${INFILE2} | ${BGZIP} > ${OUTFILE2}

${TABIX} -p vcf ${OUTFILE2}





