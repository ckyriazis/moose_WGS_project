## this script does two things - first it runs the python script to filter
## Then it extracts out just the SNPs with GaTK

abb=$1

###########################
## NOW FOR GATK ###
###########################

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK="/u/home/c/cmarsden/project-klohmueldata/clares_data/software/gatk_37/GenomeAnalysisTK.jar"

REFERENCE='/u/home/c/cmarsden/project-klohmueldata/clares_data/canids/reference/canFam3/canFam3.fa'
# Using UCSC repeats only not breannans
UCSCRepeats='/u/home/c/cmarsden/project-klohmueldata/clares_data/canids/reference/USCS_repeatmask/UCSC_repeatmask_excUNchr.bed'
abb=$1 #TenGS,TenAW
chromnum=${SGE_TASK_ID}
#chromnum=38
mychrom='chr'${chromnum}
infile='6_bespokefixed_v4_minRGQ1minGQ20minDP10maxHet0.99missing2_5_v4_mergeGaTKfiltered_varnonvar_'${abb}'_jointcalled_'${mychrom}'.vcf.gz'
#infile='head100k.vcf'
indir='/u/home/c/cmarsden/project-kirk-bigdata/FINAL_VCFS_May2018_INCrels/final_filtered_vcf_allsites_6files/'${abb}
outdir='/u/home/c/cmarsden/project-kirk-bigdata/FINAL_VCFS_May2018_INCrels/final_filtered_vcf_justSNPs_6files/'${abb}

java -jar -Xmx4G ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L ${mychrom} \
-V ${indir}/${infile} \
--restrictAllelesTo BIALLELIC \
--selectTypeToInclude SNP \
-o ${outdir}/'BiSNP_'${infile}
