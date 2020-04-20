import vcf
import sys
## script for getting coverage by chrom and individual, partitioned into coding and noncoding


chromo=sys.argv[1]
filename='9Moose_joint_Filter_B_'+ str(chromo) + '.vcf.gz'
indir='/u/home/c/ckyriazi/kirk-bigdata/moose/output/11_FilterVCFfile/filtering_round4/'
myvcffile=indir+filename
outd='/u/home/c/ckyriazi/kirk-bigdata/moose/output/12_GetCoverage/'


mysamples = ['IR3925','IR3927','IR3928','IR3929','IR3931','MN31','MN41','MN54','MN96']


ofIR3925=open(outd + 'IR3925_' + chromo + '.txt', 'a')
ofIR3927=open(outd + 'IR3927_' + chromo + '.txt', 'a')
ofIR3928=open(outd + 'IR3928_' + chromo + '.txt', 'a')
ofIR3929=open(outd + 'IR3929_' + chromo + '.txt', 'a')
ofIR3931=open(outd + 'IR3931_' + chromo + '.txt', 'a')
ofMN31=open(outd + 'MN31_' + chromo + '.txt', 'a')
ofMN41=open(outd + 'MN41_' + chromo + '.txt', 'a')
ofMN54=open(outd + 'MN54_' + chromo + '.txt', 'a')
ofMN96=open(outd + 'MN96_' + chromo + '.txt', 'a')



vcf_reader = vcf.Reader(open(myvcffile, 'r'))

	
for record in vcf_reader:
		if 'FAIL' not in str(record.FILTER) and 'WARN' not in str(record.FILTER) and 'DP' in record.FORMAT:
			IR3925_DP=record.genotype('IR3925')['DP']
			if IR3925_DP > 0:
				if "protein" in str(record.INFO):
					ofIR3925.write(str(IR3925_DP) + "\t" + "protein" + '\n')
				else:
					ofIR3925.write(str(IR3925_DP) + "\t" + "noncoding" + '\n')

			IR3927_DP=record.genotype('IR3927')['DP']
			if IR3927_DP > 0:
                                if "protein" in str(record.INFO):
                                        ofIR3927.write(str(IR3927_DP) + "\t" + "protein" + '\n')
                                else:
                                        ofIR3927.write(str(IR3927_DP) + "\t" + "noncoding" + '\n')
	
			IR3928_DP=record.genotype('IR3928')['DP']
			if IR3928_DP > 0:
                                if "protein" in str(record.INFO):
                                        ofIR3928.write(str(IR3928_DP) + "\t" + "protein" + '\n')
                                else:
                                        ofIR3928.write(str(IR3928_DP) + "\t" + "noncoding" + '\n')

			IR3929_DP=record.genotype('IR3929')['DP']
			if IR3929_DP > 0:
                                if "protein" in str(record.INFO):
                                        ofIR3929.write(str(IR3929_DP) + "\t" + "protein" + '\n')
                                else:
                                        ofIR3929.write(str(IR3929_DP) + "\t" + "noncoding" + '\n')

                        IR3931_DP=record.genotype('IR3931')['DP']
                        if IR3931_DP > 0:
                                if "protein" in str(record.INFO):
                                        ofIR3931.write(str(IR3931_DP) + "\t" + "protein" + '\n')
                                else:
                                        ofIR3931.write(str(IR3931_DP) + "\t" + "noncoding" + '\n')

                        MN31_DP=record.genotype('MN31')['DP']
                        if MN31_DP > 0:
                                if "protein" in str(record.INFO):
                                        ofMN31.write(str(MN31_DP) + "\t" + "protein" + '\n')
                                else:
                                        ofMN31.write(str(MN31_DP) + "\t" + "noncoding" + '\n')

                        MN41_DP=record.genotype('MN41')['DP']
                        if MN41_DP > 0:
                                if "protein" in str(record.INFO):
                                        ofMN41.write(str(MN41_DP) + "\t" + "protein" + '\n')
                                else:
                                        ofMN41.write(str(MN41_DP) + "\t" + "noncoding" + '\n')

                        MN54_DP=record.genotype('MN54')['DP']
                        if MN54_DP > 0:
                                if "protein" in str(record.INFO):
                                        ofMN54.write(str(MN54_DP) + "\t" + "protein" + '\n')
                                else:
                                        ofMN54.write(str(MN54_DP) + "\t" + "noncoding" + '\n')

                        MN96_DP=record.genotype('MN96')['DP']
                        if MN96_DP > 0:
                                if "protein" in str(record.INFO):
                                        ofMN96.write(str(MN96_DP) + "\t" + "protein" + '\n')
                                else:
                                        ofMN96.write(str(MN96_DP) + "\t" + "noncoding" + '\n')
		
		else:
			pass
	

ofIR3925.close()
ofIR3927.close()
ofIR3928.close()
ofIR3929.close()
ofIR3931.close()
ofMN31.close()
ofMN41.close()
ofMN54.close()
ofMN96.close()

