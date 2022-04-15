## This script is for filtering and plotting bcftools roh output
## Input is (optionally gzipped) .out files from bcftools ROH
## subsetted down to have one file for each individual
## as the total file size can be quite large

# Author: Chris Kyriazis


#### Define functions ####

## Define function that takes in data frame and divides it into three length classes
classify_roh <- function(roh_dataframe, min_roh_length){
  short_roh <- subset(roh_dataframe,length>min_roh_length & length<1000000) # roh_dataframe[length>100000 & length<1000000]
  med_roh <- subset(roh_dataframe, length>1000000 & length<10000000)
  long_roh <-  subset(roh_dataframe, length>10000000 & length<100000000)
  
  #sum each class and divide by 1000000 to convert to Mb
  sum_short_Mb <- sum(short_roh$length)/1000000
  sum_med_Mb <- sum(med_roh$length)/1000000
  sum_long_Mb <- sum(long_roh$length)/1000000
  
  print(paste("This individual has",dim(short_roh)[1],"short ROHs summing to",sum_short_Mb, "Mb",
              dim(med_roh)[1],"medium ROHs summing to",sum_med_Mb,"Mb, and",
              dim(long_roh)[1],"long ROHs summing to",sum_long_Mb, "Mb"))
  
  return(c(sum_short_Mb, sum_med_Mb, sum_long_Mb))
  #roh_matrix_Mb <- roh_matrix/1000000 #convert to Mb
  
}

## Define function to read in output files for each individual and filter out ROHs less than min_roh_length
read_filter_roh <- function(data, min_roh_length){
  output <- read.table(paste(data,".out.gz",sep=""), col.names=c("row_type","sample","chrom","start","end","length","num_markers","qual"), fill=T)
  output1 <- subset(output, row_type == "RG")
  output_class_sums <- classify_roh(output1, min_roh_length=min_roh_length)
  return(output_class_sums)
}





### Code for samples mapped to Cow ####

setwd("~/Documents/UCLA/Moose/Analysis/ROH/Data/21moose_round1_noSmoose/")
# set filename excluding individual and ".out.gz"
file <- "_21moose_round1_roh_bcftools_G30_noSMoose"
individuals <- c("IR3925","IR3927","IR3928","IR3929","IR3930", "IR3931", "IR3934","MN15","MN178","MN31","MN41","MN54","MN72","MN76","MN92","MN96","C06","HM2013","JC2001","R199")

genome_length <- (2715.837454-139.009144-87.442531) # total length - x length - unplaced scaffold length
  
  

# min size allowable for ROHs - typically 100kb or 300kb
min_roh_length=100000

## Read in data, filter, and classify ROHs ##

## initialize data frame
roh_size_df_cow <- data.frame(matrix(nrow=3, ncol=length(individuals)))
colnames(roh_size_df_cow) <- individuals
froh_cow <- c()

## read in data for each individaul
## note that this can be VERY slow - takes several min per individual
roh_size_df_cow <- read.csv(file = "roh_size_df_cow.csv", header=T)

for(i in 1:length(individuals)){
#  roh_size_df_cow[,i] <- read_filter_roh(paste(individuals[i],file, sep=""), min_roh_length=min_roh_length)
  froh_cow = c(froh_cow,sum(roh_size_df_cow[2:3,i])/genome_length) # sum ROHs >min_roh_length and divide by genome length to estimate Froh
}

# write df to csv
#write.csv("roh_size_df_cow.csv", x = roh_size_df_cow, row.names=F)



# plot
setwd("~/Documents/UCLA/Moose/Analysis/ROH/Plots/")

pdf(paste("barplot",file,".pdf",sep=""), width=10, height=6)

roh_size_df_reordered <- roh_size_df_cow[,c(18,8,9,10,11,12,13,14,15,16,1,2,3,4,5,6,7,17,19,20)]

individuals <- c("Alaska", "MN15", "MN178", "MN31", "MN41","MN54","MN72","MN76","MN92","MN96","IR3925", "IR3927", "IR3928", "IR3929", "IR3930", "IR3931", "IR3934","Idaho", "Wyoming","Vermont"  )
barplot(as.matrix(roh_size_df_reordered), names.arg = individuals, col=c("seashell","seashell3", "seashell4"), ylab="Summed ROH length (Mb)", xlab="", ylim=c(0,1000), las=2)
#legend("topright",legend=c(paste(min_roh_length/1000000,"-1 Mb",sep=""), "1-10 Mb", "10-100 Mb"), col=c("red","orange", "yellow"), fill=c("seashell","seashell3", "seashell4"))

