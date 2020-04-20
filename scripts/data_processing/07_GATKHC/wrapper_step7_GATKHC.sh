#!/bin/bash


# Uncomment the line below and fill in the name of the individuals.
individuals_array=(IR3928)
#individuals_array=(IR3925)

for i in "${individuals_array[@]}"
do

qsub -N ${i}.step7 -t 30-30:1 step7_GATKHC_all.sh ${i} /u/home/c/ckyriazi/kirk-bigdata/moose/output/05_RemoveBadReads /u/home/c/ckyriazi/kirk-bigdata/moose/output/07_GATKHC
sleep 1m

done

