#!/bin/bash
#$ -l highp,h_rt=150:00:00,h_data=6G
#$ -pe shared 4
#$ -N moose_TrimAlternates
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/output/09_TrimAlternates_VariantAnnotator/
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/output/09_TrimAlternates_VariantAnnotator/
#$ -M ckyriazi


# Step 9: Trim unused alternate alleles and add VariantType and AlleleBalance annotations
# to INFO column

# Usage: ./09_TrimAlternates_VariantAnnotator.sh [chromosome]

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK="/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar"
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna
INDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/08_GenotypeGVCFs/
WORKDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/09_TrimAlternates_VariantAnnotator
TEMPDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/09_TrimAlternates_VariantAnnotator


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


LOG=${WORKDIR}/JointCalls_09_A_TrimAlternates_${Chrom}.vcf.gz_log.txt

date > ${LOG}

java -jar -Xmx26g -Djava.io.tmpdir=${TEMPDIR} ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-trimAlternates \
-L ${Chrom} \
-V ${INDIR}/9Moose_joint_${Chrom}.vcf.gz \
-o ${WORKDIR}/9Moose_joint_TrimAlternates_${Chrom}.vcf.gz &>> ${LOG}

date >> ${LOG}


LOG=${WORKDIR}/JointCalls_09_B_VariantAnnotator_${Chrom}.vcf.gz_log.txt

date > ${LOG}

java -jar -Xmx26g -Djava.io.tmpdir=${TEMPDIR} ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L ${Chrom} \
-V ${WORKDIR}/9Moose_joint_TrimAlternates_${Chrom}.vcf.gz \
-o ${WORKDIR}/9Moose_joint_VariantAnnotator_${Chrom}.vcf.gz &>> ${LOG}

date >> ${LOG}