dev.off()





### Code for samples mapped to Hog deer ####

setwd("~/Documents/UCLA/Moose/Analysis/ROH/Data/9moose_hogdeer_round2/")
# set filename excluding individual and ".out.gz"
file <- "_9moose_round2_hogdeer_roh_bcftools_G30"
individuals <- c("IR3925","IR3927","IR3928","IR3929","IR3931", "MN31","MN41","MN54","MN96")

genome_length <- 2478.996145 # length of 192 longest scaffolds

# min size allowable for ROHs - typically 100kb or 300kb
min_roh_length=100000

## Read in data, filter, and classify ROHs ##

## initialize data frame
roh_size_df_hd <- data.frame(matrix(nrow=3, ncol=length(individuals)))
colnames(roh_size_df_hd) <- individuals
froh_hd <- c()

## read in data for each individaul
## note that this can be VERY slow - takes several min per individual
roh_size_df_hd <- read.csv(file = "roh_size_df_hd.csv", header=T)
for(i in 1:length(individuals)){
#  roh_size_df_hd[,i] <- read_filter_roh(paste(individuals[i],file, sep=""), min_roh_length=min_roh_length)
  froh_hd = c(froh_hd,sum(roh_size_df_hd[1:3,i])/genome_length) # sum ROHs >min_roh_length and divide by genome length to estimate Froh
}


# write df to csv
#write.csv("roh_size_df_hd.csv", x = roh_size_df_hd, row.names=F)


# plot
setwd("~/Documents/UCLA/Moose/Analysis/ROH/Plots/")
pdf(paste("barplot",file,".pdf",sep=""), width=10, height=6)

roh_size_df_reordered <- roh_size_df_hd[,c(6,7,8,9,1,2,3,4,5)]
individuals <- c("MN31","MN41","MN54","MN96","IR3925","IR3927","IR3928","IR3929","IR3931")

barplot(as.matrix(roh_size_df_reordered), names.arg = individuals, col=c("seashell","seashell3", "seashell4"), ylab="Summed ROH length (Mb)", xlab="", ylim=c(0,1000), las=2)
legend("topleft",legend=c(paste(min_roh_length/1000000,"-1 Mb",sep=""), "1-10 Mb", "10-100 Mb"), col=c("red","orange", "yellow"), fill=c("seashell","seashell3", "seashell4"))

dev.off()




### plot FROH for cow and hogdeer side-by-side
setwd("~/Documents/UCLA/Moose/Analysis/ROH/Plots/")
pdf("froh_comparison.pdf", width=8, height=6)

individuals <- c("IR3925","IR3927","IR3928","IR3929","IR3931", "MN31","MN41","MN54","MN96")

froh_cow_subset <- froh_cow[c(1,2,3,4,6,10,11,12,16)]

barplot(rbind(froh_cow_subset,froh_hd), beside=T, names.arg = individuals, las=2, ylab="FROH", col=c("aquamarine3","coral"), ylim = c(0,0.4))
legend("topright", c("cow","hog deer"), pch=15, col=c("aquamarine3","coral"))

dev.off()


mean((froh_cow_subset-froh_hd)/froh_hd)


### plot FROH for all samples mapped to cow
setwd("~/Documents/UCLA/Moose/Analysis/ROH/Plots/")
pdf("froh_cow_1Mb.pdf", width=8, height=6)

individuals <- c("Alaska", "MN15", "MN178", "MN31", "MN41","MN54","MN72","MN76","MN92","MN96","IR3925", "IR3927", "IR3928", "IR3929", "IR3930", "IR3931", "IR3934","Idaho", "Wyoming","Vermont"  )
froh_cow_reordered <- froh_cow[c(18,8,9,10,11,12,13,14,15,16,1,2,3,4,5,6,7,17,19,20)]

barplot(froh_cow_reordered, names.arg = individuals, ylab = "FROH", las=2, ylim = c(0,0.3))

dev.off()




# mean froh of IR samples
froh_cow_reordered <- froh_cow[c(18,8,9,10,11,12,13,14,15,16,1,2,3,4,5,6,7,17,19,20)]
mean(froh_cow_reordered[11:17])
max(froh_cow_reordered[11:17])
min(froh_cow_reordered[11:17])


# mean froh of MN samples
mean(froh_cow_reordered[2:10])
max(froh_cow_reordered[2:10])
min(froh_cow_reordered[2:10])


