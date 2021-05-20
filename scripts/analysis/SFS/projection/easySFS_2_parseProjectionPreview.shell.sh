####### Parse EasySFS output
wd=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SFS/projection/projection_preview
easyOut=neutral.NC_037328.1.easySFS.projPreview.txt
pops="MN IR"

for pop in $pops
do
# put a "$" at the end of pop to signify that it should be at the end of the line
# get the line from the easy SFS output; get rid of of the parentheses and make a column
echo "projection,snps" > $wd/$pop.${easyOut%.txt}.R.format.txt
grep -A1 "$pop$" $wd/$easyOut | tail -1 | sed 's/(//g' | sed 's/)//g' | sed 's/, /,/g' |  tr '\t' '\n' >> $wd/$pop.${easyOut%.txt}.R.format.txt
done
