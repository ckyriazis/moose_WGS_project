#!/bin/bash

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub

# Uncomment the line below and fill in the name of the individuals.
#individuals_array=( SRR6079175 SRR6079176 SRR6079177 SRR6079178 SRR6079179 SRR6079180 SRR6079181 SRR6079182 SRR6079183 SRR6079184 SRR6079185 SRR6079186 SRR6079187 SRR6079188 SRR6079189  SRR6079190 SRR6079191 SRR6079192 SRR6079193 SRR6079194 SRR6079195 SRR6079197 SRR6079198 SRR6079199 SRR6079200 SRR6079201 SRR6079202 SRR6079203 SRR6079204 SRR6079205 SRR6079206)

individuals_array=(SMoose) 

for i in "${individuals_array[@]}"
do

qsub -N ${i}MarkAdapters step2_MarkAdapters.sh ${i} /u/flashscratch/c/ckyriazi/moose/output/01_FastqToSam /u/flashscratch/c/ckyriazi/moose/output/02_MarkAdapters
sleep 1m

done
