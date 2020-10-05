# this script is for examining distribution of how many individuals are heterozygous at sites that contain hets


import sys
#import pysam
import os
import gzip


# open input file (gzipped VCF file), make sure the VCF file is indexed (if not, create index)
filename = sys.argv[1]
VCF = gzip.open(filename, 'r')



# get list of samples
samples=[]
for line in VCF:
	if line.startswith('##'):
		pass
	else:
		for i in line.split()[9:]: samples.append(i)
		break



	
sites_total,het_sites=0,0
het_counts=[]


for line0 in VCF:
	if line0.startswith('##'): continue
	
	line=line0.strip().split('\t') # this splits line by tabs

	#print line[6]

	#sites_total+=1
	#if "FAIL_Rep" in line[6]: continue
 	#if "FAIL_qual" in line[6]: continue
	#if "FAIL_DP" in line[6]: continue
	#if "FAIL_6f" in line[6]: continue
	#if "FAIL_noQUAL" in line[6]: continue
	#sites_unmasked+=1		
	if "FAIL" in line[6]: continue
	if "WARN" in line[6]: continue
	#sites_passing+=1
	#if line[4]!='.': sites_variant+=1
	sites_total+=1
	all_geno=line[9:len(samples)]
	all_calls=[i.split(":")[0] for i in all_geno]
	het_count = all_calls.count("0/1")+all_calls.count("1/0")+all_calls.count("0|1")+all_calls.count("1|0")	
	if het_count > 0:
		het_sites+=1
		het_counts.append(het_count)
		



with open("het_dist_"+filename+'.txt', 'w') as f:
    for het in het_counts:
        print >> f, het

f.close()

	

# close files and exit
VCF.close()

exit()
