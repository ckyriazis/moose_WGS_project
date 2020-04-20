
qsub -cwd -V -N vcftools_lroh -l highp,time=2:00:00,h_data=4G -M eplau -m bea -t 1-18:1 run_vcftools_lroh.sh


