

library("RColorBrewer")
sim_name <- "moose_WF_111121_20Mb_strBott"

setwd(paste("~/Documents/UCLA/Moose/simulations/plotting/data/", sim_name, sep=""))
datafiles <- list.files(pattern="tail")

data_frame <- data.frame(matrix(nrow = 0, ncol = 11))

for(rep in seq_along(datafiles)){
  data <- read.table(datafiles[rep], sep=",", header=T)
  data_frame <- rbind(data_frame,cbind(data,rep))
}

## get mean of all reps
gens <- unique(data_frame$gen)
means <- data.frame(matrix(nrow = 0, ncol = 12))

for(gen in gens){
  data_this_gen <- data_frame[which(data_frame$gen==gen),]
  means <- rbind(means,colMeans(data_this_gen))
  
}
colnames(means) <- colnames(data_frame)


NA_bott_start <- 92630
NA_bott_end <- 92660
IR_bott_start <- 93840
IR_bott_end <- 93855

#model 2
#NA_bott_start <- 90885
#NA_bott_end <- 91025
#IR_bott_start <- 92250 
#IR_bott_end <- 92265

#setwd("~/Documents/UCLA/Moose/simulations/plotting/data/")
#data_frame <- read.csv("test.csv", header=T)


#### get %changes due to IR founder event #####

### get pre bottleneck means
data_pre_bott <- data_frame[which(data_frame$gen==IR_bott_start),]
het_pre_bott <- mean(data_pre_bott$meanHetP1)
strDel_pre_bott <- mean(data_pre_bott$avgStrDelP1)
load_pre_bott <- 1-mean(data_pre_bott$meanFitnessP1)
froh_pre_bott <- mean(data_pre_bott$FROH_100kbP1)
B_pre_bott <- mean(data_pre_bott$B)

### get post bottleneck means
data_post_bott <- data_frame[which(data_frame$gen==IR_bott_end),]
het_post_bott <- mean(data_post_bott$meanHetP1)
strDel_post_bott <- mean(data_post_bott$avgStrDelP1)
load_post_bott <- 1-mean(data_post_bott$meanFitnessP1)
froh_post_bott <- mean(data_post_bott$FROH_100kbP1)
B_post_bott <- mean(data_post_bott$B)


### percent difference
(load_post_bott/load_pre_bott-1)*100
(het_post_bott/het_pre_bott-1)*100
(B_post_bott/B_pre_bott-1)*100
froh_post_bott



###### plot IR  bottleneck ######

setwd("~/Documents/UCLA/Moose/simulations/plotting/plots/")

pdf(paste(sim_name,"_IR_bott.pdf", sep=""), width=4, height=8)

xmin <- IR_bott_start
xmax <- IR_bott_end

data_frame_IR <- data_frame[which(data_frame$gen >= xmin & data_frame$gen <= xmax),]
means_IR <- means[which(means$gen >= xmin & means$gen <= xmax),]

colors = brewer.pal(n = 8, name = "GnBu")[4:8]
lwd = 2
lab = 1.5
axis=1.2



par(mfrow=c(5,1),mar = c(3,5,0.5,1), bty = "n")
plot(means_IR$gen, means_IR$popSizeP1, type = "l", ylab = "Population size", lwd = 6, cex.lab=lab, xlab = "",xlim = c(xmin, xmax), col=colors[1], ylim=c(0,200), xaxt = "n", cex.axis=axis)


for(file in seq_along(datafiles)){
  
  data <- data_frame_IR[which(data_frame_IR$rep==file),]
  lines(data$gen,data$popSizeP1, col=colors[1])
}


plot(means_IR$gen,means_IR$meanHetP1, type = "l", ylab = "Heterozygosity", lwd = 4, cex.lab=lab, xlab = "",xlim = c(xmin, xmax), col="black", ylim = c(1e-4,0.0005), xaxt = "n", cex.axis=axis)


for(file in seq_along(datafiles)){
  
  data <- data_frame_IR[which(data_frame_IR$rep==file),]
  lines(data$gen, data$meanHetP1, lwd = lwd, col=colors[2])
}
lines(means_IR$gen,means_IR$meanHetP1, lwd=3, col="black")
abline(h=0.0002411881, lty=2, lwd=2)


plot(means_IR$gen,means_IR$FROH_100kbP1, type = "l", ylab = expression('F'[ROH]), lwd = 4, cex.lab=lab, xlab = "",xlim = c(xmin, xmax), col="black", ylim=c(0,0.7), xaxt = "n", cex.axis=axis)


for(file in seq_along(datafiles)){
  
  data <- data_frame_IR[which(data_frame_IR$rep==file),]
  lines(data$gen, data$FROH_100kbP1, lwd = lwd, col=colors[3])
}
lines(means_IR$gen,means_IR$FROH_100kbP1, lwd=3, col="black")
abline(h=0.3514678, lty=2, lwd=2)

