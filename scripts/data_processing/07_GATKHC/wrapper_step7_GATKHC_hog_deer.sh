#!/bin/bash


# Uncomment the line below and fill in the name of the individuals.
#individuals_array=(IR3925 IR3927 IR3928 IR3929 IR3931 MN31 MN41 MN54 MN96)
individuals_array=(MN96)

for i in "${individuals_array[@]}"
do

qsub -N ${i}.step7 -t 112-113:1 step7_GATKHC_hog_deer.sh ${i} /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/05_RemoveBadReads /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/07_GATKHC
sleep 1m

done

