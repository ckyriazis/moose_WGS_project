#!/bin/bash


individuals_array=(IR3927 IR3928 IR3929 IR3931)


for i in "${individuals_array[@]}"
do

qsub -N ${i}BwaMem step3b_BwaMem.sh ${i} /u/flashscratch/c/ckyriazi/moose/hogdeer_output/03_AlignCleanBam /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/03_AlignCleanBam 
sleep 2m

done
