#!/bin/bash

individuals_array=(SMoose)

for i in "${individuals_array[@]}"
do

qsub -N ${i}SamToFastq step3a_SamToFastq.sh ${i} /u/scratch/c/ckyriazi/moose/output/02_MarkAdapters  /u/scratch/c/ckyriazi/moose/output/03_AlignCleanBam/
sleep 1m

done
