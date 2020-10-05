#!/bin/bash
#$ -l highp,h_rt=24:00:00,h_data=8G
#$ -pe shared 3
#$ -N moose_BQSR
#$ -cwd
#$ -m bea
#$ -o /u/flashscratch/c/ckyriazi/moose/output/06_BQSR_R2
#$ -e /u/flashscratch/c/ckyriazi/moose/output/06_BQSR_R2
#$ -M ckyriazi



# Step 6: BaseQualityScoreRecalibration (BQSR)
# Procedure for base quality score recalibration when there is no database of
# "known" variants. Repeat with multiple rounds as necessary to reach convergence
# between reported and empirical quality scores (in plots produced by AnalyzeCovariates).
# See detailed explanation at:
# https://gatkforums.broadinstitute.org/gatk/discussion/44/base-quality-score-recalibrator

# Usage: ./06_BQSR.sh [input bam file] [round of BQSR]
# Assumes input bam file has suffix "_05_RemoveBadReads.bam"


. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

module load R

#current version is gatk 4.0.6
GATK=/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna
OUTDIR=/u/scratch/c/ckyriazi/moose/output/06_BQSR_R2/${1}
INDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/05_RemoveBadReads/${1}

FILENAME=${1}
ROUND=${2}



### D. Make plots to compare before/after recalibration

LOG=${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_D_recalplots.log

date > ${LOG}

java -jar ${GATK} \
-T AnalyzeCovariates \
-l DEBUG \
-R ${REFERENCE} \
-before ${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_B_recal.table \
-after ${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_C_postrecal.table \
-plots ${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_D_recalplots.pdf &>> ${LOG}


date >> ${LOG}

