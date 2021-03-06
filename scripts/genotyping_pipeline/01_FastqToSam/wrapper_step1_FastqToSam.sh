#!/bin/bash

#. /u/local/etc/profile.d/sge.sh
#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub

# Uncomment the line below and fill in the name of the individuals.
individuals_array=(MN15 MN178 MN72 MN76 MN92) 


for i in "${individuals_array[@]}"
do

qsub -N ${i}FastqToSam step1_FastqToSam.sh ${i} /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/moose_genomes_042320 /u/flashscratch/c/ckyriazi/moose/output/01_FastqToSam
sleep 1m

done
