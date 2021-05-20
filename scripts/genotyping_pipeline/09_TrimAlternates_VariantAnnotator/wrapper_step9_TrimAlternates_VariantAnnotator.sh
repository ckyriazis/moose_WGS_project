#!/bin/bash


qsub -N step9 -m abe -t 1-1:1 09_TrimAlternates_VariantAnnotator.sh

