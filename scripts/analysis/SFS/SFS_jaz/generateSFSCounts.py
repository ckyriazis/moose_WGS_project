###This script will accept a VCF input file and generate counts for creating an SFS

import sys
import os

numArgs = len(sys.argv)

if (numArgs < 3):
	print "Error, missing arguments. Usage: python generateSFSCounts.py inputVCF outputFile"
	exit(1)

#Designate Variables
tab = '\t'
endOfLine = '\n'
inputVCFFilename = sys.argv[1]
outputFilename = sys.argv[2]

#Set Counters
COUNT_SITES_IN_VCF=0
COUNT_LINES_PRINTED=0

#Lists and Dictionaries
segValues = ['0/1','1/0']

if (os.path.isfile(inputVCFFilename)):
	with open(inputVCFFilename, 'r') as inputFile:
		with open(outputFilename, 'w') as outFile:
			outFile.write('CHROM\tPOS\tCount\n')
			for line in inputFile:
				line = line.strip()
				if not line.startswith('#'):
					if "PASS" in line:
						COUNT_SITES_IN_VCF+=1
						COUNT_GENO=0
						line = line.split(tab)
						#Check length of genotypes
						for dataCol in line[9:]:
							dataCol=dataCol.split(":")
							dataCol=dataCol[0]
							if len(dataCol) > 4:
								print '** ERROR genotype col is > 4'
								sys.exit('*** ERROR exiting ***') 
							if len(dataCol) == 4:
								#print 'len', len(dataCol)
								#print '['+dataCol+']'
								dataCol=dataCol.strip()
								#Check fix worked
								if len(dataCol) !=3:
									sys.exit('** EXITING Genotype Formatting Error **')
						#Check genotypes and find total individuals with segregating sites 
							if (dataCol in segValues):
								COUNT_GENO+=1
							elif dataCol == '1/1':
								COUNT_GENO+=2
							elif dataCol == '0/0':
								pass
							elif dataCol == './.':
								pass
							else:
								print '['+dataCol+']', line[1]
								sys.exit('BAD GENOTYPE')
					
						#print line[0], line[1], COUNT_GENO
						outFile.write(str(line[0]) + tab + str(line[1]) + tab + str(COUNT_GENO) + endOfLine)

					else:
						pass
