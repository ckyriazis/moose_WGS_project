# script for counting number of derived synonymous alleles per individual


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

#ind_allele_counts={"IR3925":0, "IR3927":0,"IR3928":0,"IR3929":0,"IR3931":0,"MN31":0,"MN41":0,"MN54":0,"MN96":0}

ind_allele_counts=[0]*len(samples)
ind_called_geno_counts=[0]*len(samples)
ind_missing_counts=[0]*len(samples)

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
    all_geno=line[9:(len(samples)+9)]
    all_calls=[i.split(":")[0] for i in all_geno]

    # skip sites that are fixed across entire sample
    homAltAll = all_calls.count("1/1") + all_calls.count("1|1") + all_calls.count("./.")
    if homAltAll == len(samples):
        continue
    # skip sites that are fixed ref
    homRefAll = all_calls.count("0/0") + all_calls.count("0|0") + all_calls.count("./.")
    if homRefAll == len(samples):
        continue

    for ind in enumerate(ind_allele_counts):
        ind_call=all_calls[ind[0]]
        if (ind_call == "1/1") or (ind_call=="1|1"):
            ind_allele_counts[ind[0]]+=2
        if (ind_call == "1/0") or (ind_call=="1|0") or (ind_call == "0/1") or (ind_call=="0|1"):
            ind_allele_counts[ind[0]]+=1
        if (ind_call != "./."):
            ind_called_geno_counts[ind[0]]+=1
        if (ind_call == "./."):
            ind_missing_counts[ind[0]]+=1

        else:
          continue
        





# write outfile
outputFile=open(str(outdir)+"/"+prefix+".alleles_count.txt","w")
outputFile.write("total_called_sites: "+str(ind_called_geno_counts)+"\n")
outputFile.write("total_missing_sites: "+str(ind_missing_counts)+"\n")
outputFile.write("alleles: "+str(ind_allele_counts)+"\n")
outputFile.close()



sys.exit()









