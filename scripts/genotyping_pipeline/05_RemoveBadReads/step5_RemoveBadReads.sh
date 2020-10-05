#!/bin/bash
#$ -l highp,h_rt=24:00:00,h_data=8G
#$ -pe shared 4
#$ -N moose_RemoveBadReads
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/05_RemoveBadReads
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/05_RemoveBadReads
#$ -M ckyriazi


# Optional step to remove bad reads prior to BQSR.
# samtools options:
# -h: include the header in the output
# -b: output in the BAM format
# -f: only output alignments with all bits set in INT present in the FLAG field.
# -F: Do not output alignments with any bits set in INT present in the FLAG field. 
# -q: skip alignments with MAPQ smaller than INT


. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77
module load samtools/1.3.1


Individual=$1
InDir=$2
OutDir=$3

samtools view -hb -f 2 -F 256 -q 30 ${InDir}/${Individual}/${Individual}_MarkDups.bam | samtools view -hb -F 1024 > ${OutDir}/${Individual}/${Individual}_RemoveBadReads.bam
#samtools view -hb -f 2 -F 256 -q 30 ${InDir}/${Individual}/${Individual}_MarkDups.bam > test.out
#samtools view -hb -f 2 -F 256 -q 30 ${InDir}/${Individual}/${Individual}_MarkDups.bam | samtools view -hb -F 1024 > out.bam


java -jar /u/local/apps/picard-tools/2.9.0/picard.jar BuildBamIndex \
VALIDATION_STRINGENCY=LENIENT \
I=${OutDir}/${Individual}/${Individual}_RemoveBadReads.bam
