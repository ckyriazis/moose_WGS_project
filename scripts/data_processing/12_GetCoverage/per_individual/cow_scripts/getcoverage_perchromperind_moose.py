import vcf
import sys
## this script writes to file the filered depth (from the genotype fields) for each individuual. i.e. there is one file for each individual/chromosome. I will then cat these per indiv to get sum.
## Chris: this is further modified from Clare's version to work for the caracals
## 
chromo=sys.argv[1]
filename='9Moose_joint_'+ str(chromo) + '.vcf.gz'
indir='/u/flashscratch/c/ckyriazi/moose/output/08_GenotypeGVCFs/'
myvcffile=indir+filename
outd='/u/home/c/ckyriazi/kirk-bigdata/moose/output/get_coverage/'


mysamples = ['IR3925','IR3927','IR3928','IR3929','IR3931','MN31','MN41','MN54','MN96']


ofIR3925=open(outd + 'IR3925' + chromo + '.txt', 'a')
ofIR3927=open(outd + 'IR3927' + chromo + '.txt', 'a')
ofIR3928=open(outd + 'IR3928' + chromo + '.txt', 'a')
ofIR3929=open(outd + 'IR3929' + chromo + '.txt', 'a')
ofIR3931=open(outd + 'IR3931' + chromo + '.txt', 'a')
ofMN31=open(outd + 'MN31' + chromo + '.txt', 'a')
ofMN41=open(outd + 'MN41' + chromo + '.txt', 'a')
ofMN54=open(outd + 'MN54' + chromo + '.txt', 'a')
ofMN96=open(outd + 'MN96' + chromo + '.txt', 'a')



vcf_reader = vcf.Reader(open(myvcffile, 'r'))

	
for record in vcf_reader:
		# skip the sites that dont have DP - IMHO they all should but GATK is a buggy crap fest
		if 'DP' not in record.FORMAT:
			pass
		else:
			IR3925_DP=record.genotype('IR3925')['DP']
			if IR3925_DP > 0:
				ofIR3925.write(str(IR3925_DP) + '\n')

			IR3927_DP=record.genotype('IR3927')['DP']
			if IR3927_DP > 0:
				ofIR3927.write(str(IR3927_DP) + '\n')
		
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
		

ofIR2925.close()
ofIR2927.close()
ofIR2928.close()
ofIR2929.close()
ofIR2931.close()
ofMN31.close()
ofMN41.close()
ofMN54.close()
ofMN96.close()

