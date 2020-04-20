#!/bin/bash
#$ -l highp,h_rt=60:00:00,h_data=16G
#$ -pe shared 3
#$ -N moose_BQSR
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/deer_output/06_BQSR
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/deer_output/06_BQSR
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
#INDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/05_RemoveBadReads/${1}
INDIR=/u/scratch/c/ckyriazi/moose/output/06_BQSR/${1}

FILENAME=${1}
ROUND=${2}
SUFFIX='_06_BQSR1R_E_recal.bam'


### A. Create variant database by genotyping with raw bam file

LOG=${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_A_UG.vcf.gz.log

date > ${LOG}

java -jar -Xmx42g -Djava.io.tmpdir=${OUTDIR} ${GATK} \
-T UnifiedGenotyper \
-nt 6 \
-R ${REFERENCE} \
-glm BOTH \
--min_base_quality_score 20 \
-I ${INDIR}/${FILENAME}${SUFFIX} \
-o ${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_A_UG.vcf.gz \
-metrics ${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_A_UG.vcf.gz.metrics &>> ${LOG}

date >> ${LOG}


### B. Create recalibration table

LOG=${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_B_recal.table.log

date > ${LOG}

java -jar -Xmx42g -Djava.io.tmpdir=${OUTDIR} ${GATK} \
-T BaseRecalibrator \
-nct 6 \
-R ${REFERENCE} \
-I ${INDIR}/${FILENAME}${SUFFIX} \
-o ${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_B_recal.table \
-knownSites ${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_A_UG.vcf.gz &>> ${LOG}

date >> ${LOG}


### C. Create post-recalibration table

LOG=${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_C_postrecal.table.log

date > ${LOG}

java -jar -Xmx42g -Djava.io.tmpdir=${OUTDIR} ${GATK} \
-T BaseRecalibrator \
-nct 6 \
-R ${REFERENCE} \
-I ${INDIR}/${FILENAME}${SUFFIX} \
-o ${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_C_postrecal.table \
-knownSites ${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_A_UG.vcf.gz \
-BQSR ${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_B_recal.table &>> ${LOG}

date >> ${LOG}


### D. Make plots to compare before/after recalibration

LOG=${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_D_recalplots.log

date > ${LOG}

java -jar ${GATK} \
-T AnalyzeCovariates \
-R ${REFERENCE} \
-before ${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_B_recal.table \
-after ${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_C_postrecal.table \
-plots ${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_D_recalplots.pdf &>> ${LOG}

date >> ${LOG}


### E. Recalibrate bam file

LOG=${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_E_recal.bam.log

date > ${LOG}

java -jar -Xmx42g -Djava.io.tmpdir=${OUTDIR} ${GATK} \
-T PrintReads \
-nct 6 \
-R ${REFERENCE} \
-I ${INDIR}/${FILENAME}${SUFFIX} \
-o ${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_E_recal.bam \
-BQSR ${OUTDIR}/${FILENAME}_06_BQSR${ROUND}_B_recal.table &>> ${LOG}

date >> ${LOG}
