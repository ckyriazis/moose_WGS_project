#

#myabb='TenLB'
#qsub -cwd -V -N xsnpext${myabb} -l highp,h_data=4G,time=2:00:00 -pe shared 2 -t 1-38:1 -M eplau -m bea run_extractSNP.sh ${myabb}

myabb='MWgroup'

qsub -cwd -V -N xsnpext${myabb} -l highp,h_data=4G,time=2:00:00 -pe shared 2 -t 1-38:1 -M eplau -m bea run_extractSNPMW.sh ${myabb}

