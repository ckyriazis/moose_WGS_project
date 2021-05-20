qsub -cwd -V -N convertGDS -l highp,time=24:00:00,h_data=16G -M eplau -m bea run_ConvertToGDS.sh 
