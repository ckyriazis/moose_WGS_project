# need to cat the files then get the average

cd '/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/12_GetCoverage/'

animals=(IR3925 IR3927 IR3928 IR3929 IR3931 MN31 MN41 MN54 MN96) 


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
