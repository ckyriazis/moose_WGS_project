#! /bin/bash
#$ -cwd
#$ -l h_rt=10:00:00,h_data=20G
#$ -N easySFSProjection
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS/projection/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS/projection/jobfiles
#$ -m abe
#$ -M ckyriazi
#$ -t 2-29


source /u/home/c/ckyriazi/miniconda2/etc/profile.d/conda.sh
conda activate demog

source /u/local/Modules/default/init/modules.sh
module load R

bgzip=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/bgzip
vcfdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SFS/projection/projection_preview
popFile=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS/projection/popFile.txt
perPopHetFilter=0.75 # the vcf file has already had some degree of maxHetFiltering. now per-population, easy sfs will do per-population filtering at this level  
scriptdir=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS/projection
easySFS=$scriptdir/easySFS.abModified.3.noInteract.Exclude01Sites.HetFiltering.20181121.py
# this version of script filters het sites that are excessively heterozygous 


## choose your projections: choosing for now: 
### NOTE: projection values must be in same order as populations are in your popFile
populations="MN,IR"
projections="14,10" # haploids



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


############################### NEUTRAL SITE PROJECTIONS #############################

outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SFS/projection/projection-hetFilter-${perPopHetFilter}/${Chrom}
mkdir -p $outdir
# make sure vcf isn't zipped

allVCF=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/getNeutralRegions/step6/Neutral_sites_SFS_${Chrom}.vcf.gz
snpVCF=$vcfdir/Neutral_sites_SFS_${Chrom}_SNPs.vcf


### NOTE: projection values must be in same order as populations are in your popFile (this isn't ideal -- at some point I am going to modify the easySFS script)
$easySFS -i ${snpVCF} -p $popFile -a -v --proj $projections -f -o $outdir -maxHetFilter $perPopHetFilter


########## get counts of monomorphic sites to add to the SFSes ############
# will output two files, one for individual population's counst and one file with the pairs of populations 
# for the pairs of populations, it is a count of sites where both populations were monomorphic at whatever their 
# individual projection levels were. Note that easy sfs takes care of cases where one pop is monomorphic and the other is polymorphic
# this is just about sites where all individuals in all pops is monomorphic but where there might be missing data
# for example: a monomorphic site that is 0/0 for all individuals. Alaska has > Projection value gts at that site, so does KUR, so it would be included in the AK-KUR 2D sfs
# if at another site, AK has > proj value but KUR has < its proj value, that site wouldn't be included in the 2D sfs (though would be included in AK's 1D sfs)
### updated this script to also write out the projection values for use in fsc wrapper script.

python $scriptdir/getMonomorphicProjectionCounts.1D.2DSFS.py --vcf ${allVCF} --popMap $popFile --proj $projections --popIDs $populations --outdir $outdir



############## adding monomorphic sites to fsc and dadi SFSes and writing out totals #####################
 # this script add monomorphic sites to 0 bin of fsc sfses. (overkill in dadi because it gets masked, but does it for completeness ) 
Rscript $scriptdir/easySFS_addInMonomorphicSites.R --dataDir $outdir --popFile $popFile --class neutral # will write them out in your data dir in new directories
# need to modify this R script so that it also adds to 2D sfses.




################################################################################
##################################### coding sites #############################
################################################################################

#cdsVCF=cds_all_9_maxHetFilter_${allSamplesHetFilter}_rmRelatives_rmAdmixed_passingBespoke_maxNoCallFrac_1.0_rmBadIndividuals_passingFilters_raw_variants.vcf.gz
#synVCF=syn_vep_cds_snp_9b_forEasySFS_maxHetFilter_${allSamplesHetFilter}_rmRelatives_rmAdmixed_passingBespoke_maxNoCallFrac_1.0_passingBespoke_passingAllFilters_postMerge_raw_variants.vcf
#misVCF=missense_vep_cds_snp_9b_forEasySFS_maxHetFilter_${allSamplesHetFilter}_rmRelatives_rmAdmixed_passingBespoke_maxNoCallFrac_1.0_passingBespoke_passingAllFilters_postMerge_raw_variants.vcf

#outdir=/u/flashscratch/a/ab08028/captures/analyses/SFS/$genotypeDate/easySFS/cds/synonymous/projection-${todaysdate}-hetFilter-${perPopHetFilter}
#mkdir -p $outdir
# $easySFS -i $vcfdir/cdsVCFs/${synVCF} -p $popFile -a -v --proj $projections -f -o $outdir -maxHetFilter $perPopHetFilter

#outdir=/u/flashscratch/a/ab08028/captures/analyses/SFS/$genotypeDate/easySFS/cds/missense/projection-${todaysdate}-hetFilter-${perPopHetFilter}
#mkdir -p $outdir
# $easySFS -i $vcfdir/cdsVCFs/${misVCF} -p $popFile -a -v --proj $projections -f -o $outdir -maxHetFilter $perPopHetFilter


########## get counts of monomorphic cds sites -- still have to think about how to scale these for syn/mis ############
#outdir=/u/flashscratch/a/ab08028/captures/analyses/SFS/$genotypeDate/easySFS/cds/monomorphicCDSSites/projection-${todaysdate}-hetFilter-${perPopHetFilter}
#mkdir -p $outdir
#python $scriptdir/getMonomorphicProjectionCounts.py --vcf $vcfdir/cdsVCFs/${cdsVCF} --popMap $popFile --proj $projections --popIDs CA,AK,AL,COM,KUR --outdir $outdir
#python $scriptdir/getMonomorphicProjectionCounts.1D.2DSFS.py --vcf $vcfdir/cdsVCFs/${cdsVCF} --popMap $popFile --proj $projections --popIDs CA,AK,AL,COM,KUR --outdir $outdir


