#!/bin/bash

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub

# Uncomment the line below and fill in the name of the individuals.
individuals_array=(IR3925 IR3927 IR3928 IR3929 IR3931) 

for i in "${individuals_array[@]}"
do

qsub -N ${i}MarkAdapters step2_MarkAdapters.sh ${i} /u/flashscratch/c/ckyriazi/moose/hogdeer_output/01_FastqToSam /u/flashscratch/c/ckyriazi/moose/hogdeer_output/02_MarkAdapters
sleep 1m

done
