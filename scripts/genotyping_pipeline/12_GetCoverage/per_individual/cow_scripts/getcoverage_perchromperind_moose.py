import vcf
import sys
## this script writes to file the filered depth (from the genotype fields) for each individuual. i.e. there is one file for each individual/chromosome. I will then cat these per indiv to get sum.
## 
chromo=sys.argv[1]
filename='21Moose_joint_'+ str(chromo) + '.vcf.gz'
indir='/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/08_GenotypeGVCFs/'
myvcffile=indir+filename
outd='/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/12_GetCoverage/'



ofIR3925=open(outd + 'IR3925_' + chromo + '.txt', 'a')
ofIR3928=open(outd + 'IR3928_' + chromo + '.txt', 'a')
ofIR3929=open(outd + 'IR3929_' + chromo + '.txt', 'a')
ofIR3931=open(outd + 'IR3931_' + chromo + '.txt', 'a')
ofMN31=open(outd + 'MN31_' + chromo + '.txt', 'a')
ofMN41=open(outd + 'MN41_' + chromo + '.txt', 'a')
ofMN54=open(outd + 'MN54_' + chromo + '.txt', 'a')
ofMN96=open(outd + 'MN96_' + chromo + '.txt', 'a')

ofIR3927=open(outd + 'IR3927_' + chromo + '.txt', 'a')
ofIR3930=open(outd + 'IR3930_' + chromo + '.txt', 'a')
ofIR3934=open(outd + 'IR3934_' + chromo + '.txt', 'a')
ofMN15=open(outd + 'MN15_' + chromo + '.txt', 'a')
ofMN178=open(outd + 'MN178_' + chromo + '.txt', 'a')
ofMN72=open(outd + 'MN72_' + chromo + '.txt', 'a')
ofMN76=open(outd + 'MN76_' + chromo + '.txt', 'a')
ofMN92=open(outd + 'MN92_' + chromo + '.txt', 'a') 

ofHM2013=open(outd + 'HM2013_' + chromo + '.txt', 'a')
ofJC2001=open(outd + 'JC2001_' + chromo + '.txt', 'a')
ofR199=open(outd + 'R199_' + chromo + '.txt', 'a')
ofC06=open(outd + 'C06_' + chromo + '.txt', 'a')
ofSMoose=open(outd + 'SMoose_' + chromo + '.txt', 'a')





vcf_reader = vcf.Reader(open(myvcffile, 'r'))

	
for record in vcf_reader:
		# skip the sites that dont have DP - IMHO they all should but GATK is a buggy crap fest
		if 'DP' not in record.FORMAT:
			pass
		else:
			IR3925_DP=record.genotype('IR3925')['DP']
			if IR3925_DP > 0:
				ofIR3925.write(str(IR3925_DP) + '\n')

			IR3928_DP=record.genotype('IR3928')['DP']
			if IR3928_DP > 0:
				ofIR3928.write(str(IR3928_DP) + '\n')

			IR3929_DP=record.genotype('IR3929')['DP']
			if IR3929_DP > 0:
				ofIR3929.write(str(IR3929_DP) + '\n')

                        IR3931_DP=record.genotype('IR3931')['DP']
                        if IR3931_DP > 0:
                                ofIR3931.write(str(IR3931_DP) + '\n')

                        MN31_DP=record.genotype('MN31')['DP']
                        if MN31_DP > 0:
                                ofMN31.write(str(MN31_DP) + '\n')

                        MN41_DP=record.genotype('MN41')['DP']
                        if MN41_DP > 0:
                                ofMN41.write(str(MN41_DP) + '\n')

                        MN54_DP=record.genotype('MN54')['DP']
                        if MN54_DP > 0:
                                ofMN54.write(str(MN54_DP) + '\n')

                        MN96_DP=record.genotype('MN96')['DP']
                        if MN96_DP > 0:
                                ofMN96.write(str(MN96_DP) + '\n')

                        IR3927_DP=record.genotype('IR3927')['DP']
                        if IR3927_DP > 0:
                                ofIR3927.write(str(IR3927_DP) + '\n')

                        IR3930_DP=record.genotype('IR3930')['DP']
                        if IR3930_DP > 0:
                                ofIR3930.write(str(IR3930_DP) + '\n')

                        IR3934_DP=record.genotype('IR3934')['DP']
                        if IR3934_DP > 0:
                                ofIR3934.write(str(IR3934_DP) + '\n')

                        MN15_DP=record.genotype('MN15')['DP']
                        if MN15_DP > 0:
                                ofMN15.write(str(MN15_DP) + '\n')

                        MN178_DP=record.genotype('MN178')['DP']
                        if MN178_DP > 0:
                                ofMN178.write(str(MN178_DP) + '\n')

                        MN72_DP=record.genotype('MN72')['DP']
                        if MN72_DP > 0:
                                ofMN72.write(str(MN72_DP) + '\n')

                        MN76_DP=record.genotype('MN76')['DP']
                        if MN76_DP > 0:
                                ofMN76.write(str(MN76_DP) + '\n')

                        MN92_DP=record.genotype('MN92')['DP']
                        if MN92_DP > 0:
                                ofMN92.write(str(MN92_DP) + '\n')



                        HM2013_DP=record.genotype('HM2013')['DP']
                        if HM2013_DP > 0:
                                ofHM2013.write(str(HM2013_DP) + '\n')

                        JC2001_DP=record.genotype('JC2001')['DP']
                        if JC2001_DP > 0:
                                ofJC2001.write(str(JC2001_DP) + '\n')

                        R199_DP=record.genotype('R199')['DP']
                        if R199_DP > 0:
                                ofR199.write(str(R199_DP) + '\n')

                        C06_DP=record.genotype('C06')['DP']
                        if C06_DP > 0:
                                ofC06.write(str(C06_DP) + '\n')

                        SMoose_DP=record.genotype('SMoose')['DP']
                        if SMoose_DP > 0:
                                ofSMoose.write(str(SMoose_DP) + '\n')
		

ofIR3925.close()
ofIR3927.close()
ofIR3928.close()
ofIR3929.close()
ofIR3931.close()
ofMN31.close()
ofMN41.close()
ofMN54.close()
ofMN96.close()

ofIR3930.close()
ofIR3934.close()
ofMN15.close()
ofMN178.close()
ofMN72.close()
ofMN76.close()
ofMN92.close()


ofHM2013.close()
ofJC2001.close()
ofR199.close()
ofC06.close()
ofSMoose.close()





