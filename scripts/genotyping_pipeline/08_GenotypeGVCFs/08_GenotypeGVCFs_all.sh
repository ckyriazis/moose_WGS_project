#!/bin/bash
#$ -l highp,h_rt=99:00:00,h_data=6G
#$ -pe shared 4
#$ -N moose_GenotypeGVCFs
#$ -cwd
#$ -m a
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/08_GenotypeGVCFs/
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/08_GenotypeGVCFs/
#$ -M ckyriazi



# This script is for all chromosomes (autosomes, X, MT)

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK="/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar"


REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna


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

OutDir=$1

AllIndividuals=(IR3925  IR3927  IR3928  IR3929 IR3930 IR3931  IR3934  MN15  MN178  MN31  MN41  MN54  MN72  MN76  MN92  MN96 C06 HM2013 JC2001 R199 SMoose)

java -jar -Xmx16G ${GATK} \
-T GenotypeGVCFs \
-R ${REFERENCE} \
-allSites \
-stand_call_conf 0 \
-L ${Chrom} \
$(for Individual in "${AllIndividuals[@]}"; do echo "-V /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/07_GATKHC/${Individual}/${Individual}_${Chrom}_GATK_HC.g.vcf.gz"; done) \
-o ${OutDir}/21Moose_joint_${Chrom}.vcf.gz
