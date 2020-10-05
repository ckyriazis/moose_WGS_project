# need to cat the files then get the average

cd '/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/12_GetCoverage'

#animals=(IR3920 IR3921 IR3930 IR3934 MN15 MN178 MN72 MN76 MN92 IR3925 IR3927 IR3928 IR3929 IR3931 MN31 MN41 MN54 MN96) 
animals=(MN92)

for i in "${animals[@]}"
do
	echo ${i}
	cat ${i}* > 'all_'${i}'_chrom.txt'
done
echo 'second loop'
for i in "${animals[@]}"
do
	echo ${i}
	awk '{sum+=$1} END {print sum/NR}' 'all_'${i}'_chrom.txt'
done
