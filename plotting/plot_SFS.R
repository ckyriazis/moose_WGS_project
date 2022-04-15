

setwd("~/Documents/UCLA/Moose/Analysis/SFS/projection/plots")


### Minnesota SFSs

# MN chr 1 - 18 haploids
setwd("~/Documents/UCLA/Moose/Analysis/SFS/projection/plots")
png(filename = "MN_chr1_18.png", width = 8, height = 7, units = "in", res=600)

sfs <- c(36377823,9677,5674,3834,3774,3225,2794,2162,3103,1046)
barplot(sfs[-1], names.arg = seq(from=1, to=9), ylim = c(0,10000), ylab="count")

dev.off()


# MN chr 1 - 14 haploids
setwd("~/Documents/UCLA/Moose/Analysis/SFS/projection/plots")
png(filename = "MN_chr1_14.png", width = 8, height = 7, units = "in", res=600)

sfs<- c(2271831.056699323,13053.32647058591,7485.127614378873,5864.322875816929,5128.490686274682,4336.168300653721,3894.048529412032,1966.458823529293)
barplot(sfs[-1], names.arg = seq(from=1, to=7), ylim = c(0,15000), ylab="count")

dev.off()


# MN genome-wide - 14 haploids
setwd("~/Documents/UCLA/Moose/Analysis/SFS/projection/plots")
png(filename = "MN_genomewide_14.png", width = 8, height = 7, units = "in", res=600)

sfs <- c(188578.6187908466,105531.13267974107,82852.28529411924,72757.42303921563,63495.777941176224,54180.333333334456,26397.98431372567)
barplot(sfs, names.arg = seq(from=1, to=7), ylim = c(0,200000), ylab="count")

dev.off()



### Isle royale SFSs

# IR chr 1 - 10 haploids
setwd("~/Documents/UCLA/Moose/Analysis/SFS/projection/plots")
png(filename = "IR_chr1_10.png", width = 8, height = 7, units = "in", res=600)

sfs <- c(2343277.822011376,7371.752913753299,5494.920579420763,5505.371628371595,5037.36713286716,2614.765734265517)
barplot(sfs[-1], names.arg = seq(from=1, to=5), ylim = c(0,8000), ylab="count")

dev.off()


# IR genomewide - 10 haploids
setwd("~/Documents/UCLA/Moose/Analysis/SFS/projection/plots")
png(filename = "IR_genomewide_10.png", width = 8, height = 7, units = "in", res=600)

sfs <- c(109724.83816183955,83910.16183816214,75753.96570096444,62659.320512817554,29351.108391608705)
barplot(sfs, names.arg = seq(from=1, to=5), ylim = c(0,120000), ylab="count")

dev.off()










