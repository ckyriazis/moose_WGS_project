# script to count number of genotypes called and number of heterozygotes per sample
# adapted by Jacqueline Robinson from a script by Zhenxin Fan
# input file is a multisample VCF file that has been filtered
# usage: python ./SlidingWindowHet.py input.vcf.gz 100000 10000 chr01

import sys
import pysam
import os
import gzip


# open input file (gzipped VCF file), make sure the VCF file is indexed (if not, create index)
filename = sys.argv[1]
VCF = gzip.open(filename, 'r')

if not os.path.exists("%s.tbi" % filename):
	pysam.tabix_index(filename, preset="vcf")
parsevcf = pysam.Tabixfile(filename)


# set variables
window_size = int(sys.argv[2])
step_size = int(sys.argv[3])
chromo = sys.argv[4]

#if len(chromo)==1: chromo='0'+chromo
#chromo='chr'+chromo

# chnaged from chr01 to chr1 from jacqueline
#chromo_size={'chr1':122678785,'chr2':85426708,'chr3':91889043,'chr4':88276631,'chr5':88915250,'chr6':77573801,'chr7':80974532,'chr8':74330416,'chr9':61074082,'chr10':69331447,'chr11':74389097,'chr12':72498081,'chr13':63241923,'chr14':60966679,'chr15':64190966,'chr16':59632846,'chr17':64289059,'chr18':55844845,'chr19':53741614,'chr20':58134056,'chr21':50858623,'chr22':61439934,'chr23':52294480,'chr24':47698779,'chr25':51628933,'chr26':38964690,'chr27':45876710,'chr28':41182112,'chr29':41845238,'chr30':40214260,'chr31':39895921,'chr32':38810281,'chr33':31377067,'chr34':42124431,'chr35':26524999,'chr36':30810995,'chr37':30902991,'chr38':23914537,'chrX':123869142}
chromo_size={'NC_037328.1':158534110,'NC_037329.1':136231102,'NC_037330.1':121005158,'NC_037331.1':120000601,'NC_037332.1':120089316,'NC_037333.1':117806340,'NC_037334.1':110682743,'NC_037335.1':113319770,'NC_037336.1':105454467,'NC_037337.1':103308737,'NC_037338.1':106982474,'NC_037339.1':87216183,'NC_037340.1':83472345,'NC_037341.1':82403003,'NC_037342.1':85007780,'NC_037343.1':81013979,'NC_037344.1':73167244,'NC_037345.1':65820629,'NC_037346.1':63449741,'NC_037347.1':71974595,'NC_037348.1':69862954,'NC_037349.1':60773035,'NC_037350.1':52498615,'NC_037351.1':62317253,'NC_037352.1':42350435,'NC_037353.1':51992305,'NC_037354.1':45612108,'NC_037355.1':45940150,'NC_037356.1':51098607,'NC_037357.1':139009144}


# get list of samples
samples=[]
for line in VCF:
	if line.startswith('##'):
		pass
	else:
		for i in line.split()[9:]: samples.append(i)
		break


# get first and last positions in chromosome
for line in VCF:
	if line[0] != '#':
		start_pos = int(line.strip().split()[1])
		end_pos = chromo_size[chromo]
		break


# create output file
output = open('SWhet_' + filename + '_het_%swin_%sstep.txt' % (window_size, step_size), 'w')
output.write('chromo\twindow_start\tsites_total\tsites_unmasked\tsites_passing\tsites_variant\tcalls_%s\thets_%s\n' % ('\tcalls_'.join(samples), '\thets_'.join(samples)) )


# Fetch a region, ignore sites that fail filters, tally total calls and heterozygotes		
def snp_cal(chromo,window_start,window_end):

	rows = tuple(parsevcf.fetch(region="%s:%s-%s" % (chromo, window_start, window_end), parser=pysam.asTuple()))
	
	sites_total,sites_unmasked,sites_passing,sites_variant=0,0,0,0
	calls=[0]*len(samples)
	hets=[0]*len(samples)

	for line in rows:
		sites_total+=1
		if "CpGRep" in line[6]: continue
		sites_unmasked+=1
		if "FAIL" in line[6]: continue
		if "WARN" in line[6]: continue
		sites_passing+=1
		if line[4]!='.': sites_variant+=1
		for i in range(0,len(samples)):
			GT=line[i+9]
			if GT[:1]!='.': calls[i]+=1
			if GT[:3]=='0/1': hets[i]+=1
			if GT[:3]=='0|1': hets[i]+=1

	output.write('%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' % (chromo,window_start,sites_total,sites_unmasked,sites_passing,sites_variant,'\t'.join(map(str,calls)),'\t'.join(map(str,hets))) )

	
# initialize window start and end coordinates
window_start = start_pos
window_end = start_pos+window_size-1


# calculate stats for window, update window start and end positions, repeat to end of chromosome
while window_end <= end_pos:	
			
	if window_end < end_pos:
		snp_cal(chromo,window_start,window_end)

		window_start = window_start + step_size
		window_end = window_start + window_size - 1

	else:
		snp_cal(chromo,window_start,window_end)
		break	
		
else:
	window_end = end_pos
	snp_cal(chromo,window_start,window_end)


# close files and exit
VCF.close()
output.close()

exit()
