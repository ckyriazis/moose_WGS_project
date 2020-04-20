qsub -cwd -V -N moose_filtering -l highp,h_data=4G,time=24:00:00 -pe shared 3 -M eplau -m bea -t 1 run_moose_filtering.sh












