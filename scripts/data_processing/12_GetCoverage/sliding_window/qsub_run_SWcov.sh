
qsub -cwd -V -N swCov_test -l highp,time=24:00:00 -t 1-20:1 -M eplau -m bea run_SWcov.sh
sleep 10s


