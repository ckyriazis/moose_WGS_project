#!/bin/bash

QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub

# Uncomment the line below and fill in the name of the individuals.
individuals_array=(C23)

for i in "${individuals_array[@]}"
do

$QSUB -N ${i}.step8 -t 1-2:1 step8_GATKHG_longChr.sh ${i} /u/flashscratch/c/ckyriazi/caracals/analyses/step7_BQSR /u/flashscratch/c/ckyriazi/caracals/analyses/step8_GATKHG
sleep 5m

done

