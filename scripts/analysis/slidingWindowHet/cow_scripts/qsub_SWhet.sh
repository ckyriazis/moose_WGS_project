
qsub -cwd -V -N swHet -l highp,time=24:00:00,h_data=4G -M eplau -m a -t 1-29:1 -o /u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/slidingWindowHet -e /u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/slidingWindowHet run_SWhet.sh




 
