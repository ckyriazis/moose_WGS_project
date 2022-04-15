# Script for plotting heterozygosity in sliding windows across the genome
# Uses text files containing the following columns (for example):
# chromo	window_start		sites_total	sites_unmasked	sites_passing	sites_variant	calls_sample1	calls_sample2	calls_sample3	hets_sample1	hets_sample2		hets_sample3

# updated on 2-13-20 to draw lines all the way to bottom

library(plyr)

file <- "swhet_21Moose_1000000win_1000000step_round1"
window_size=1000000

setwd(paste("~/Documents/UCLA/Moose/Analysis/slidingWindowHet/Data/", file, sep=""))

# All files have *step.txt naming convention. Get list of files:
winfiles=list.files(pattern="step.txt")

# This is here to reorder the chromosomes and exclude the X
winfiles=winfiles[1:29] #make sure this is excluding X and mt
nchr=length(winfiles)

# Read in chromosome 1
hetdata=read.table(winfiles[1], header=T, sep='\t')

# Add subsequent chromosomes (baboon genome has 20 autosomes)
for (i in 2:nchr){ 
	temp=read.table(winfiles[i], header=T, sep='\t')
	hetdata=rbind(hetdata,temp)
}

#filter out windows with fewer than x% of sites called
#NOTE that the hetdata dataframe needs to be reset if changing this
# jacqueline does 0.2, annabel does 0.8
# not sure if this is needed with the total_calls filter below
threshold=0.80
hetdata=subset(hetdata, hetdata$sites_total>window_size*threshold) 
hist(hetdata$sites_total)
rownames(hetdata) <- 1:nrow(hetdata) # need to reset rownames since these are used to plot



# Get chromosome position info needed for plotting later:
# Get the start positions of each chromosome
pos=as.numeric(rownames(unique(data.frame(hetdata $chromo)[1])))

# Add the end position
pos=append(pos,length(hetdata $chromo))

# Get the midpoints to center chromosome labels on x-axis
numpos=NULL
for (i in 1:length(pos)-1){numpos[i]=(pos[i]+pos[i+1])/2}


# Move out of data files folder
setwd("~/Documents/UCLA/Moose/Analysis/slidingWindowHet/Plots")

# Get the number of samples. Here, the number of columns is 6 + 2*number of samples. Change if necessary.
numsamps=(length(names(hetdata))-6)/2

# Which columns contain the numbers of calls and the numbers of hets?
callcols=seq(7,6+numsamps)
hetcols=seq(7+numsamps,length(names(hetdata)))



het <- hetdata$hets_IR3925/hetdata$calls_IR3925
plot(hetdata$calls_IR3925,het, ylab = "heterozygosity", xlab = "# calls per window")
#quantile(hetdata$calls_IR3925, probs=0.05)


# Filter out windows with low number of calls, as these windows have high variance
total_calls <- rowSums(hetdata[callcols])
hist(total_calls)
thresh <- quantile(total_calls, probs = 0.05) #filter out smallest 5% of tail
hetdata=subset(hetdata, rowSums(hetdata[callcols])>thresh) 



# Get the sample names
sampnames=gsub("calls_", "", names(hetdata)[callcols])

# Which individuals to plot?
samp1="SMoose"
samp2="HM2013"
samp3="MN15"
samp4="MN178"
samp5="MN72"
samp6="MN76"
samp7="MN92"
samp8="MN31"
samp9="MN41"
samp10="MN54"
samp11="MN96"
samp12="IR3925"
samp13="IR3927"
samp14="IR3928"
samp15="IR3929"
samp16="IR3931"
samp17="IR3930"
samp18="IR3934"
samp19="C06"
samp20="JC2001"
samp21="R199"


# Which individuals to plot?

#samp1="IR3925"
#samp2="IR3927"
#samp3="MN54"
#samp4="MN96"
#samp5="C06"
#samp6="HM2013"
#samp7="JC2001"
#samp8="R199"
#samp9="SMoose"

#samp1="SMoose"
#samp2="MN54"
#samp3="IR3925"
#samp4="C06"




hetplot=function(sampname, ymax, title, xlab, ylab, size, color="brown"){
	# Start an empty plot, change ylim as needed
	plot(0,0, type="n", xlim=c(0,pos[length(pos)]), ylim=c(0,ymax), axes=FALSE, xlab="", ylab=ylab, main=title, cex.lab=size, cex.main=size)
	
	# Add lines for chromosome data
	aa=which(sampnames==sampname)
	for (i in 1:nchr){
	  temp=hetdata[which(hetdata$chromo==unique(hetdata$chromo)[i]),]
	 
	  x <- as.numeric(rownames(temp))
	  y <- temp[,hetcols[aa]]/temp[,callcols[aa]]
	  
    
	  for(j in 1:length(x)){
	    lines(x=c(x[j],x[j]),c(0,y[j]), col=color, lwd=1.1)
	  }
	  
		#lines(as.numeric(rownames(temp)),temp[,hetcols[aa]]/temp[,callcols[aa]], col=mycols[i], lwd=1.5)
		
	}
	
	#draw line of mean genome-wide heterozygosity
	mean_het=mean(hetdata[,hetcols[aa]]/hetdata[,callcols[aa]], na.rm=T)
	#abline(h=mean_het, col="red", lty=2)
	print(mean_het)

	# Add y-axis
	axis(2)
	
	# Add x-axis and labels
	title(xlab=xlab, line=2,cex.lab=size)
	axis(side=1, at=pos, labels=FALSE)
	axis(side=1, at=numpos, tick=FALSE, labels=1:nchr, las=3, cex.axis=.8, line=-.2)
	return(na.omit(hetdata[,hetcols[aa]]/hetdata[,callcols[aa]]))
}




