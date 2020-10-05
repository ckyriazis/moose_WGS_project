#!/bin/bash


# Uncomment the line below and fill in the name of the individuals.
individuals_array=(IR3920 IR3921 IR3930 IR3934 MN15 MN178 MN72 MN76 MN92)

for i in "${individuals_array[@]}"
do

qsub -N ${i}RemoveBadReads step5_RemoveBadReads.sh ${i} /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/04_MarkDups /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/05_RemoveBadReads
sleep 1m

done
