#! /bin/bash
#$ -cwd
#$ -l highp,h_rt=36:00:00,h_data=4G
#$ -N SFS
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/SFS/jobfiles
#$ -m abe
#$ -M ckyriazi

# wrapper for making neutral SFSs with my custom script generate1DSFS.py
source /u/local/Modules/default/init/modules.sh
module load python/2.7

filt=filtered
ref_dir=output
vcf=18Moose_joint_FilterB_Round17_autosomes_
#vcf=18Moose_joint_FilterB_Round16_NC_037328.1_
pop=IR


script=generate1DSFS_${filt}.py
vcfdir=/u/home/c/ckyriazi/kirk-bigdata/moose/${ref_dir}/analysis/SFS/vcfs
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/${ref_dir}/analysis/SFS/

python ${script} --vcf ${vcfdir}/${vcf}${pop}.recode.vcf.gz --pop ${pop} --outdir ${outdir} --outPREFIX ${vcf}${pop}
