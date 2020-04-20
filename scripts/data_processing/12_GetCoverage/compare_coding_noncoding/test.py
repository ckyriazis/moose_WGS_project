import vcf
import sys
## script for getting coverage by chrom and individual, partitioned into coding and noncoding


chromo='NC_037355.1'
filename='9Moose_joint_Filter_B_'+ str(chromo) + '.vcf.gz'
indir='/u/home/c/ckyriazi/kirk-bigdata/moose/output/11_FilterVCFfile/filtering_round4/'
myvcffile=indir+filename




#ofIR3925=open(outd + 'IR3925_' + chromo + '.txt', 'a')



vcf_reader = vcf.Reader(open(myvcffile, 'r'))


for record in vcf_reader:
	print record.POS
	if 'FAIL' not in str(record.FILTER) and 'WARN' not in str(record.FILTER):
		print record.FILTER
                # skip the sites that dont have DP - IMHO they all should but GATK is a buggy crap fest
                #if 'DP' not in record.FORMAT and 'PASS' not in record.FILTER:
                #        pass

		#else:
                        #IR3925_DP=record.genotype('IR3925')['DP']
                        #if IR3925_DP > 0:
                         #       if "protein" in str(record.INFO):
			#		 print record.INFO
				

				#print record.INFO
                               # if "CSQ" in record.INFO:
					#print record.INFO["CSQ"]
				#	if "protein_coding" in str(record.INFO["CSQ"]):

						#print record.INFO			
	                                     # ofIR3925.write(str(IR3925_DP) + "\t" + "protein" + '\n')
                                #else:
                                        #ofIR3925.write(str(IR3925_DP) + "\t" + "noncoding" + '\n')

