#! /bin/bash
#$ -cwd
#$ -l h_rt=23:59:00,h_data=16G
#$ -N easySFSPreview
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS/projection/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS/projection/jobfiles
#$ -m abe
#$ -M ckyriazi


# note that this can be done just for one chrom - results look ~identical from one to the next
# also - make sure to extract SNPs from vcf first

source /u/home/c/ckyriazi/miniconda2/etc/profile.d/conda.sh
conda activate demog


popFile=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS/projection/popFile.txt 
easySFS=easySFS.abModified.3.noInteract.Exclude01Sites.HetFiltering.20181121.py
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SFS/projection/projection_preview
Chrom=NC_037328.1
vcf=Neutral_sites_SFS_${Chrom}
mkdir -p $outdir



# do projection on vcf with only SNPs
python $easySFS -i ${outdir}/${vcf}_SNPs.vcf -p $popFile --preview -a -v > $outdir/neutral.${Chrom}.easySFS.projPreview.txt


