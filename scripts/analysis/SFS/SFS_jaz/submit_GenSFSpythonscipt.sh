
#!/bin/bash
#$ -l highp,h_rt=1:00:00,h_data=2G
#$ -N SFS
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SFS/
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SFS/
#$ -M ckyriazi


FILE=9Moose_joint_Filter_B_NC_037355.1_IR.recode

WKDIR=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SFS/

. /u/local/Modules/default/init/modules.sh
module load python/2.7

python generateSFSCounts.py ${WKDIR}/vcfs/${FILE}.vcf ${WKDIR}/CountsforSFS_${FILE}.txt



