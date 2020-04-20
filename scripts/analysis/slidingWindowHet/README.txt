This directory contains two sets of scripts for getting sliding window heterozygosity

The cow_scripts directory contains scripts originally from clare where chromosome length is specified in the script.

The hogdeer_scripts directory contains scripts from Jacqueline that are modified to input a text file "chrom_lengths.txt" that contains two columns: chromosome (or scaffold) name in the first column and length in the second column.

one liner for creating chrom_lengths.txt from vcf file:
zcat my.vcf.gz | grep "contig=<ID" | cut -d'=' -f3,4 | sed 's/,length=/\t/g' | sed 's/>//g' > chrom_lengths.txt