colSums(roh_size_df_cow[2:3,])/colSums(roh_size_df_cow)[]




### Froh plot of all samples for presentation
setwd("~/Documents/UCLA/Moose/Analysis/ROH/Plots/")
pdf("froh_cow_1Mb_presentation.pdf", width=7, height=5)

cols <- c("#E69F00","#009E73","#009E73","#009E73","#009E73","#009E73","#009E73","#009E73","#009E73","#009E73","#56B4E9","#56B4E9","#56B4E9","#56B4E9","#56B4E9","#56B4E9","#56B4E9","#000000","#F0E442","#0072B2")

individuals <- c("Alaska", "MN15", "MN178", "MN31", "MN41","MN54","MN72","MN76","MN92","MN96","IR3925", "IR3927", "IR3928", "IR3929", "IR3930", "IR3931", "IR3934","Idaho", "Wyoming","Vermont"  )
froh_cow_reordered <- froh_cow[c(18,8,9,10,11,12,13,14,15,16,1,2,3,4,5,6,7,17,19,20)]
pops <-  c("Alaska","Idaho","Isle Royale", "Minnesota","Vermont","Wyoming" )
cols_legend <- c("#E69F00","#000000","#56B4E9","#009E73","#0072B2","#F0E442")


barplot(froh_cow_reordered, names.arg = individuals, ylab = "FROH", las=2, ylim = c(0,0.3), col =cols )
legend("topleft", legend=pops,cex=1, fill=cols_legend,ncol=2, bty="n")

dev.off()

















### Code for samples mapped to Cow - only SNPs

setwd("~/Documents/UCLA/Moose/Analysis/ROH/Data/21moose_round1_noSmoose_SNPs/")
# set filename excluding individual and ".out.gz"
file <- "_21Moose_joint_FilterB_Round1_autosomes_SNPs_noSMoose"
individuals <- c("IR3925","IR3927","IR3928","IR3929","IR3930", "IR3931", "IR3934","MN15","MN178","MN31","MN41","MN54","MN72","MN76","MN92","MN96","C06","HM2013","JC2001","R199")

genome_length <- (2715.837454-139.009144-87.442531) # total length - x length - unplaced scaffold length



# min size allowable for ROHs - typically 100kb or 300kb
min_roh_length=100000

## Read in data, filter, and classify ROHs ##

## initialize data frame
roh_size_df_cow_SNPs <- data.frame(matrix(nrow=3, ncol=length(individuals)))
colnames(roh_size_df_cow_SNPs) <- individuals
froh_cow_SNPs <- c()

## read in data for each individaul
## note that this can be VERY slow - takes several min per individual
roh_size_df_cow_SNPs <- read.csv(file = "roh_size_df_cow_SNPs.csv", header=T)

for(i in 1:length(individuals)){
  #roh_size_df_cow_SNPs[,i] <- read_filter_roh(paste(individuals[i],file, sep=""), min_roh_length=min_roh_length)
  froh_cow_SNPs = c(froh_cow_SNPs,sum(roh_size_df_cow_SNPs[1:3,i])/genome_length) # sum ROHs >min_roh_length and divide by genome length to estimate Froh
}

# write df to csv
#write.csv("roh_size_df_cow_SNPs.csv", x = roh_size_df_cow_SNPs, row.names=F)



# plot
setwd("~/Documents/UCLA/Moose/Analysis/ROH/Plots/")

pdf(paste("barplot",file,".pdf",sep=""), width=10, height=6)

roh_size_df_reordered_SNPs <- roh_size_df_cow_SNPs[,c(18,8,9,10,11,12,13,14,15,16,1,2,3,4,5,6,7,17,19,20)]

individuals <- c("Alaska", "MN15", "MN178", "MN31", "MN41","MN54","MN72","MN76","MN92","MN96","IR3925", "IR3927", "IR3928", "IR3929", "IR3930", "IR3931", "IR3934","Idaho", "Wyoming","Vermont"  )
barplot(as.matrix(roh_size_df_reordered_SNPs), names.arg = individuals, col=c("seashell","seashell3", "seashell4"), ylab="Summed ROH length (Mb)", xlab="", ylim=c(0,1000), las=2)
#legend("topright",legend=c(paste(min_roh_length/1000000,"-1 Mb",sep=""), "1-10 Mb", "10-100 Mb"), col=c("red","orange", "yellow"), fill=c("seashell","seashell3", "seashell4"))

dev.off()