#abline(h=0.2567888, lty=2, lwd=2) # 1 Mb mean FROH



plot(means_IR$gen,1-means_IR$meanFitnessP1, type = "l", ylab = "Genetic load", lwd = 4, cex.lab=lab, xlab = "",xlim = c(xmin, xmax), col="black", ylim = c(0,0.08), xaxt = "n", cex.axis=axis)


for(file in seq_along(datafiles)){
  
  data <- data_frame_IR[which(data_frame_IR$rep==file),]
  lines(data$gen, 1-data$meanFitnessP1, lwd = lwd, col=colors[4])
}
lines(means_IR$gen,1-means_IR$meanFitnessP1, lwd=3, col="black")



par(mar = c(4,5,0.5,1), bty = "n")

plot(means_IR$gen,means_IR$B, type = "l", ylab = "Inbreeding load", lwd = 4, cex.lab=lab, xlab = "Generations before present",xlim = c(xmin, xmax), col="black", ylim = c(0,0.4), xaxt = "n", cex.axis=axis)
axis(1, at=seq(xmin,xmax, by=5), labels=-seq(xmin-xmax, 0, by = 5), cex.axis=axis)

for(file in seq_along(datafiles)){
  
  data <- data_frame_IR[which(data_frame_IR$rep==file),]
  lines(data$gen, data$B, lwd = lwd, col=colors[5])
  #if(max(data$B/2) > 0.3){
  #  print(file)
  #}
}
lines(means_IR$gen,means_IR$B, lwd=3, col="black")


dev.off()








#### get %changes due to NA founder event #####

### get pre bottleneck means
data_pre_bott <- data_frame[which(data_frame$gen==NA_bott_start),]
het_pre_bott <- mean(data_pre_bott$meanHetP1)
strDel_pre_bott <- mean(data_pre_bott$avgStrDelP1)
load_pre_bott <- 1-mean(data_pre_bott$meanFitnessP1)
froh_pre_bott <- mean(data_pre_bott$FROH_100kbP1)
B_pre_bott <- mean(data_pre_bott$B)/2


### get post bottleneck means
data_post_bott <- data_frame[which(data_frame$gen==NA_bott_end),]
mean(data_post_bott$meanHetP1)
het_post_bott <- mean(data_post_bott$meanHetP1)
strDel_post_bott <- mean(data_post_bott$avgStrDelP1)
load_post_bott <- 1-mean(data_post_bott$meanFitnessP1)
froh_post_bott <- mean(data_post_bott$FROH_100kbP1)
B_post_bott <- mean(data_post_bott$B)


### percent difference immediately after bottleneck
(load_post_bott/load_pre_bott-1)*100
(het_post_bott/het_pre_bott-1)*100
(B_post_bott/B_pre_bott-1)*100
froh_post_bott

### get means after recovery
data_recov <- data_frame[which(data_frame$gen==IR_bott_start),]
het_recov <- mean(data_recov$meanHetP1)
strDel_recov <- mean(data_recov$avgStrDelP1)
load_recov <- 1-mean(data_recov$meanFitnessP1)
froh_recov <- mean(data_recov$FROH_100kbP1)
B_recov <- mean(data_recov$B)


### percent difference after recovery
(load_recov/load_pre_bott-1)*100
(het_recov/het_pre_bott-1)*100
(B_recov/B_pre_bott-1)*100
froh_recov


### plot NA founding bottleneck

setwd("~/Documents/UCLA/Moose/simulations/plotting/plots/")

pdf(paste(sim_name,"_NA_founding_bott.pdf", sep=""), width=4, height=8)


xmin <- NA_bott_start - 190
xmax <- IR_bott_start

data_frame_NA <- data_frame[which(data_frame$gen >= xmin & data_frame$gen <= xmax),]
means_NA <- means[which(means$gen >= xmin & means$gen <= xmax),]

colors = brewer.pal(n = 8, name = "GnBu")[4:8]
lwd = 2
lab = 1.5
axis=1.2

par(mfrow=c(5,1),mar = c(3,5,2,1), bty = "n")
plot(means_NA$gen, means_NA$popSizeP1, type = "l", ylab = "Population size", lwd = 6, cex.lab=lab, xlab = "",xlim = c(xmin, xmax), col=colors[1], xaxt = "n", ylim=c(0,200000), cex.axis=axis)


for(file in seq_along(datafiles)){
  
  data <- data_frame_NA[which(data_frame_NA$rep==file),]
  lines(data$gen,data$popSizeP1, col=colors[1])
}

