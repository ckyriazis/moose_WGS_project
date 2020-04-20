#!/bin/bash


# Uncomment the line below and fill in the name of the individuals.
individuals_array=(IR3925 IR3927 IR3928 IR3929 IR3931)

for i in "${individuals_array[@]}"
do

qsub -N ${i}MergeBamAlignment step3c_PicardMergeBamAlignment.sh ${i} /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/03_AlignCleanBam /u/flashscratch/c/ckyriazi/moose/hogdeer_output/01_FastqToSam /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/03_AlignCleanBam
sleep 1m

done
