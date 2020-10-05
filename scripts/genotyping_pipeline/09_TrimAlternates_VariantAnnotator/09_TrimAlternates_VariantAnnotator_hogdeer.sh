#!/bin/bash
#$ -l highp,h_rt=50:00:00,h_data=6G
#$ -pe shared 4
#$ -N moose_TrimAlternates
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/09_TrimAlternates_VariantAnnotator/
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/09_TrimAlternates_VariantAnnotator/
#$ -M ckyriazi


# Step 9: Trim unused alternate alleles and add VariantType and AlleleBalance annotations
# to INFO column

# Usage: ./09_TrimAlternates_VariantAnnotator.sh [chromosome]

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK="/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar"
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/hogdeer_reference/GCA_003798545.1_ASM379854v1_genomic.fna
INDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/08_GenotypeGVCFs/
WORKDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/09_TrimAlternates_VariantAnnotator
TEMPDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/09_TrimAlternates_VariantAnnotator



LOG=${WORKDIR}/JointCalls_09_A_TrimAlternates_${SGE_TASK_ID}.vcf.gz_log.txt
BED=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/hogdeer_reference/hog_deer_scaffold_groups/scaffold_${SGE_TASK_ID}.bed


date > ${LOG}

java -jar -Xmx26g -Djava.io.tmpdir=${TEMPDIR} ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-trimAlternates \
-L ${BED} \
-V ${INDIR}/9Moose_joint_${SGE_TASK_ID}.vcf.gz \
-o ${WORKDIR}/9Moose_joint_TrimAlternates_${SGE_TASK_ID}.vcf.gz &>> ${LOG}

date >> ${LOG}


LOG=${WORKDIR}/JointCalls_09_B_VariantAnnotator_${SGE_TASK_ID}.vcf.gz_log.txt

date > ${LOG}

java -jar -Xmx26g -Djava.io.tmpdir=${TEMPDIR} ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L ${BED} \
-V ${WORKDIR}/9Moose_joint_TrimAlternates_${SGE_TASK_ID}.vcf.gz \
-o ${WORKDIR}/9Moose_joint_VariantAnnotator_${SGE_TASK_ID}.vcf.gz &>> ${LOG}

date >> ${LOG}
