#! /bin/bash
#$ -wd /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/getNeutralRegions/step6
#$ -l h_rt=22:00:00,h_data=25G,h_vmem=30G
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/getNeutralRegions/step6/jobfiles/GetNeutral_sites.out.txt
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/getNeutralRegions/step6/jobfiles/GetNeutral_sites.err.txt
#$ -t 1-30
#$ -m abe

# Extract the neutral regions that are not conserved (i.e. do not map to zebra fish genome), to new vcf files per chromosome or scaffold.
# The extracted neutral regions will be used to buil the SFS projection. 
# Adapted from Annabel Beichman's script (to analyze exomes) by Sergio Nigenda to analyze whole genome data.
# Usage: ./Identify_Neutral_Regions.sh [reference species]

#source /u/project/rwayne/software/finwhale/miniconda2/etc/profile.d/conda.sh
#conda activate gentools


. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77
module load bedtools
module load python/2.7


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

WORKDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/getNeutralRegions
VCFDIR=${WORKDIR}/step3
OUTDIR=${WORKDIR}/step6
SCRIPTDIR=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/getNeutralRegions
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna
NeutralCoord_SCRIPT=${SCRIPTDIR}/step4/obtain_noCpG_noRepetitive_coordinates.py
TenKb=${WORKDIR}/step2/DistanceFromExons/all_HQCoords_min10kb_DistFromExons.0based.bed
GATK=/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar




##### make directories were this information will be stored

mkdir -p ${OUTDIR}/HQ_neutral_sites # This directory will have neutral regions going through 3 checks: CpG Islands, repetitive regions, and do not blast to fish
mkdir -p ${OUTDIR}/beds

Fishy=${WORKDIR}/step5/zebra_fish/fish.matches.eval.1e-10.0based.bed


##### Logging

cd ${OUTDIR}

mkdir -p ./logs
mkdir -p ./temp

# echo the input
echo "[$(date "+%Y-%m-%d %T")] Start extracting no conserved regions for ${REF} ${SGE_TASK_ID} JOB_ID: ${JOB_ID}"
echo "The qsub input"
echo "${REF} ${SGE_TASK_ID}"

PROGRESSLOG=./logs/Extract_No_conserved_regions_${REF}_${Chrom}_progress.log
echo -e "[$(date "+%Y-%m-%d %T")] JOB_ID: ${JOB_ID}" > ${PROGRESSLOG}


########## Extracts regions that do not blasted to zebra fish genome

echo -e "[$(date "+%Y-%m-%d %T")]  Extracting final neutral regions with GATK SelecVariants... " >> ${PROGRESSLOG}
LOG=./logs/Step4_ExtractNeutralSites_${REF}_SelectVariants_${Chrom}.log
date "+%Y-%m-%d %T" > ${LOG}

java -jar ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
--variant ${VCFDIR}/no_repeats_SFS_${Chrom}.vcf.gz  \
-XL ${Fishy} \
-L ${TenKb} \
-o ${OUTDIR}/Neutral_sites_SFS_${Chrom}.vcf.gz &>> ${LOG}

exitVal=${?}
if [ ${exitVal} -ne 0 ]; then
    echo -e "[$(date "+%Y-%m-%d %T")] FAIL" >> ${PROGRESSLOG}
    exit 1
fi

date "+%Y-%m-%d %T" >> ${LOG}
echo -e "[$(date "+%Y-%m-%d %T")] Done" >> ${PROGRESSLOG}


########## Optional step. Creates a bed file containing all the Neutral sites and calculates the total length of the neutral sequences obtained with this pipeline.

python ${NeutralCoord_SCRIPT} --VCF ${OUTDIR}/Neutral_sites_SFS_${Chrom}.vcf.gz --outfile ${OUTDIR}/beds/Neutral_sites_SFS_${Chrom}.bed

bedtools merge -i ${OUTDIR}/beds/Neutral_sites_SFS_${Chrom}.bed > ${OUTDIR}/beds/Neutral_sites_SFS_merge_${Chrom}.bed

cat ${OUTDIR}/beds/Neutral_sites_SFS_merge_*.bed | sort -k1,1 -k2,2n > ${OUTDIR}/beds/Neutral_sites_SFS_sorted.bed

cp ${OUTDIR}/beds/Neutral_sites_SFS_sorted.bed ${OUTDIR}/HQ_neutral_sites

cd ${OUTDIR}/HQ_neutral_sites

cp Neutral_sites_SFS_sorted.bed Final_HQ_neutral_regions.bed

awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}' ${WORKDIR}/HQ_neutral_sites/Final_HQ_neutral_regions.bed > ${WORKDIR}/HQ_neutral_sites/totalPassingSequence.txt


#conda deactivate

