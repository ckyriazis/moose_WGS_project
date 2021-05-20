#!/bin/bash


individuals_array=(SMoose)

for i in "${individuals_array[@]}"
do

qsub -N ${i}BwaMem step3b_BwaMem.sh ${i} /u/flashscratch/c/ckyriazi/moose/output/03_AlignCleanBam /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/03_AlignCleanBam 
sleep 2m

done
