#!/bin/bash


qsub -N step8.all -t 1-30:1 08_GenotypeGVCFs_all.sh /u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/08_GenotypeGVCFs


