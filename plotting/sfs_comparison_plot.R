


### Plot comparison on MN empirical SFS and dadi SFS

setwd("~/Documents/UCLA/Moose/Analysis/dadi/data/MN/1D.4Epoch")

sfs_data <- c(188578.6187908466,105531.13267974107,82852.28529411924,72757.42303921563,63495.777941176224,54180.333333334456,26397.98431372567)


#read in output and get theta
dadi_output <- read.table("MN.dadi.inference.1D.4Epoch.runNum.33.output",skip = 1 )
theta <- dadi_output$V14 # may need to change this

#read in sfs, clean up, and fold
sfs_dadi <- read.table("MN.dadi.inference.1D.4Epoch.runNum.33.expSFS", skip=1)
sfs_dadi <- as.numeric(sfs_dadi[1,])
sfs_dadi <- sfs_dadi[-1]
sfs_dadi <- sfs_dadi[-length(sfs_dadi)]
sfs_dadi_folded <- c(sfs_dadi[1]+sfs_dadi[13],sfs_dadi[2]+sfs_dadi[12],sfs_dadi[3]+sfs_dadi[11],sfs_dadi[4]+sfs_dadi[10],sfs_dadi[5]+sfs_dadi[9],+sfs_dadi[6]+sfs_dadi[8],sfs_dadi[7])
sfs_dadi_folded <- sfs_dadi_folded*theta

sfs_matrix <- rbind(sfs_data,sfs_dadi_folded)


#plot 
setwd("~/Documents/UCLA/Moose/Analysis/dadi/plots")
pdf("MN.dadi.inference.1D.4Epoch.runNum.33.pdf", width = 11, height = 5)
par(mar = c(4,5,2,2))

barplot(sfs_matrix, beside=T,names.arg = seq(from=1, to=7), ylim = c(0,200000), ylab="number of variants", col = c("#0072B2","#007E73"), xlab="allele count", cex.lab = 2, cex.axis = 1.3, cex.names = 1.3)
legend(legend = c("data","model"), x = "topright", fill=c("#0072B2","#007E73"), cex=1.7)

dev.off()







### Plot comparison on IR empirical SFS and dadi SFS

setwd("~/Documents/UCLA/Moose/Analysis/dadi/data/IR/1D.5Epoch.FixedTheta.IR/")

sfs_data <- c(122084.6222222219, 92189.8888888926, 66266.66666666551, 31019.33333333366)



run <- "IR.dadi.inference.1D.5Epoch.FixedTheta.IR.runNum.15"

#read in output and get theta
dadi_output <- read.table(paste(run,".output", sep=""),skip = 1 )
theta <- dadi_output$V6

#read in sfs, clean up, and fold
sfs_dadi <- read.table(paste(run,".expSFS",sep=""), skip=1)
sfs_dadi <- as.numeric(sfs_dadi[1,])
sfs_dadi <- sfs_dadi[-1]
sfs_dadi <- sfs_dadi[-length(sfs_dadi)]
sfs_dadi_folded <- c(sfs_dadi[1]+sfs_dadi[7],sfs_dadi[2]+sfs_dadi[6],sfs_dadi[3]+sfs_dadi[5],sfs_dadi[4])
sfs_dadi_folded <- sfs_dadi_folded#*theta

sfs_matrix <- rbind(sfs_data,sfs_dadi_folded)


#plot 
setwd("~/Documents/UCLA/Moose/Analysis/dadi/plots")
pdf(paste(run,".pdf",sep=""), width = 7, height = 5)

barplot(sfs_matrix, beside=T,names.arg = seq(from=1, to=4), ylim = c(0,120000), ylab="count", col = c("#0072B2","#007E73"))
legend(legend = c("data","model"), x = "topright", fill=c("#0072B2","#007E73"))

dev.off()


