# this script is for counting the number of each different filter in a vcf

import sys
import os
import gzip


# open input file (gzipped VCF file), make sure the VCF file is indexed (if not, create index)
filename = sys.argv[1]
VCF = gzip.open(filename, 'r')


# GATK filters
FAIL_Rep = 0
FAIL_QD = 0
FAIL_FS = 0
FAIL_MQ = 0
FAIL_MQRankSum = 0
FAIL_ReadPosRankSum = 0
FAIL_SOR = 0

# custom filters
FAIL_REF = 0
FAIL_ALT = 0
FAIL_noADi = 0
FAIL_noDPi = 0
FAIL_noGT = 0
WARN_missing = 0
FAIL_excessHet = 0
sites_total = 0




for line0 in VCF:
	if line0.startswith('##'): continue
	
	line=line0.strip().split('\t') # this splits line by tabs

	#print line[6]

		
 	if "FAIL_Rep" in line[6]:
		FAIL_Rep+=1

	if "FAIL_QD" in line[6]: 
		FAIL_QD+=1

        if "FAIL_FS" in line[6]:
                FAIL_FS+=1

        if "FAIL_MQ" in line[6]:
                FAIL_MQ+=1

        if "FAIL_MQRankSum" in line[6]:
                FAIL_MQRankSum+=1

        if "FAIL_ReadPosRankSum" in line[6]:
                FAIL_ReadPosRankSum+=1

        if "FAIL_SOR" in line[6]:
                FAIL_SOR+=1

        if "FAIL_REF" in line[6]:
                FAIL_REF+=1

        if "FAIL_ALT" in line[6]:
                FAIL_ALT+=1

        if "FAIL_noADi" in line[6]:
                FAIL_noADi+=1

        if "FAIL_noDPi" in line[6]:
                FAIL_noDPi+=1

        if "FAIL_noGT" in line[6]:
                FAIL_noGT+=1

        if "WARN_missing" in line[6]:
                WARN_missing+=1

        if "FAIL_excessHet" in line[6]:
                FAIL_excessHet+=1


	sites_total+=1





with open("filter_counts_"+filename+'.txt', 'w') as f:

	print >> f, "sites_total: " + str(sites_total)
	print >> f, "FAIL_Rep: " + str(FAIL_Rep)
	print >> f, "FAIL_QD: " + str(FAIL_QD)
	print >> f, "FAIL_FS: " + str(FAIL_FS)
	print >> f, "FAIL_MQ: " + str(FAIL_MQ)
	print >> f, "FAIL_MQRankSum: " + str(FAIL_MQRankSum)
	print >> f, "FAIL_ReadPosRankSum: " + str(FAIL_ReadPosRankSum)
	print >> f, "FAIL_SOR: " + str(FAIL_SOR)
	print >> f, "FAIL_REF: " + str(FAIL_REF)
	print >> f, "FAIL_ALT: " + str(FAIL_ALT)
	print >> f, "FAIL_noADi: " + str(FAIL_noADi)
	print >> f, "FAIL_noDPi: " + str(FAIL_noDPi)
	print >> f, "FAIL_noGT: " + str(FAIL_noGT)
        print >> f, "WARN_missing: " + str(WARN_missing)
        print >> f, "FAIL_excessHet: " + str(FAIL_excessHet)


f.close()

	

# close files and exit
VCF.close()

exit()
