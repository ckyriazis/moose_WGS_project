#!/bin/bash
#$ -l highp,h_rt=6:00:00,h_data=4G
#$ -pe shared 2
#$ -N plink_pca
#$ -cwd
#$ -m bea
#$ -M ckyriazi


. /u/local/Modules/default/init/modules.sh
module load plink

plink --bfile 7_SNPs_bespokefixed_v4_minRGQ1minGQ20minDP10maxHet0.99missing2_5_v4_mergeGaTKfiltered_4Caracals_joint_allchr_RENAMEDchr_PLINK --pca 10 --out pca_output

