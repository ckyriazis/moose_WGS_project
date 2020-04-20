#!/bin/bash
#$ -l highp,h_rt=200:00:00,h_data=8G
#$ -pe shared 4
#$ -N moose_BwaMem
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/03_AlignCleanBam
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/03_AlignCleanBam
#$ -M ckyriazi

. /u/local/Modules/default/init/modules.sh
module load bwa/0.7.17



#REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/reference/GCF_002263795.1_ARS-UCD1.2_genomic.fna
#REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/deer_reference/GCA_002197005.1_CerEla1.0_genomic.fna
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/hogdeer_reference/GCA_003798545.1_ASM379854v1_genomic.fna


Individual=$1
inDir=$2
outDir=$3

bwa mem -M -t 3 -p $REFERENCE ${inDir}/${Individual}/${Individual}_CleanBamToFastq.fastq 2>> ${outDir}/${Individual}/${Individual}_Process_BwaMem.txt > ${outDir}/${Individual}/${Individual}_BwaMem.bam
