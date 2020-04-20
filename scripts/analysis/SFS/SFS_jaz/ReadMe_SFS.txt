
The script generateSFSCounts.py will go thru a VCF file and output alternate allele counts for generating an SFS.
In order to submit the script as follows: python generateSFSCounts.py inputFilename.vcf outputFilename.txt

If you want to submit each chromosome as a job you need two files:
submit_GenSFSpythonscipt.sh and qsub_submit_GenerateSFSpythonscript.sh
	-the submit_GenSFS script contains the command to run the script
	- the qsub_submit_GenSFS is the script that submits each chromosome as a job
	
Enter the command to submit each chromosome as a job: ./qsub_submit_GenerateSFSpythonscript.sh
     
