#!/bin/bash

#individuals_array=(IR3927 IR3928 IR3929 IR3931 MN31 MN41 MN54 MN96)
individuals_array=(MN31 MN41 MN54 MN96)

for i in "${individuals_array[@]}"
do

qsub -N ${i}.06_BQSR 06_BQSR_JAR.sh ${i} 1R

sleep 1m

done
