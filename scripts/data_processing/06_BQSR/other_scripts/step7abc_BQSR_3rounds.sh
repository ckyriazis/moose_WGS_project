# /bin/bash

# Step 7a: Genotype calling with GATK UG round 1

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK="/u/home/c/ckyriazi/kirk-bigdata/software/gatk-4.0.6.0/gatk"

REFERENCE='/u/flashscratch/c/ckyriazi/caracals/reference/GCF_000181335.3_Felis_catus_9.0_genomic.fna'

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

#####
 ROUND 2 ########################
#####

NumRound=round2

# edited 12 to 4.
java -jar -Xmx16G ${GATK} \
-T UnifiedGenotyper \
-nt 4 \
-R ${REFERENCE} \
-I ${OutBamDir}/${Individual}/${Individual}_BQSR_round1_recal.bam \
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
-I ${OutBamDir}/${Individual}/${Individual}_BQSR_round1_recal.bam \
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
-I ${OutBamDir}/${Individual}/${Individual}_BQSR_round1_recal.bam \
-o ${OutBamDir}/${Individual}/${Individual}_BQSR_${NumRound}_recal.bam \
-BQSR ${OutBamDir}/${Individual}/${Individual}_BQSR_${NumRound}_recal.table

wait

#####
# ROUND 3 #######################
#####

NumRound=round3

# edited 12 to 4.
java -jar -Xmx16G ${GATK} \
-T UnifiedGenotyper \
-nt 4 \
-R ${REFERENCE} \
-I ${OutBamDir}/${Individual}/${Individual}_BQSR_round2_recal.bam \
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
-I ${OutBamDir}/${Individual}/${Individual}_BQSR_round2_recal.bam \
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
-I ${OutBamDir}/${Individual}/${Individual}_BQSR_round2_recal.bam \
-o ${OutBamDir}/${Individual}/${Individual}_BQSR_${NumRound}_recal.bam \
-BQSR ${OutBamDir}/${Individual}/${Individual}_BQSR_${NumRound}_recal.table

wait
