#!/bin/bash


# Uncomment the line below and fill in the name of the individuals.
individuals_array=(HM2013 C06)

for i in "${individuals_array[@]}"
do

qsub -N ${i}RemoveBadReads step5_RemoveBadReads.sh ${i} /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/04_MarkDups /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/05_RemoveBadReads
sleep 1m

done
