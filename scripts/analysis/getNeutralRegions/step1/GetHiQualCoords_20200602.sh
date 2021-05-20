#! /bin/bash

#$ -wd /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/getNeutralRegions/step1
#$ -l h_data=10G,h_vmem=16G,h_rt=10:00:00
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/getNeutralRegions/step1/jobfiles/GetHiQcoords.out.txt
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/getNeutralRegions/step1/jobfiles/GetHiQcoords.err.txt
#$ -t 21-30
#$ -m abe



# Author: Sergio Nigenda, based on Tanya Phung's scripts for step 10 of her NGS pipeline 
# Generates a bed file with the high quality sites in the VCF files.
# Usage example: qsub GetHiQualCoords_20200602.sh vaquita

# Modified by Chris Kyriazis 
# Changes: no conda environment, set up to work with cow chroms, 


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


########## Setting conda environment 

#source /u/project/rwayne/software/finwhale/miniconda2/etc/profile.d/conda.sh
#conda activate gentools


. /u/local/Modules/default/init/modules.sh
module load python/2.7
module load bedtools

set -o pipefail


######## Setting directories ######

REF=cow
SCRIPTDIR=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/getNeutralRegions/step1
WORKDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/getNeutralRegions/step1
VCFDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/11_FilterVCFfile
HiQualCoords_SCRIPT=${SCRIPTDIR}/obtain_high_qual_coordinates.py # obtain_noCpG_noRepetitive_coordinates.py

mkdir -p ${WORKDIR}


########## Logging

# echo the input 
echo "[$(date "+%Y-%m-%d %T")] Start GetHiQCoords for ${REF} {IDX} Job ID: ${SGE_TASK_ID}"
echo "The qsub input"
echo "${REF} ${SGE_TASK_ID}"

cd ${WORKDIR}
mkdir -p ./logs
mkdir -p ./temp

PROGRESSLOG=./logs/GetHiQualSitesCoords_A_${REF}_${Chrom}_progress.log
echo -e "[$(date "+%Y-%m-%d %T")] JOB_ID: ${SGE_TASK_ID}" > ${PROGRESSLOG}
echo -e "[$(date "+%Y-%m-%d %T")] Selecting high quality coordinates ... " >> ${PROGRESSLOG}

LOG=./logs/01_A_Get_HighQuality_Coords_${REF}_${Chrom}.log
date "+%Y-%m-%d %T" > ${LOG}


########## Step 9A. Selecting high quality coordinates and missing sites. If ${HiQualCoords_SCRIPT} is defined as obtain_high_qual_coordinates.py it selects only high quality data to later build neutral SFS without projection. However, if is defined as obtain_high_qual_coordinates_miss.py then it includes high quality and missing data for SFS projection. 

python ${HiQualCoords_SCRIPT} --VCF ${VCFDIR}/21Moose_joint_FilterB_Round2_${Chrom}.vcf.gz --outfile HQsitesCoords_${Chrom}.bed
# python ${HiQualCoords_SCRIPT} --VCF ${VCFDIR}/vaquita_20_chr${IDX}_simple_PASS.vcf.gz --outfile vcfsitesCoords_${IDX}.bed

exitVal=${?}
if [ ${exitVal} -ne 0 ]; then
    echo -e "[$(date "+%Y-%m-%d %T")] FAIL" >> ${PROGRESSLOG}
    exit 1
fi

date "+%Y-%m-%d %T" >> ${LOG}
echo -e "[$(date "+%Y-%m-%d %T")] Done" >> ${PROGRESSLOG}


########## Step 9B. Merging High quality coordinates (The previous step is made for each variant, therefore here we merge those coordinates to have less individual regions)

PROGRESSLOG=./logs/GetHiQualSitesCoords_B_${REF}_${Chrom}_progress.log
echo -e "[$(date "+%Y-%m-%d %T")] Merging high quality coordinates ... " >> ${PROGRESSLOG}

LOG=./logs/01_B_Merge_HighQuality_Coords_${REF}_${Chrom}.log
date "+%Y-%m-%d %T" > ${LOG}

bedtools merge -i HQsitesCoords_${Chrom}.bed > HQsitesCoords_merged_${Chrom}.bed


cat HQsitesCoords_merged_*.bed | sort -k1,1 -k2,2n > all_HQCoords_sorted_merged.bed


exitVal=${?}
if [ ${exitVal} -ne 0 ]; then
    echo -e "[$(date "+%Y-%m-%d %T")] FAIL" >> ${PROGRESSLOG}
    exit 1
fi

date "+%Y-%m-%d %T" >> ${LOG}
echo -e "[$(date "+%Y-%m-%d %T")] Done" >> ${PROGRESSLOG}

#conda deactivate
