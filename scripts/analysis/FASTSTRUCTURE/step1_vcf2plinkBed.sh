# can be run in the shell on an interactive node (takes ~ 1min)
###### Need to convert vcf file to plink bed format 
# isn't there some issue with chromosomes?
# need to make sure it's only SNPs not invariant sites
# so want to convert my final SNP file

source /u/local/Modules/default/init/modules.sh
module load plink


filtering_round=21moose_round1
indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/15_getPassSites
infile=21Moose_joint_FilterB_Round1_autosomes_SNPs_PASS.vcf.gz
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/FASTSTRUCTURE/$filtering_round
mkdir $outdir
# you need to use const-fid 0 otherwise it thinks that family name_sample name is structure of ID and tries to split it (and fails)
# allow extra chromosomes: to get it to get over the fact that chr names are non standard (make sure these wont get ignored?)
plink --vcf $indir/$infile --make-bed --keep-allele-order --const-fid 0 --allow-extra-chr --maf 0.05 -out $outdir/${infile%.vcf.gz}
### note for faststructure to work you have to filter on maf 0.05
