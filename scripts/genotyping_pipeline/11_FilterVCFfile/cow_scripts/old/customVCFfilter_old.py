'''
Custom script for site- and genotype-level filtering of a VCF file
Input = VCF file (unphased)
Output = filtered VCF file (prints to screen)
- Filtered sites are marked as FAIL_[?] in the 7th (FILTER) column
- Sites that pass go on to genotype filtering
- Genotypes that fail filters are changed to './.'
Example usage:
python /utils/scripts/customVCFfilter.py myJointVCFfile.vcf.gz | \
bgzip > myJointVCFfile_filtered.vcf.gz
tabix -p vcf myJointVCFfile_filtered.vcf.gz
NOTE: Will recalculate AC, AF, AN in INFO field.
'''

import sys
import gzip
import re

vcf_file = sys.argv[1]
inVCF = gzip.open(vcf_file, 'r')

# Set minimum genotype depth
minD=6

# Set maximum genotype depth for each sample (99th percentile in each individual)

maxD={'IR3925':54,'IR3927':55,'IR3928':45,'IR3929':50,'IR3931':57,'MN31':86,
      'MN41':64,'MN54':50,'MN96':47,'IR3920':48,'IR3921':36,'IR3930':41,'IR3934':40,'MN15':45,'MN178':38,
      'MN72':35,'MN76':37,'MN92':44}

# Get list of samples
samples=[]
for line in inVCF:
	if line.startswith('##'):
		pass
	else:
		for i in line.split()[9:]: samples.append(i)
		break

inVCF.seek(0)

# Filter to be applied to individual genotypes
# GQpos is the position of the GQ in FORMAT (varies)
def GTfilter(sample,GT_entry,GQpos):
	field=GT_entry.split(':')
	if field[0]=='./.': return GT_entry
	else:
		if field[0] in ('0/0','0/1','1/1') and field[GQpos]!='.' and float(field[GQpos])>=20.0 and field[2]!='.' and minD<=int(field[2])<=maxD[sample]: return GT_entry
		else: return './.:' + ':'.join(field[1:])

# Add new header lines for filters being added - for GATK compatibility
for line0 in inVCF:
	if line0.startswith('#'):
		if line0.startswith('##FORMAT'):
			sys.stdout.write('##FILTER=<ID=FAIL_refN,Description="Low quality">\n##FILTER=<ID=FAIL_badAlt,Description="Low quality">\n##FILTER=<ID=FAIL_noQUAL,Description="Low quality">\n##FILTER=<ID=FAIL_noGQi,Description="Low quality">\n##FILTER=<ID=FAIL_noDPi,Description="Low quality">\n##FILTER=<ID=FAIL_excessHet,Description="Low quality">\n##FILTER=<ID=FAIL_noGT,Description="Low quality">\n##FILTER=<ID=WARN_mutType,Description="Low quality">\n##FILTER=<ID=WARN_missing,Description="Low quality">\n') 
			sys.stdout.write(line0)
			break
		else: sys.stdout.write(line0)
	
for line0 in inVCF:
	if line0.startswith('#'): 
		sys.stdout.write(line0); continue

### For all other lines:
	line=line0.strip().split('\t')

### Site filtering:
# Keep any filters that have already been applied (like CpGRep)
	filter=[]
	if line[6] not in ('.', 'PASS'): filter.append(line[6])

### Reference must not be N
	if line[3]=='N': 
		filter.append('FAIL_refN')
		sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ); continue

### Alternate allele must not be multiallelic or <NON_REF>
	if ',' in line[4]: 
		filter.append('FAIL_badAlt')
		sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ); continue

	if '<NON_REF>' in line[4]: 
		filter.append('FAIL_badAlt')
		sys.stdout.write('%s\t%s\t%s\t%s\t%s\n' % ('\t'.join(line[0:4]), '.', line[5] , ';'.join(filter), '\t'.join(line[7:])) ); continue

### Must have a valid QUAL
	if line[5]=='.': 
		filter.append('FAIL_noQUAL')
		sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ); continue

### Access INFO field annotations
	INFO=line[7].split(';')
	f=dict(s.split('=') for s in INFO)

### Add warning if site is not monomorphic or simple SNP
	if f['VariantType'] not in ('NO_VARIATION', 'SNP'): 
		filter.append('WARN_mutType')

### Get the position of GQ value in genotype fields
	if 'DP' in line[8]: 
		formatfields=line[8].split(':')
		DPpos=[formatfields.index(x) for x in formatfields if 'DP' in x][0]
	else: 
		filter.append('FAIL_noDPi')
		sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ); continue

	if 'GQ' in line[8]: 
		formatfields=line[8].split(':')
		GQpos=[formatfields.index(x) for x in formatfields if 'GQ' in x][0]
	else: 
		filter.append('FAIL_noGQi')
		sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ); continue

### Get AB value for use in later het. filtering
	if 'ABHet' in f: AB=float(f['ABHet'])
	else: AB=0

### Genotype filtering:
	missing,excesshet=0,0

	GT_list=[]
	for i in range(0,len(samples)):
		GT=GTfilter(samples[i],line[i+9],GQpos)
		if GT[:3]=='./.': 
			missing+=1
			GT_list.append(GT)
		else:
			if GT[:3]=='0/1':
				if 0.2<=AB<=0.8: 
				GT_list.append(GT)
				excesshet+=1
				else: 
					GT_list.append('./.' + GT[3:])
					missing+=1
			else: GT_list.append(GT)

# Filter if more than 8/18 samples are het
	if excesshet>8: 
		filter.append('FAIL_excessHet')
		sys.stdout.write('%s\t%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:9]), '\t'.join(GT_list)) ); continue


### Apply warning for sites with more than 4 samples missing
	if missing>4: 
		filter.append('WARN_missing')

### Recalculate INFO fields
	REF=2*[x[:3] for x in GT_list].count('0/0') + [x[:3] for x in GT_list].count('0/1')
	ALT=2*[x[:3] for x in GT_list].count('1/1') + [x[:3] for x in GT_list].count('0/1')

	if REF+ALT==0:
		filter.append('FAIL_noGT')
		sys.stdout.write('%s\t%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:9]), '\t'.join(GT_list)) ); continue
	
	f['AC']=ALT
	f['AN']=REF+ALT
	f['AF']=round(float(ALT)/(float(REF)+float(ALT)), 4)

	if filter==[]: filter.append('PASS')

### Write out new line
	sys.stdout.write('%s\t%s\t%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), ';'.join('{0}={1}'.format(key, val) for key, val in sorted(f.items())), line[8], '\t'.join(GT_list)) )
		

inVCF.close()

exit()
