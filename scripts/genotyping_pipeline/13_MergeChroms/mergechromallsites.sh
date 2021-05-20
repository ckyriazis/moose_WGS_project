
## This cats all the chroms for the allsites vcf.
## Script modified from Clare's version for caracals

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK="/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar"
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna


indir='/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/11_FilterVCFfile/'
outdir='/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/13_MergeChroms'
prefix='21Moose_joint_FilterB_Round1_'
suffix='.vcf.gz'

Chrom1=NC_037328.1
Chrom2=NC_037329.1
Chrom3=NC_037330.1
Chrom4=NC_037331.1
Chrom5=NC_037332.1
Chrom6=NC_037333.1
Chrom7=NC_037334.1
Chrom8=NC_037335.1
Chrom9=NC_037336.1
Chrom10=NC_037337.1
Chrom11=NC_037338.1
Chrom12=NC_037339.1
Chrom13=NC_037340.1
Chrom14=NC_037341.1
Chrom15=NC_037342.1
Chrom16=NC_037343.1
Chrom17=NC_037344.1
Chrom18=NC_037345.1
Chrom19=NC_037346.1
Chrom20=NC_037347.1
Chrom21=NC_037348.1
Chrom22=NC_037349.1
Chrom23=NC_037350.1
Chrom24=NC_037351.1
Chrom25=NC_037352.1
Chrom26=NC_037353.1
Chrom27=NC_037354.1
Chrom28=NC_037355.1
Chrom29=NC_037356.1
Chrom30=NC_037357.1

java -cp ${GATK} org.broadinstitute.gatk.tools.CatVariants \
-R ${REFERENCE} \
-V ${indir}/${prefix}${Chrom1}${suffix} \
-V ${indir}/${prefix}${Chrom2}${suffix} \
-V ${indir}/${prefix}${Chrom3}${suffix} \
-V ${indir}/${prefix}${Chrom4}${suffix} \
-V ${indir}/${prefix}${Chrom5}${suffix} \
-V ${indir}/${prefix}${Chrom6}${suffix} \
-V ${indir}/${prefix}${Chrom7}${suffix} \
-V ${indir}/${prefix}${Chrom8}${suffix} \
-V ${indir}/${prefix}${Chrom9}${suffix} \
-V ${indir}/${prefix}${Chrom10}${suffix} \
-V ${indir}/${prefix}${Chrom11}${suffix} \
-V ${indir}/${prefix}${Chrom12}${suffix} \
-V ${indir}/${prefix}${Chrom13}${suffix} \
-V ${indir}/${prefix}${Chrom14}${suffix} \
-V ${indir}/${prefix}${Chrom15}${suffix} \
-V ${indir}/${prefix}${Chrom16}${suffix} \
-V ${indir}/${prefix}${Chrom17}${suffix} \
-V ${indir}/${prefix}${Chrom18}${suffix} \
-V ${indir}/${prefix}${Chrom19}${suffix} \
-V ${indir}/${prefix}${Chrom20}${suffix} \
-V ${indir}/${prefix}${Chrom21}${suffix} \
-V ${indir}/${prefix}${Chrom22}${suffix} \
-V ${indir}/${prefix}${Chrom23}${suffix} \
-V ${indir}/${prefix}${Chrom24}${suffix} \
-V ${indir}/${prefix}${Chrom25}${suffix} \
-V ${indir}/${prefix}${Chrom26}${suffix} \
-V ${indir}/${prefix}${Chrom27}${suffix} \
-V ${indir}/${prefix}${Chrom28}${suffix} \
-V ${indir}/${prefix}${Chrom29}${suffix} \
-out ${outdir}/${prefix}'autosomes.vcf.gz' \
-assumeSorted

