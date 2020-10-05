#!/bin/bash
#$ -l highp,h_rt=12:00:00,h_data=8G
#$ -pe shared 4
#$ -N moose_PicardMergeBamAlignment
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/03_AlignCleanBam/
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/03_AlignCleanBam/
#$ -M ckyriazi

PICARD=/u/local/apps/picard-tools/2.9.0/picard.jar
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna
#REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/hogdeer_reference/GCA_003798545.1_ASM379854v1_genomic.fna

Individual=$1
AlignedBamDir=$2
UnmappedBamDir=$3
OutDir=$4

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77


java -Xmx16G -jar ${PICARD} MergeBamAlignment \
ALIGNED_BAM=${AlignedBamDir}/${Individual}/${Individual}_BwaMem.bam \
UNMAPPED_BAM=${UnmappedBamDir}/${Individual}/${Individual}_FastqToSam.bam \
OUTPUT=${OutDir}/${Individual}/${Individual}_AlignCleanBam.bam \
R=$REFERENCE CREATE_INDEX=true \
ADD_MATE_CIGAR=true CLIP_ADAPTERS=false CLIP_OVERLAPPING_READS=true \
INCLUDE_SECONDARY_ALIGNMENTS=true MAX_INSERTIONS_OR_DELETIONS=-1 \
PRIMARY_ALIGNMENT_STRATEGY=MostDistant ATTRIBUTES_TO_RETAIN=XS \
2>>${OutDir}/${Individual}/${Individual}_Process_MergeBam.txt