par(mar = c(3,5,0.5,1), bty = "n")
plot(means_NA$gen,means_NA$meanHetP1, type = "l", ylab = "Heterozygosity", lwd = 4, cex.lab=lab, xlab = "",xlim = c(xmin, xmax), col="black", ylim = c(1e-4,0.0005), xaxt = "n", cex.axis=axis)


for(file in seq_along(datafiles)){
  
  data <- data_frame_NA[which(data_frame_NA$rep==file),]
  lines(data$gen, data$meanHetP1, lwd = lwd, col=colors[2])
}
lines(means_NA$gen,means_NA$meanHetP1, lwd=3, col="black")

abline(h=0.000341194, lty=2, lwd=2) #mean for MN and AK samples



plot(means_NA$gen,means_NA$FROH_100kbP1, type = "l", ylab = expression('F'[ROH]), lwd = 4, cex.lab=lab, xlab = "",xlim = c(xmin, xmax), col="black", ylim=c(0,max(data_frame_NA$FROH_100kbP1)), xaxt = "n", cex.axis=axis)


for(file in seq_along(datafiles)){
  
  data <- data_frame_NA[which(data_frame_NA$rep==file),]
  lines(data$gen, data$FROH_100kbP1, lwd = lwd, col=colors[3])
}
lines(means_NA$gen,means_NA$FROH_100kbP1, lwd=3, col="black")
abline(h=0.12, lty=2, lwd=2)
#abline(h=0.02996807, lty=2, lwd=2) # mean for 1Mb cutoff


plot(means_NA$gen,1-means_NA$meanFitnessP1, type = "l", ylab = "Genetic load", lwd = 4, cex.lab=lab, xlab = "",xlim = c(xmin, xmax), col="black", ylim = c(0,max(1-data_frame_NA$meanFitnessP1)), xaxt = "n", cex.axis=axis)


for(file in seq_along(datafiles)){
  
  data <- data_frame_NA[which(data_frame_NA$rep==file),]
  lines(data$gen, 1-data$meanFitnessP1, lwd = lwd, col=colors[4])
}
lines(means_NA$gen,1-means_NA$meanFitnessP1, lwd=3, col="black")



par(mar = c(4,5,0.5,1), bty = "n")

plot(means_NA$gen,means_NA$B, type = "l", ylab = "Inbreeding load", lwd = 4, cex.lab=lab, xlab = "Generations before present",xlim = c(xmin, xmax), col="black", ylim = c(0,max(data_frame_NA$B)), xaxt = "n", cex.axis=axis)
axis(1, at=seq(xmin,xmax, by=100), labels=-seq(xmin-xmax, 0, by = 100), cex.axis=1.1)

for(file in seq_along(datafiles)){
  
  data <- data_frame_NA[which(data_frame_NA$rep==file),]
  lines(data$gen, data$B, lwd = lwd, col=colors[5])
}
lines(means_NA$gen,means_NA$B, lwd=3, col="black")



dev.off()









### plot comparing allele counts before and after bottleneck

data_bott_start <- data_frame[which(data_frame$gen == IR_bott_start) ,]
data_bott_end <- data_frame[which(data_frame$gen == IR_bott_end) ,]

setwd("~/Documents/UCLA/Moose/simulations/plotting/plots/")

pdf("allele_count_boxplot.pdf", width = 7, height = 7)
par(mfrow=c(2,2))

labs = 1.5
axis = 1.3

#boxplot(data_bott_start$avgNeutP1,data_bott_end$avgNeutP1, col = "#0072B2", names = c("mainland","island"), ylab="avg. # alleles per ind.", main = "neutral alleles", cex.lab=lab, cex.axis=axis)

boxplot(data_bott_start$avgWkDelP1,data_bott_end$avgWkDelP1, col = "#0072B2", names = c("mainland","island"), ylab="avg. # alleles per ind.", main = "weakly deleterious alleles", cex.lab=lab, cex.axis=axis)

boxplot(data_bott_start$avgModDelP1,data_bott_end$avgModDelP1, col = "#0072B2", names = c("mainland","island"), ylab="avg. # alleles per ind.", main = "moderately deleterious alleles", cex.lab=lab, cex.axis=axis)

boxplot(data_bott_start$avgStrDelP1-data_bott_start$avgvStrDelP1,data_bott_end$avgStrDelP1-data_bott_end$avgvStrDelP1, col = "#0072B2", names = c("mainland","island"), ylab="avg. # alleles per ind.", main = "strongly deleterious alleles", cex.lab=lab, cex.axis=axis)

boxplot(data_bott_start$avgvStrDelP1,data_bott_end$avgvStrDelP1, col = "#0072B2", names = c("mainland","island"), ylab="avg. # alleles per ind.", main = "very strongly deleterious alleles", cex.lab=lab, cex.axis=axis)


dev.off()

mean(data_bott_start$meanFitnessP1)

mean(data_bott_end$meanFitnessP1)

