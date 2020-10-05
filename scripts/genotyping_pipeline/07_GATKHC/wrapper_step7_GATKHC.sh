#!/bin/bash


# Uncomment the line below and fill in the name of the individuals.
#individuals_array=(IR3920 IR3921 IR3930 IR3934 MN15 MN178 MN72 MN76 MN92)

individuals_array=(MN92)

for i in "${individuals_array[@]}"
do

qsub -N ${i}.step7 -t 11-11:1 step7_GATKHC_all.sh ${i} /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/05_RemoveBadReads /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/07_GATKHC
sleep 1m

done

