import dadi


chrom_list=["NC_037328.1","NC_037329.1","NC_037330.1","NC_037331.1","NC_037332.1","NC_037333.1","NC_037334.1","NC_037335.1","NC_037336.1","NC_037337.1","NC_037338.1","NC_037339.1",
		"NC_037340.1","NC_037341.1","NC_037342.1","NC_037343.1","NC_037344.1","NC_037345.1","NC_037346.1","NC_037347.1","NC_037348.1","NC_037349.1"
		,"NC_037350.1","NC_037351.1","NC_037352.1","NC_037353.1","NC_037354.1","NC_037355.1","NC_037356.1"]

# set this for each pop and projection #
pop="IR-11"
sfs_file=pop+".plusMonomorphic.sfs"
L_file=pop + ".totalSiteCount.L.withMonomorphic.txt"
path = "/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SFS/projection/projection-hetFilter-0.75/" + chrom_list[0] + "/dadi-plusMonomorphic/"

# read in files for first chrom
file0 = open(path+sfs_file, "r")
fs=dadi.Spectrum.from_file(file0)

file1 = open(path+L_file, "r")
line = file1.readlines()[1]
L = int(line.split()[1])

# loop over other chroms and add SFS and L together
for chrom in chrom_list[1:]:
    path = "/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SFS/projection/projection-hetFilter-0.75/" + chrom + "/dadi-plusMonomorphic/"
    f = open(path+sfs_file, "r")
    fs_chrom=dadi.Spectrum.from_file(f)
    fs += fs_chrom

    f1 = open(path+L_file, "r")
    line = f1.readlines()[1]
    L_chrom = int(line.split()[1])
    L += L_chrom



# write output files
#print(L)

outfile = open("/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SFS/projection/projection-hetFilter-0.75/"+pop+".totalSiteCount.L.withMonomorphic.txt", "w")
outfile.write(str(pop)+"\t"+str(L))
outfile.close()

#print(fs)
fs.to_file("/u/home/c/ckyriazi/kirk-bigdata/moose/output/analysis/SFS/projection/projection-hetFilter-0.75/"+pop+".plusMonomorphic.autosomes.sfs")






