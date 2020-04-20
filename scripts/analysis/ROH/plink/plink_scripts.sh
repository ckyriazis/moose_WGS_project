#see manual for more info: http://zzz.bwh.harvard.edu/plink/ibdibs.shtml

# Pairwise IBD estimation
plink --file 7_SNPs_bespokefixed_v4_minRGQ1minGQ20minDP10maxHet0.99missing2_5_v4_mergeGaTKfiltered_4Caracals_joint_allchr_RENAMEDchr_PLINK --genome --genome-full



#Inbreeding Coefficients:
plink --file 7_SNPs_bespokefixed_v4_minRGQ1minGQ20minDP10maxHet0.99missing2_5_v4_mergeGaTKfiltered_4Caracals_joint_allchr_RENAMEDchr_PLINK --het


# ROH - first need to make .bed file (NOT the same as coordinate file)

plink --file 7_SNPs_bespokefixed_v4_minRGQ1minGQ20minDP10maxHet0.99missing2_5_v4_mergeGaTKfiltered_4Caracals_joint_allchr_RENAMEDchr_PLINK --make-bed --out 7_SNPs_bespokefixed_v4_minRGQ1minGQ20minDP10maxHet0.99missing2_5_v4_mergeGaTKfiltered_4Caracals_joint_allchr_RENAMEDchr_PLINK.bed

plink --bfile 7_SNPs_bespokefixed_v4_minRGQ1minGQ20minDP10maxHet0.99missing2_5_v4_mergeGaTKfiltered_4Caracals_joint_allchr_RENAMEDchr_PLINK --homozyg --homozyg-window-het 5


plink --bfile 7_SNPs_bespokefixed_v4_minRGQ1minGQ20minDP10maxHet0.99missing2_5_v4_mergeGaTKfiltered_4Caracals_joint_allchr_RENAMEDchr_PLINK --homozyg --homozyg-snp 200 --homozyg-kb 2000 --homozyg-window-missing 100 --homozyg-window-het 10 --out marsden_2Mb

plink --bfile 7_SNPs_bespokefixed_v4_minRGQ1minGQ20minDP10maxHet0.99missing2_5_v4_mergeGaTKfiltered_4Caracals_joint_allchr_RENAMEDchr_PLINK --homozyg --homozyg-snp 50 --homozyg-kb 300 --homozyg-density 50 --homozyg-gap 1000 --homozyg-window-snp 50 --homozyg-window-het 5 --homozyg-window-missing 5 --homozyg-window-threshold 0.005 --out ceballos

