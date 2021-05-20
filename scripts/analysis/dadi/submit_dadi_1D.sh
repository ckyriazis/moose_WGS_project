#! /bin/bash
#$ -cwd
#$ -l h_rt=24:00:00,h_data=8G
#$ -pe shared 2 
#$ -N dadi_inference
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/dadi/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/dadi/jobfiles
#$ -m abe
#$ -M ckyriazi


source /u/home/c/ckyriazi/miniconda2/etc/profile.d/conda.sh
conda activate demog


scriptdir=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/dadi/1D_models
mu=7e-09
sfsdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SFS/projection/projection-hetFilter-0.75
dadidir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/dadi
sfssuffix=plusMonomorphic.autosomes.sfs

scripts='1D.5Epoch.FixedTheta.IR.dadi.py'


for pop in IR
do
# get total sites from total sites file that was written out as part of my easySFS scripts
L=`grep $pop $sfsdir/$pop-[0-9]*.totalSiteCount.L.withMonomorphic.txt | awk '{print $2}'`

for script in $scripts
do
model=${script%.dadi.py}
echo "starting inference for $pop for model $model"
outdir=$dadidir/$pop/$model
mkdir -p $outdir
# carry out inference with 50 replicates that start with different p0 perturbed params:
for i in {1..50}
do
echo "carrying out inference $i for model $model for pop $pop" 
# [0-9] indicates that it's a number, but not specific about proj value
python $scriptdir/$script --runNum $i --pop $pop --mu $mu --L $L --sfs $sfsdir/$pop-[0-9]*.$sfssuffix --outdir $outdir
done


echo "concatenating results"
grep rundate -m1 $outdir/${pop}.dadi.inference.${model}.runNum.1.output > $outdir/${pop}.dadi.inference.${model}.all.output.concatted.txt
for i in {1..50}
do
grep rundate -A1 $outdir/${pop}.dadi.inference.${model}.runNum.${i}.output | tail -n1 >> $outdir/${pop}.dadi.inference.${model}.all.output.concatted.txt
done

done
done
