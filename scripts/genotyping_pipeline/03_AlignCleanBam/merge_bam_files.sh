#!/bin/bash
#$ -l highp,h_rt=48:00:00,h_data=8G
#$ -pe shared 8
#$ -N mergeBams
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/03_AlignCleanBam/
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/03_AlignCleanBam/
#$ -M ckyriazi

PICARD=/u/local/apps/picard-tools/2.9.0/picard.jar
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna
#REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/hogdeer_reference/GCA_003798545.1_ASM379854v1_genomic.fna

indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/03_AlignCleanBam


. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77


#java -Xmx16G -jar ${PICARD} MergeSamFiles \
#      I=${indir}/SRR6079205/SRR6079205_AlignCleanBam.bam  \
#      I=${indir}/SRR6079204/SRR6079204_AlignCleanBam.bam  \
#      I=${indir}/SRR6079203/SRR6079203_AlignCleanBam.bam  \
#      I=${indir}/SRR6079184/SRR6079184_AlignCleanBam.bam  \
#      I=${indir}/SRR6079183/SRR6079183_AlignCleanBam.bam  \
#      I=${indir}/SRR6079182/SRR6079182_AlignCleanBam.bam  \
#      I=${indir}/SRR6079181/SRR6079181_AlignCleanBam.bam  \
#      O=${indir}/R199/R199_AlignCleanBam.bam
#      R=$REFERENCE CREATE_INDEX=true


java -Xmx16G -jar ${PICARD} MergeSamFiles \
      I=${indir}/SRR6079202/SRR6079202_AlignCleanBam.bam  \
      I=${indir}/SRR6079201/SRR6079201_AlignCleanBam.bam  \
      I=${indir}/SRR6079200/SRR6079200_AlignCleanBam.bam  \
      I=${indir}/SRR6079199/SRR6079199_AlignCleanBam.bam  \
      I=${indir}/SRR6079198/SRR6079198_AlignCleanBam.bam  \
      I=${indir}/SRR6079197/SRR6079197_AlignCleanBam.bam  \
      I=${indir}/SRR6079194/SRR6079194_AlignCleanBam.bam  \
      I=${indir}/SRR6079193/SRR6079193_AlignCleanBam.bam  \
      O=${indir}/JC2001/JC2001_AlignCleanBam.bam
      R=$REFERENCE CREATE_INDEX=true


java -Xmx16G -jar ${PICARD} MergeSamFiles \
      I=${indir}/SRR6079192/SRR6079192_AlignCleanBam.bam  \
      I=${indir}/SRR6079191/SRR6079191_AlignCleanBam.bam  \
      I=${indir}/SRR6079190/SRR6079190_AlignCleanBam.bam  \
      I=${indir}/SRR6079189/SRR6079189_AlignCleanBam.bam  \
      I=${indir}/SRR6079188/SRR6079188_AlignCleanBam.bam  \
      I=${indir}/SRR6079187/SRR6079187_AlignCleanBam.bam  \
      I=${indir}/SRR6079186/SRR6079186_AlignCleanBam.bam  \
      I=${indir}/SRR6079185/SRR6079185_AlignCleanBam.bam  \
      O=${indir}/HM2013/HM2013_AlignCleanBam.bam
      R=$REFERENCE CREATE_INDEX=true


java -Xmx16G -jar ${PICARD} MergeSamFiles \
      I=${indir}/SRR6079195/SRR6079195_AlignCleanBam.bam  \
      I=${indir}/SRR6079180/SRR6079180_AlignCleanBam.bam  \
      I=${indir}/SRR6079179/SRR6079179_AlignCleanBam.bam  \
      I=${indir}/SRR6079178/SRR6079178_AlignCleanBam.bam  \
      I=${indir}/SRR6079177/SRR6079177_AlignCleanBam.bam  \
      I=${indir}/SRR6079176/SRR6079176_AlignCleanBam.bam  \
      I=${indir}/SRR6079175/SRR6079175_AlignCleanBam.bam  \
      O=${indir}/C06/C06_AlignCleanBam.bam
      R=$REFERENCE CREATE_INDEX=true


                                                                                
