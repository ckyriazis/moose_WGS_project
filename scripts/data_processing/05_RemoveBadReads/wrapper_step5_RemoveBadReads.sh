#!/bin/bash


# Uncomment the line below and fill in the name of the individuals.
individuals_array=(IR3928)

for i in "${individuals_array[@]}"
do

qsub -N ${i}RemoveBadReads step5_RemoveBadReads.sh ${i} /u/home/c/ckyriazi/kirk-bigdata/moose/output/04_MarkDups /u/home/c/ckyriazi/kirk-bigdata/moose/output/05_RemoveBadReads
sleep 1m

done
