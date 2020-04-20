#!/bin/bash


# Uncomment the line below and fill in the name of the individuals.
individuals_array=(IR3925 IR3927 IR3928 IR3929 IR3931)

for i in "${individuals_array[@]}"
do

#MAKE SURE TO CHECK WHICH SCRIPT THIS IS RUNNING
qsub -N ${i}MarkDups step4_MarkDups_deer.sh ${i} /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/03_AlignCleanBam /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/04_MarkDups
sleep 1m

done
