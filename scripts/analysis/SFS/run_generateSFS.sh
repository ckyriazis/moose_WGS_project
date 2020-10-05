#! /bin/bash
#$ -cwd
#$ -l highp,h_rt=36:00:00,h_data=4G
#$ -N MN_cow_filtered_SFS
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS
#$ -m abe
#$ -M ckyriazi

# wrapper for making neutral SFSs with my custom script generate1DSFS.py
source /u/local/Modules/default/init/modules.sh
module load python/2.7

pop=MN
filt=filtered
ref_dir=output
vcf=18Moose_joint_FilterB_Round8_NC_037328.1_${pop}.recode.vcf.gz

script=generate1DSFS_${filt}.py
prefix=NC_037328.1_${filt}
vcfdir=/u/home/c/ckyriazi/kirk-bigdata/moose/${ref_dir}/analysis/SFS/vcfs
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/${ref_dir}/analysis/SFS/

python $script --vcf $vcfdir/${vcf} --pop $pop --outdir $outdir --outPREFIX $prefix
