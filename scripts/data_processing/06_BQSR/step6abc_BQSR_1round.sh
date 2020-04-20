#!/bin/bash
#$ -l highp,h_rt=60:00:00,h_data=24G
#$ -pe shared 2
#$ -N moose_BQSR
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/deer_output/06_BQSR
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/deer_output/06_BQSR
#$ -M ckyriazi

#this script is modified from Clare's "step7abc_BQSR_round1.sh" script to be for one instead of three rounds


# Step 7a: Genotype calling with GATK UG round 1

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

#current version is gatk 4.0.6
GATK="/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar"

#REFERENCE='/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna'
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/deer_reference/GCA_002197005.1_CerEla1.0_genomic.fna



Individual=$1
InBamDir=$2
OutBamDir=$3


NumRound=round1

# edited 12 to 4.
java -jar -Xmx16G ${GATK} \
-T UnifiedGenotyper \
-nt 4 \
-R ${REFERENCE} \
-I ${InBamDir}/${Individual}/${Individual}_RemoveBadReads.bam \
-o ${OutBamDir}/${Individual}/${Individual}_BQSRGenotypeCalling_${NumRound}.vcf.gz \
-glm BOTH \
--min_base_quality_score 20 \
-metrics ${OutBamDir}/${Individual}/${Individual}_BQSRGenotypeCalling_${NumRound}.vcf.gz.metrics

wait

# Step 7b: Make recalibration table with GATK Base Recalibrator
# This is for round 1

java -jar -Xmx24G ${GATK} \
-T BaseRecalibrator \
-nct 6 \
-R ${REFERENCE} \
-I ${InBamDir}/${Individual}/${Individual}_RemoveBadReads.bam \
-o ${OutBamDir}/${Individual}/${Individual}_BQSR_${NumRound}_recal.table \
-knownSites ${OutBamDir}/${Individual}/${Individual}_BQSRGenotypeCalling_${NumRound}.vcf.gz

wait

# Step 7c: Write recalibrated bam files with GATK print reads
# This is for round 1

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

# changed nct to 6
java -jar -Xmx24G ${GATK} \
-T PrintReads \
-nct 6 \
-R ${REFERENCE} \
-I ${InBamDir}/${Individual}/${Individual}_RemoveBadReads.bam \
-o ${OutBamDir}/${Individual}/${Individual}_BQSR_${NumRound}_recal.bam \
-BQSR ${OutBamDir}/${Individual}/${Individual}_BQSR_${NumRound}_recal.table

wait
