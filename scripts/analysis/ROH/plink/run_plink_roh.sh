
# this script is for running plink roh on a vcf (and optionally, other plink commands)
# start by converting vcf to .map file, then .map to .bed
# can be run in interactive node in a few min

#see manual for more info: http://zzz.bwh.harvard.edu/plink/ibdibs.shtml

. /u/local/Modules/default/init/modules.sh
module load plink

#file=21Moose_joint_FilterB_Round1_autosomes_SNPs_PASS
#indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/15_getPassSites
#outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/ROH_IBD/




cd ${outdir}
mkdir -p plink_output_${file}
cd plink_output_${file}



#plink --vcf ${indir}/${file}.vcf.gz --recode --out ${file} --allow-extra-chr

# Pairwise IBD estimation
#plink --file 7_SNPs_bespokefixed_v4_minRGQ1minGQ20minDP10maxHet0.99missing2_5_v4_mergeGaTKfiltered_4Caracals_joint_allchr_RENAMEDchr_PLINK --genome --genome-full



#Inbreeding Coefficients:
#plink --file ${file} --het --allow-extra-chr


# ROH - first need to make .bed file (NOT the same as coordinate file)

#plink --file ${file} --make-bed --out ${file} --allow-extra-chr


#plink --bfile ${file} --homozyg --homozyg-snp 50 --homozyg-kb 300 --homozyg-density 50 --homozyg-gap 1000 --homozyg-window-snp 50 --homozyg-window-het 3 --homozyg-window-missing 10 --homozyg-window-threshold 0.005 --out ceballos_10miss_3het --allow-extra-chr

#plink --bfile ${file} --homozyg --homozyg-snp 10 --homozyg-kb 500 --homozyg-density 50 --homozyg-gap 1000 --homozyg-window-snp 1000 --homozyg-het 999 --homozyg-window-het 3 --homozyg-window-missing 10 --homozyg-window-threshold 0.05 --out dussex --allow-extra-chr

plink --bfile ${file} --homozyg --homozyg-window-snp 200 --homozyg-window-het 3 --homozyg-window-missing 120 --out robinson_120missing --allow-extra-chr

