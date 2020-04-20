qsub -cwd -V -N mergeallsites -l highp,h_data=12G,time=100:00:00 -pe shared 4 -M eplau -m bea mergechromallsites_hogdeer.sh