# Save as file
pdf(paste(file,"_all_samps.pdf",sep=""), width=12, height=16)

# Plot four plots as 1x4
par(mfrow=c(7,3))

# Set figure margins
par(mar=c(4,4,4,1))

ymax=0.002

het_1 <- hetplot(samp1, ymax, samp1, "Chromosome", "Heterozygosity", size=1)
het_2 <- hetplot(samp2, ymax, samp2, "Chromosome", "Heterozygosity",size=1)
het_3 <- hetplot(samp3, ymax, samp3, "Chromosome", "Heterozygosity",size=1)
het_4 <- hetplot(samp4, ymax, samp4, "Chromosome", "Heterozygosity",size=1)
het_5 <- hetplot(samp5, ymax, samp5, "Chromosome", "Heterozygosity",size=1)
het_6 <- hetplot(samp6, ymax, samp6, "Chromosome", "Heterozygosity",size=1)
het_7 <- hetplot(samp7, ymax, samp7, "Chromosome", "Heterozygosity",size=1)
het_8 <- hetplot(samp8, ymax, samp8, "Chromosome", "Heterozygosity",size=1)
het_9 <- hetplot(samp9, ymax, samp9, "Chromosome", "Heterozygosity",size=1)
het_10 <- hetplot(samp10, ymax, samp10, "Chromosome", "Heterozygosity",size=1)
het_11 <- hetplot(samp11, ymax, samp11, "Chromosome", "Heterozygosity",size=1)
het_12 <- hetplot(samp12, ymax, samp12, "Chromosome", "Heterozygosity",size=1)
het_13 <- hetplot(samp13, ymax, samp13, "Chromosome", "Heterozygosity",size=1)
het_14 <- hetplot(samp14, ymax, samp14, "Chromosome", "Heterozygosity",size=1)
het_15 <- hetplot(samp15, ymax, samp15, "Chromosome", "Heterozygosity",size=1)
het_16 <- hetplot(samp16, ymax, samp16, "Chromosome", "Heterozygosity",size=1)
het_17 <- hetplot(samp17, ymax, samp17, "Chromosome", "Heterozygosity",size=1)
het_18 <- hetplot(samp18, ymax, samp18, "Chromosome", "Heterozygosity",size=1)
het_19 <- hetplot(samp19, ymax, samp19, "Chromosome", "Heterozygosity",size=1)
het_20 <- hetplot(samp20, ymax, samp20, "Chromosome", "Heterozygosity",size=1)
het_21 <- hetplot(samp21, ymax, samp21, "Chromosome", "Heterozygosity",size=1)

# Close figure file
dev.off()




# Save as file
pdf(paste(file,"_3samps.pdf",sep=""), width=12, height=2.75)

# Plot four plots as 1x4
par(mfrow=c(1,3))

# Set figure margins
par(mar=c(4,2,2,0.5))

ymax=0.002

samp1="SMoose"
samp2="MN54"
samp3="IR3925"

het_1 <- hetplot(samp1, ymax, "Sweden", "Chromosome", "Heterozygosity", 1.5, color="#D55E00")
het_2 <- hetplot(samp2, ymax, samp2, "Chromosome", "",1.5, color="#009E73")
het_3 <- hetplot(samp3, ymax, samp3, "Chromosome", "",1.5, color="#56B4E9")

dev.off()





# Draw plot of means
png(paste("mean_",file,".png",sep=""), width=10, height=6, units="in", res=600)
par(mar=c(5,5,2,1))

hets_cow <- c(mean(het_1, na.rm=T),mean(het_2, na.rm=T),mean(het_3, na.rm=T),mean(het_4, na.rm=T),mean(het_5, na.rm=T),mean(het_6, na.rm=T),mean(het_7, na.rm=T),mean(het_8, na.rm=T),mean(het_9, na.rm=T),
              mean(het_10, na.rm=T),mean(het_11, na.rm=T),mean(het_12, na.rm=T),mean(het_13, na.rm=T),mean(het_14, na.rm=T),mean(het_15, na.rm=T),mean(het_16, na.rm=T),mean(het_17, na.rm=T),mean(het_18, na.rm=T),
              mean(het_19, na.rm=T),mean(het_20, na.rm=T),mean(het_21, na.rm=T))

barplot(hets_cow,names.arg = c( samp1,samp2,samp3,samp4,samp5,samp6,samp7,samp8,samp9,samp10,samp11,samp12,samp13,samp14,samp15,samp16,samp17,samp18,samp19,samp20,samp21), ylim = c(0, 0.0006),
        col = "#56B4E9", ylab = "" , las=2)

dev.off()


mean(hets_cow[3:11])





# Draw histograms
png(paste("hist_",file,".png",sep=""), width=13, height=7, units="in", res=600)

par(mfrow=c(6,3))

hist(het_1, main = samp1, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_2, main = samp2, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_3, main = samp3, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_4, main = samp4, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_5, main = samp5, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_6, main = samp6, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_7, main = samp7, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_8, main = samp8, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_9, main = samp9, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_10, main = samp10, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_11, main = samp11, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_12, main = samp12, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_13, main = samp13, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_14, main = samp14, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_15, main = samp15, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_16, main = samp16, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_17, main = samp17, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))
hist(het_18, main = samp18, xlab = "Heterozygosity", breaks = 100, col = "orange", xlim=c(0,max(het_1)))


dev.off()


