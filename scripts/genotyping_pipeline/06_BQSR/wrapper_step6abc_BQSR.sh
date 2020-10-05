#!/bin/bash

individuals_array=(MN96)


for i in "${individuals_array[@]}"
do

qsub -N ${i}.step6abc.R1 step6abc_BQSR_1round.sh ${i} /u/home/c/ckyriazi/kirk-bigdata/moose/deer_output/05_RemoveBadReads /u/home/c/ckyriazi/kirk-bigdata/moose/deer_output/06_BQSR

sleep 1m

done

