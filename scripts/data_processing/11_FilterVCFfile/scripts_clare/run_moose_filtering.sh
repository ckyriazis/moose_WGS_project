#!/bin/bash
#$ -l highp,h_rt=24:00:00,h_data=4G
#$ -pe shared 3
#$ -N moose_filtering
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/output/11_FilterVCFfile/
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/output/11_FilterVCFfile/
#$ -M ckyriazi
#$ -t 2:30




. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK="/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar"

REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna

# Using NCBI repeats from ftp://ftp.ncbi.nih.gov/genomes/Felis_catus/
NCBIRepeats='/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/masks/masking_coordinates.bed'
abb='9Moose_joint_VEP_'

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

infile=${abb}${Chrom}'.vcf.gz'
indir='/u/home/c/ckyriazi/kirk-bigdata/moose/output/10_VEP'
outdir='/u/home/c/ckyriazi/kirk-bigdata/moose/output/11_FilterVCFfile/'${Chrom}

# BOTH apply to variant and invariant

# this trims the alternates to get rid of the NON_REF in the variant and invariant
# it also removes any sites that aren't called in 3/4 samples or more.

java -jar -Xmx4G ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L ${Chrom} \
-V ${indir}/${infile} \
-trimAlternates \
--maxNOCALLnumber 6 \
-o ${outdir}/1_TrimAltRemoveNoCall_${infile}

#####################
## VARIANTS
#####################

## Get just the bi SNP

java -jar -Xmx4G ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L ${Chrom} \
-V ${outdir}/1_TrimAltRemoveNoCall_${infile} \
--restrictAllelesTo BIALLELIC \
--selectTypeToInclude SNP \
-o ${outdir}/'2snp_Filter_TrimAltRemoveNoCall_'${infile}

## this applies gatk hard filters, masks out the NCBIRepeats, and makes genotypes with GQ <20 or DP <2 > max ... 

java -jar -Xmx4G ${GATK} \
-T VariantFiltration \
-R ${REFERENCE} \
-L ${Chrom} \
-V ${outdir}/'2snp_Filter_TrimAltRemoveNoCall_'${infile} \
--mask ${NCBIRepeats} --maskName "FAIL_RepMask" \
--filterExpression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 3.0" \
--filterName "FAIL_GATKHF" \
--clusterWindowSize 10 --clusterSize 3 \
-o ${outdir}/'3snp_VF_Flagged_GaTKHF_cluster_'${infile}

### Second round of select variants
java -jar -Xmx4G ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L ${Chrom} \
-V ${outdir}/'3snp_VF_Flagged_GaTKHF_cluster_'${infile} \
-ef \
-o ${outdir}/'4snp_VF_Filtered_GaTKHF_cluster_'${infile}

#########
## NONVARIANTS
#########

## Get just the nonvariants

## Select the invariants - does this work, or should I use jexl to select 'ALT = '.'
# i use the maxnocall fraction because some sites are missing across the board
java -jar -Xmx4G ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L ${Chrom} \
-V ${outdir}/1_TrimAltRemoveNoCall_${infile} \
--selectTypeToInclude NO_VARIATION \
-o ${outdir}/2nv_AllNonVariants_${infile}

java -jar -Xmx4G ${GATK} \
-T VariantFiltration \
-R ${REFERENCE} \
-L ${Chrom} \
-V ${outdir}/2nv_AllNonVariants_${infile} \
--filterExpression "QUAL < 30 " \
--filterName "FAIL_QUALlt30" \
--mask ${NCBIRepeats} --maskName "FAIL_RepMask" \
-o ${outdir}/'3nv_Flagged_AllNonVariantsRepeatmaskQUAL_'${infile}


### Second round of select variants
java -jar -Xmx4G ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L ${Chrom} \
-V ${outdir}/'3nv_Flagged_AllNonVariantsRepeatmaskQUAL_'${infile} \
-ef \
-o ${outdir}/'4nv_Filtered_AllNonVariantsRepeatmaskQUAL_'${infile}


#############
## merge back together the variant and invariant files - hopefully we can do that.
#############
# catvariants didn't work

java -jar -Xmx4G ${GATK} \
-T CombineVariants \
-R ${REFERENCE} \
-V ${outdir}/'4snp_VF_Filtered_GaTKHF_cluster_'${infile} \
-V ${outdir}/'4nv_Filtered_AllNonVariantsRepeatmaskQUAL_'${infile} \
-L ${Chrom} \
--assumeIdenticalSamples \
-o ${outdir}/'5_v4_mergeGaTKfiltered_varnonvar_'${infile}

## clean up
#rm ${outdir}/1_TrimAltRemoveNoCall_${infile}
#rm ${outdir}/'2snp_Filter_TrimAltRemoveNoCall_'${infile}
#rm ${outdir}/'3snp_VF_Flagged_GaTKHFGQ20_cluster_'${infile}
#rm ${outdir}/'4snp_VF_Filtered_GaTKHFGQ20_cluster_'${infile}
#rm ${outdir}/2nv_AllNonVariants_${infile}
#rm ${outdir}/'3nv_Flagged_AllNonVariantsRepeatmaskQUAL_'${infile}
#rm ${outdir}/'4nv_Filtered_AllNonVariantsRepeatmaskQUAL_'${infile}

sleep 300
