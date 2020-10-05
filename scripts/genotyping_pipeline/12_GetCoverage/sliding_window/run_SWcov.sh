
file='5_v4_mergeGaTKfiltered_varnonvar_4Caracals_joint_'
#chr=${1} # 'NC_018740.3'

. /u/local/Modules/default/init/modules.sh
module load python/2.7

if [ $SGE_TASK_ID == 1 ]
then
        Chrom=NC_018723.3
elif [ $SGE_TASK_ID == 2 ]
then
        Chrom=NC_018724.3
elif [ $SGE_TASK_ID == 3 ]
then
        Chrom=NC_018725.3
elif [ $SGE_TASK_ID == 4 ]
then
        Chrom=NC_018726.3
elif [ $SGE_TASK_ID == 5 ]
then
        Chrom=NC_018727.3
elif [ $SGE_TASK_ID == 6 ]
then
        Chrom=NC_018728.3
elif [ $SGE_TASK_ID == 7 ]
then
        Chrom=NC_018729.3
elif [ $SGE_TASK_ID == 8 ]
then
        Chrom=NC_018730.3
elif [ $SGE_TASK_ID == 9 ]
then
        Chrom=NC_018731.3
elif [ $SGE_TASK_ID == 10 ]
then
        Chrom=NC_018732.3
elif [ $SGE_TASK_ID == 11 ]
then
        Chrom=NC_018733.3
elif [ $SGE_TASK_ID == 12 ]
then
        Chrom=NC_018734.3
elif [ $SGE_TASK_ID == 13 ]
then
        Chrom=NC_018735.3
elif [ $SGE_TASK_ID == 14 ]
then
        Chrom=NC_018736.3
elif [ $SGE_TASK_ID == 15 ]
then
        Chrom=NC_018737.3
elif [ $SGE_TASK_ID == 16 ]
then
        Chrom=NC_018738.3
elif [ $SGE_TASK_ID == 17 ]
then
        Chrom=NC_018739.3
elif [ $SGE_TASK_ID == 18 ]
then
        Chrom=NC_018740.3
elif [ $SGE_TASK_ID == 19 ]
then
        Chrom=NC_018741.3
elif [ $SGE_TASK_ID == 20 ]
then
        Chrom=NC_001700.1
fi


cd /u/flashscratch/c/ckyriazi/caracals/analyses/step11_GaTKfiltering/${Chrom}

outputdir='/u/flashscratch/c/ckyriazi/caracals/analyses/step14_slidingwindow_coverage/'

#mychr=${SGE_TASK_ID}


myfile=${file}${Chrom}'.vcf.gz'
mywindow=100000
mystep=100000
#mywindow=10000
#mystep=1000

python /u/home/c/ckyriazi/kirk-bigdata/caracal_pipeline/scripts/step14_slidingwindow_coverage/SlidingWindowCov.py ${file}${Chrom}.vcf.gz ${mywindow} ${mystep} ${Chrom}

wait

sleep 10s

mv SWcov_* ${outputdir}

sleep 400s

