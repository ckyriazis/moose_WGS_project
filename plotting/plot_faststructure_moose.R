


### read in and plot all samples

setwd("~/Documents/UCLA/Moose/Analysis/FASTSTRUCTURE/Data/21moose_round1")

## this is the pops file from FASTSTRUCTURE
## modified to help order samples
pops <- read.table("21Moose_joint_FilterB_Round1_autosomes_SNPs_PASS.pops")
#pops_reordered <- read.table("21Moose_joint_FilterB_Round1_autosomes_SNPs_PASS_reordered.pops")


file <- "21Moose_joint_FilterB_Round1_autosomes_SNPs_PASS.faststructure_output.3.meanQ"

output <- read.table(paste(file))
output <- data.frame(t(output))

colnames(output)<- t(pops)


output_ordered <- output[,c(3,4,5,6,7,8,9,1,2,10,11,12,13,14,15,16,17,18,19,20,21)]

# remove .<number> from column names for plotting
#colnames(output_ordered) <- c("IR", "IR", "IR", "IR", "IR", "IR", "IR", "ID", "AK", "WY", "MN", "MN", "MN", "MN", "MN", "MN", "MN", "MN", "MN", "VT", "SW")


library(RColorBrewer)
#colors <- brewer.pal(4,"Spectral")

colors = c("#D55E00","#56B4E9","gray")

 

barplot(as.matrix(output_ordered), col =colors, names.arg = rep("", times=dim(pops)[1]) , cex.axis = 1.2, space = rep(0, times=dim(pops)[1]), ylab = "ancestry proportion", cex.lab=1.3)


setwd("~/Documents/UCLA/Moose/Analysis/FASTSTRUCTURE/Plots/")
pdf(paste(file,".pdf",sep=""), width=6, height=4)

#colors = c("#D55E00","gray","#56B4E9","red")

barplot(as.matrix(output_ordered), col =colors, names.arg =  rep("", times=dim(pops)[1]), cex.axis = 1.2, space = rep(0, times=dim(pops)[1]), ylab = "ancestry proportion", cex.lab=1.3)

dev.off()









### read in and plot MN and IR samples

setwd("~/Documents/UCLA/Moose/Analysis/FASTSTRUCTURE/Data/21moose_round1_MN_IR/")

## this is the pops file from FASTSTRUCTURE
## modified to help order samples
pops <- read.table("21Moose_joint_FilterB_Round1_autosomes_SNPs_PASS.pops")
#pops_reordered <- read.table("21Moose_joint_FilterB_Round1_autosomes_SNPs_PASS_reordered.pops")


file <- "21Moose_joint_FilterB_Round1_autosomes_SNPs_PASS.faststructure_output.2.meanQ"

output <- read.table(paste(file))
output <- data.frame(t(output))

colnames(output)<- t(pops)


#output_ordered <- output[,c(3,4,5,6,7,8,9,1,2,10,11,12,13,14,15,16,17,18,19,20,21)]

# remove .<number> from column names for plotting
#colnames(output_ordered) <- c("IR", "IR", "IR", "IR", "IR", "IR", "IR", "ID", "AK", "WY", "MN", "MN", "MN", "MN", "MN", "MN", "MN", "MN", "MN", "VT", "SW")


library(RColorBrewer)
#colors <- brewer.pal(4,"Spectral")

colors = c("#D55E00","#56B4E9","gray")



barplot(as.matrix(output), col =colors, names.arg = rep("", times=dim(pops)[1]) , cex.axis = 1.2, space = rep(0, times=dim(pops)[1]), ylab = "ancestry proportion", cex.lab=1.3)


setwd("~/Documents/UCLA/Moose/Analysis/FASTSTRUCTURE/Plots/")
pdf(paste(file,"_MN_IR.pdf",sep=""), width=6, height=4)

#colors = c("#D55E00","gray","#56B4E9","red")

barplot(as.matrix(output), col =colors, names.arg =  rep("", times=dim(pops)[1]), cex.axis = 1.2, space = rep(0, times=dim(pops)[1]), ylab = "ancestry proportion", cex.lab=1.3)

dev.off()







