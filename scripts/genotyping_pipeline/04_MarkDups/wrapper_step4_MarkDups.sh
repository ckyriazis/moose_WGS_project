#!/bin/bash


# Uncomment the line below and fill in the name of the individuals.
individuals_array=(MN76)

for i in "${individuals_array[@]}"
do

#MAKE SURE TO CHECK WHICH SCRIPT THIS IS RUNNING
qsub -N ${i}MarkDups step4_MarkDups.sh ${i} /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/03_AlignCleanBam /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/04_MarkDups
sleep 1m

done
