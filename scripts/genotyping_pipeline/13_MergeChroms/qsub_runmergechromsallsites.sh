qsub -cwd -V -N merge -l highp,h_data=12G,time=100:00:00 -pe shared 4 -M eplau -m bea mergechromallsites.sh


