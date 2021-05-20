#!/bin/bash


# Uncomment the line below and fill in the name of the individuals.
individuals_array=(SMoose)

for i in "${individuals_array[@]}"
do

qsub -N ${i}MergeBamAlignment step3c_PicardMergeBamAlignment.sh ${i} /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/03_AlignCleanBam /u/flashscratch/c/ckyriazi/moose/output/01_FastqToSam /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/03_AlignCleanBam
sleep 1m

done
