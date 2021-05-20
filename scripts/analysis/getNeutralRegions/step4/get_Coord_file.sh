#! /bin/bash
#$ -wd /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/getNeutralRegions/step4
#$ -l h_rt=23:00:00,h_data=4G,h_vmem=10G
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/getNeutralRegions/step4/jobfiles/getNeutralCoords.out.txt
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/getNeutralRegions/step4/jobfiles/getNeutralCoords.err.txt
#$ -m abe
#$ -t 1-30

# Gets neutral coordinates to bed file
# Adapted from Annabel Beichman's script (to analyze exomes) by Sergio Nigenda to analyze whole genome data.
# Usage: qsub get_Coord_file.sh Vaquita


########## Setting environment

#source /u/project/rwayne/software/finwhale/miniconda2/etc/profile.d/conda.sh
#conda activate gentools


. /u/local/Modules/default/init/modules.sh
module load python/2.7
module load bedtools

set -oe pipefail

########## Set variables, files and directories



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



REF=cow

VCFDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/getNeutralRegions/step3
WORKDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/getNeutralRegions/step4
SCRIPTDIR=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/getNeutralRegions/step4
NeutralCoord_SCRIPT=${SCRIPTDIR}/obtain_noCpG_noRepetitive_coordinates.py


##### make directories were this information will be stored

mkdir -p ${WORKDIR}/repeatRegions
mkdir -p ${WORKDIR}/get_fasta


##### Logging

cd ${WORKDIR}

mkdir -p ./logs
mkdir -p ./temp

echo "[$(date "+%Y-%m-%d %T")] Start creating bed files for ${REF} ${SGE_TASK_ID} JOB_ID: ${JOB_ID}"
echo "The qsub input"
echo "${REF} ${SGE_TASK_ID}"

PROGRESSLOG=./logs/create_beds_${REF}_${Chrom}_progress.log
echo -e "[$(date "+%Y-%m-%d %T")] JOB_ID: ${JOB_ID}" > ${PROGRESSLOG}


########## Creates a bed file for each vcf file

echo -e "[$(date "+%Y-%m-%d %T")]  creating bed files ... " >> ${PROGRESSLOG}
LOG=./logs/Step2_Creating_bed_files_${REF}_${IDX}.log
date "+%Y-%m-%d %T" > ${LOG}

python ${NeutralCoord_SCRIPT} --VCF ${VCFDIR}/no_repeats_SFS_${Chrom}.vcf.gz --outfile ${WORKDIR}/repeatRegions/min10kb_DistFromCDRs_noCpGIsland_noRepeat_${Chrom}.bed

bedtools merge -d 10 -i ${WORKDIR}/repeatRegions/min10kb_DistFromCDRs_noCpGIsland_noRepeat_${Chrom}.bed > ${WORKDIR}/repeatRegions/min10kb_DistFromCDRs_noCpGIsland_noRepeat_mergedMaxDistance10_${Chrom}.bed

cat ${WORKDIR}/repeatRegions/min10kb_DistFromCDRs_noCpGIsland_noRepeat_mergedMaxDistance10_*.bed | sort -k1,1 -k2,2n > ${WORKDIR}/get_fasta/min10kb_DistFromCDRs_noCpGIsland_noRepeat_mergedMaxDistance10_sorted.bed 


exitVal=${?}
if [ ${exitVal} -ne 0 ]; then
    echo -e "[$(date "+%Y-%m-%d %T")] FAIL" >> ${PROGRESSLOG}
    exit 1
fi

date "+%Y-%m-%d %T" >> ${LOG}
echo -e "[$(date "+%Y-%m-%d %T")] Done" >> ${PROGRESSLOG}


#conda deactivate

