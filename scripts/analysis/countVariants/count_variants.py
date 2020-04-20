# script for counting number of annotated variants in IR and MN pops
# modified from annabel's sfs script

import sys
import gzip
import datetime
import argparse
############### Parse input arguments ########################
parser = argparse.ArgumentParser(description='Count number of homRef, het, and homAlt variants for different pops in vcf')
parser.add_argument("--vcf",required=True,help="path to vcf file")
parser.add_argument("--outdir",required=True,help="path to output directory")
parser.add_argument("--outPREFIX",required=False,help="output file prefix (optional)",default="")

args = parser.parse_args()
vcfFile=args.vcf
outdir=str(args.outdir)
prefix=str(args.outPREFIX)

#### OPEN VCF TO READ ######### 
inVCF = gzip.open(vcfFile, 'r')
#inVCF = open(vcfFile, 'r')
############# reset vcf to make sure no lines are missed #########
inVCF.seek(0)

########### GET SAMPLE NAMES #############
# get sample names
samples=[]
for line in inVCF:
	if line.startswith('##'):
		pass
	else:
		for i in line.split()[9:]: samples.append(i)
		break


IR_HomRef=0
IR_Het=0
IR_HomAlt=0
MN_HomRef=0
MN_Het=0
MN_HomAlt=0

###### READ THROUGH VCF AND EXTRACT INFO LINE BY LINE #######
# first read the header lines ("#") 
for line0 in inVCF:
    if line0.startswith('#'):
        continue
# skips sites that dont pass filters
    if "PASS" not in line0:
	continue

### For all other non-header lines, split along tabs to get each entry as a seprate entry in the list "line"
    line=line0.strip().split('\t') # this splits line by tabs
#CHROM0	POS1	ID2	REF3	ALT4	QUAL5	FILTER	INFO	FORMAT	[indivudals]
# get all the genotypes for all individuals, then split each individual's genotype info by ":" to get all the calls
    IR=line[9:14]
    MN=line[14:18]
    all_geno=line[9:18]
    IR_calls=[i.split(":")[0] for i in IR]
    MN_calls=[i.split(":")[0] for i in MN]
    all_calls=[i.split(":")[0] for i in all_geno]

# Get the counts of HomozygousREference, Heterozygous and Homozygous Alternate alleles (for now has all combos of genotypes; though if unphased most likely will only see 0/0 0/1 and 1/1)
    
    # want to ignore sites that are fixed ref across both pops
    # assuming that if 7/9 genotpes are 0/0 and 2 are ./. it is fixed derived
    homRefAll = all_calls.count("0/0") + all_calls.count("0|0") + all_calls.count("./.")
    if homRefAll < 9:
        IR_HomRef+=IR_calls.count("0/0") + IR_calls.count("0|0") # number of hom ref gts
        MN_HomRef+=MN_calls.count("0/0") + MN_calls.count("0|0") # number of hom ref gts


    IR_Het+=IR_calls.count("0/1") + IR_calls.count("1/0") + IR_calls.count("0|1")+ IR_calls.count("1|0") # number of het gts
    MN_Het+=MN_calls.count("0/1") + MN_calls.count("1/0") + MN_calls.count("0|1")+ MN_calls.count("1|0") # number of het gts


    # want to ignore sites that are fixed derived across both pops
    # assuming that if 7/9 genotpes are 1/1 and 2 are ./. it is fixed derived
    homAltAll = all_calls.count("1/1") + all_calls.count("1|1") + all_calls.count("./.")
    if homAltAll < 9: 
        IR_HomAlt+=IR_calls.count("1/1") + IR_calls.count("1|1") # num of hom alt gts
        MN_HomAlt+=MN_calls.count("1/1") + MN_calls.count("1|1") # num of hom alt gts



############################ write out SFS in dadi format ################
# write it out in a couple formats (dadi, fsc, R) #### dadi format : 
outputFile=open(str(outdir)+"/"+prefix+".variants_count.txt","w")
outputFile.write("IR_HomRef: "+str(IR_HomRef)+"\n")
outputFile.write("IR_Het: "+str(IR_Het)+"\n")
outputFile.write("IR_HomAlt: "+str(IR_HomAlt)+"\n")

outputFile.write("MN_HomRef: "+str(MN_HomRef)+"\n")
outputFile.write("MN_Het: "+str(MN_Het)+"\n")
outputFile.write("MN_HomAlt: "+str(MN_HomAlt)+"\n")

outputFile.close()


sys.exit()

