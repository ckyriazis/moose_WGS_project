# R script to use on hoffman
# module load R
# R 
# install R packages
#source("https://bioconductor.org/biocLite.R")
#biocLite("gdsfmt")
#biocLite("SNPRelate")
# usage:
# module load R
# Rscript filtering_Step_4_ConvertToGDS.Hoffman.R [set the calldate and indir and infile manually, or can adjust script to make it a command line option.]
# can be run in the shell (will take ~ 10 min)
#load R packages

require(gdsfmt)
require(SNPRelate)

#calldate=20180806 # date gt's were called in format YYYYMMDD (set this manually)
todaysdate=format(Sys.Date(),format="%Y%m%d")
indir="/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/15_getPassSites/" # this is where your snp vcf file is and where you will save your gds file
infilePREFIX="21Moose_joint_FilterB_Round1_autosomes_SNPs_PASS" # exclude the .vcf.gz suffix 
outdir="/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SNPrelate/"
dir.create(outdir,showWarnings = F)
#read vcf, and reformat to gds (this works with gzipped vcf file)

vcf.fn = paste(indir,infilePREFIX,".vcf.gz",sep="")

# took ~ 5 mins (only need to do once -- in future can just open the gds file)
snpgdsVCF2GDS(vcf.fn, paste(outdir,infilePREFIX,".gds",sep=""), method="biallelic.only")

#summary -- write it out
# Open an output file
sink(file=paste(outdir,infilePREFIX,".gds.summary.txt",sep=""))
snpgdsSummary(paste(outdir,infilePREFIX,".gds",sep=""))
# close summary file
sink()

# you can then download the gds file and work with it in R on your home computer: for me download to: /Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/datafiles/snps_gds
