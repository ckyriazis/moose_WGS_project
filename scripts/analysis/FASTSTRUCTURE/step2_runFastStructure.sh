### This can be run in the shell on an interactive node:
# 

################# installing fastStructure: #############

#git clone https://github.com/rajanil/fastStructure
#cd fastStructure/vars
#python setup.py build_ext --inplace
#cd ..
#python setup.py build_ext --inplace
#test:
#python structure.py # works!
# !!!! you need to add the following two lines to the distruct.py script so that it works without X11 forwarding (https://github.com/rajanil/fastStructure/issues/36)
#import matplotlib as mpl
#mpl.use('svg')
# !!!! these must be added PRIOR to setting: import matplotlib.pyplot as plot
# requires python 2.7 # 20180603 seems like 
#module unload python # make sure 2.6 not loaded
#module load python/2.7


################# running fastStructure: #############
# program dir: (downloaded 20180726)
fastDir=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/FASTSTRUCTURE/fastStructure
kvals="1 2 3 4" # set this to whatever numbers you want 


filtering_round=21moose_round1
indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/FASTSTRUCTURE/$filtering_round
outdir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/FASTSTRUCTURE/$filtering_round
infilePREFIX=21Moose_joint_FilterB_Round1_autosomes_SNPs_PASS

# manually added pop levels (step 1b); they should be a column in exact order of samples (gotten order from .fam file) 
pops=$indir/${infilePREFIX}.pops # file list of population assignments (single column) in same order as your sample input *careful here* get order from .fam or .nosex files


 # eventually going to be FASTSTRUCTURE dir
plotdir=$outdir/plots
mkdir -p $plotdir


# want to iterate over several values of K: 
for k in $kvals
do
echo "carrying out faststructure analysis with K = $k "
python $fastDir/structure.py -K $k --input=$indir/$infilePREFIX --output=$outdir/${infilePREFIX}.faststructure_output

# "This generates a genotypes_output.3.log file that tracks how the algorithm proceeds, 
# and files genotypes_output.3.meanQ and genotypes_output.3.meanP 
# containing the posterior mean of admixture proportions and allele frequencies, respectively."
# note that the output prefix has the K value appended, which is handy:
# e.g. XX.test.faststructure_output.2.log is the result of the above line of code with K =2 
# to 
# choose the correct K:

# want to plot each one:
if [ -s $pops ]
then
python $fastDir/distruct.py \
-K $k \
--input=$outdir/$infilePREFIX.faststructure_output \
--output=$plotdir/${infilePREFIX}.faststructure_plot.${k}.svg \
--title="fastStructure Results, K=$k" \
--popfile=$pops

else
echo "you didn't do manual assignment of populations? go back and do that."
python $fastDir/distruct.py \
-K $k \
--input=$outdir/$infilePREFIX.faststructure_output \
--output=$plotdir/${infilePREFIX}.faststructure_plot.${k}.svg \
--title="fastStructure Results, K=$k" 
fi
done
# choose amongst the K values:
python $fastDir/chooseK.py --input=$outdir/$infilePREFIX.faststructure_output > $outdir/$infilePREFIX.faststructure.chooseK.output

