#!/bin/bash
#$ -l highp,h_rt=16:00:00,h_data=8G
#$ -pe shared 4
#$ -N subset_ROH
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/ROH/bcftools/runfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/ROH/bcftools/runfiles
#$ -M ckyriazi



## This script is for subsetting bcftools roh output by individual, since the output files are 
## very large (20g for 9 inds)
## The script also compresses the files, as they can be read into R when gzipped

cd /u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/ROH_IBD/ 

file=18moose_round9_roh_bcftools_G30.out
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

awk '$2 == "IR3920" { print }' tmp.txt > IR3920_${file}
awk '$2 == "IR3921" { print }' tmp.txt > IR3921_${file}
awk '$2 == "IR3930" { print }' tmp.txt > IR3930_${file}
awk '$2 == "IR3934" { print }' tmp.txt > IR3934_${file}
awk '$2 == "MN15" { print }' tmp.txt > MN15_${file}
awk '$2 == "MN178" { print }' tmp.txt > MN178_${file}
awk '$2 == "MN72" { print }' tmp.txt > MN72_${file}
awk '$2 == "MN76" { print }' tmp.txt > MN76_${file}
awk '$2 == "MN92" { print }' tmp.txt > MN92_${file}



wait

gzip IR*
gzip MN*



