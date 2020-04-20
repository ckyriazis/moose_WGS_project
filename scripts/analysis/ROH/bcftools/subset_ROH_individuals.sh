#!/bin/bash
#$ -l highp,h_rt=8:00:00,h_data=8G
#$ -N subset_ROH
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/analysis/ROH_IBD
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/analysis/ROH_IBD
#$ -M ckyriazi



## This script is for subsetting bcftools roh output by individual, since the output files are 
## very large (20g for 9 inds)
## The script also compresses the files, as they can be read into R when gzipped

cd /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/analysis/ROH_IBD/ 

file=moose_roh_bcftools_hogdeer_round1_G30.out
#file=test.txt

tail -n +6 ${file} > tmp.txt



awk '$2 == "IR3925" { print }' tmp.txt > IR3925_${file}
awk '$2 == "IR3927" { print }' tmp.txt > IR3927_${file}
awk '$2 == "IR3928" { print }' tmp.txt > IR3928_${file}
awk '$2 == "IR3929" { print }' tmp.txt > IR3929_${file}
awk '$2 == "IR3931" { print }' tmp.txt > IR3931_${file}
awk '$2 == "MN31" { print }' tmp.txt > MN31_${file}
awk '$2 == "MN41" { print }' tmp.txt > MN41_${file}
awk '$2 == "MN54" { print }' tmp.txt > MN54_${file}
awk '$2 == "MN96" { print }' tmp.txt > MN96_${file}


wait

gzip IR*
gzip MN*



