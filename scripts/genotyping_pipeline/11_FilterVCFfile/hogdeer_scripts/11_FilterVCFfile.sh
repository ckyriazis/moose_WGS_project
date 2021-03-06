#! /bin/bash
#$ -cwd
#$ -l highp,h_rt=24:00:00,h_data=12G 
#$ -pe shared 4
#$ -N moose_filtering
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/11_FilterVCFfile
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/11_FilterVCFfile
#$ -m abe
#$ -M ckyriazi



# Step 11: Apply mask and hard filters to VCF file

# Filtering DP > 342 - 99% of SG 6 DP


. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK=/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar
BGZIP=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/bgzip
TABIX=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/tabix
INDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/09_TrimAlternates_VariantAnnotator
OUTDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/11_FilterVCFfile
Chrom=${SGE_TASK_ID}
Round="round1"


### A. Apply mask and hard filters with VariantFiltration

MASK=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/hogdeer_reference/masks/masking_coordinates.bed
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/hogdeer_reference/GCA_003798545.1_ASM379854v1_genomic.fna


INFILE=${INDIR}/9Moose_joint_VariantAnnotator_${Chrom}.vcf.gz
OUTFILE=${OUTDIR}/9Moose_joint_11_FilterA_hogdeer_${Round}_${Chrom}.vcf.gz

java -jar ${GATK} \
-T VariantFiltration \
-R ${REFERENCE} \
--logging_level ERROR \
-filter "(QD < 10.0) || (FS > 12.0) || (MQ < 40.0) || (MQRankSum < -12.5) || (ReadPosRankSum < -8.0) || (SOR > 3.0)" \
--filterName "FAIL_6f" \
--mask ${MASK} --maskName "FAIL_Rep" \
-filter "QUAL < 30.0" --filterName "FAIL_qual" \
-filter "DP >342 " --filterName "FAIL_DP" \
-V ${INFILE} \
-o ${OUTFILE}


### B. Apply custom site- and genotype-level filters

FILTER_SCRIPT=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/11_FilterVCFfile/hogdeer_scripts/customVCFfilter.py

INFILE2=${OUTDIR}/9Moose_joint_11_FilterA_hogdeer_${Round}_${Chrom}.vcf.gz
OUTFILE2=${OUTDIR}/9Moose_joint_FilterB_hogdeer_${Round}_${Chrom}.vcf.gz

set -o pipefail

python ${FILTER_SCRIPT} ${INFILE2} | ${BGZIP} > ${OUTFILE2}

${TABIX} -p vcf ${OUTFILE2}
