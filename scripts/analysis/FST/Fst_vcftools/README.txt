These scripts are for calculating Fst between populations using vcftools.

I tried to use it to calculate between individuals and resulted in 'NaN'

Usage is: vcftools --gzvcf 7_SNPs_bespokefixed_v4_minRGQ1minGQ20minDP10maxHet0.99missing2_5_v4_mergeGaTKfiltered_4Caracals_joint_allchr.vcf.gz --weir-fst-pop nonCP.txt --weir-fst-pop CP.txt --out pop_pairwise_fst_vcftools

Takes about 5-10 min to run on interactive node. 

See here for details: http://vcftools.sourceforge.net/documentation.html#fst


