# script for plotting PCA modified from Annabel's github page, accessed 8-28-18: https://github.com/ab08028/OtterExomeProject/blob/master/scripts/scripts_20180521/analyses/PCA/20180806/PCA_Step_1_PlotPCA.20180806.R
## code for plotting running and plotting PCA using SNPrelate

#load R packages
library(gdsfmt)
library(SNPRelate)



#open the gds file
setwd("/Users/christopherkyriazis/Documents/UCLA/Moose/Analysis/SNPrelate/Data/")
genofile <- snpgdsOpen("21Moose_joint_FilterB_Round1_autosomes_SNPs_PASS.gds")

# 20180802: adding LD snp pruning: (1min); r2 threshold : 0.2; recommended by SNPRelate tutorial
# https://bioconductor.org/packages/devel/bioc/vignettes/SNPRelate/inst/doc/SNPRelateTutorial.html#ld-based-snp-pruning
ld_thres=0.2
snpset <- snpgdsLDpruning(genofile, ld.threshold=ld_thres,autosome.only = F, remove.monosnp=T)
#head(snpset)

# Get all selected snp id
snpset.id <- unlist(snpset)
head(snpset.id)


#population information
sample.id = read.gdsn(index.gdsn(genofile, "sample.id"))
pop_code = c("Idaho","Alaska","Isle Royale", "Isle Royale", "Isle Royale", "Isle Royale", "Isle Royale", "Isle Royale","Isle Royale","Wyoming","Minnesota", "Minnesota", "Minnesota", "Minnesota", "Minnesota", "Minnesota", "Minnesota", "Minnesota", "Minnesota","Vermont","Sweden")


# for subsetting - to use, enter in "sample.id"
IR_samps <- c("IR3920","IR3921","IR3925","IR3927","IR3928","IR3929","IR3930", "IR3931", "IR3934")
MN_samps <- c("MN15","MN178","MN31","MN41","MN54","MN72","MN76","MN92","MN96")
NA_samps <- c("C06",  "HM2013", "IR3925" ,"IR3927" ,"IR3928", "IR3929", "IR3930", "IR3931", "IR3934", "JC2001", "MN15",   "MN178",  "MN31","MN41","MN54","MN72","MN76", "MN92", "MN96", "R199")
one_per_pop <- c("C06",  "HM2013", "IR3934", "JC2001", "MN96", "R199","SMoose")
one_per_pop_NA <- c("C06",  "HM2013", "IR3934", "JC2001", "MN96", "R199")
remove_relatives <- c("C06",  "HM2013", "IR3925" ,"IR3928", "IR3929", "IR3931", "IR3934", "JC2001", "MN15",   "MN178",  "MN31","MN41","MN54","MN72","MN76", "MN92", "MN96", "R199","SMoose")



#pca (fast)
maf=0.05 # make sure MAF>(1/2n) to avoid singletons
pca <- snpgdsPCA(genofile,snp.id=snpset.id,autosome.only = F, maf=maf, missing.rate=0.2, sample.id=remove_relatives)

#variance proportion (%)
pc.percent <- pca$varprop*100
pc = head(round(pc.percent, 2))
pc

#make a data.frame
tab <- data.frame(sample.id = pca$sample.id,
                  pop = factor(pop_code)[match(pca$sample.id, sample.id)],
                  EV1 = pca$eigenvect[,1],    # the first eigenvector
                  EV2 = pca$eigenvect[,2],    # the second eigenvector
                  EV3 = pca$eigenvect[,3],    # the third eigenvector
                  EV4 = pca$eigenvect[,4],    # the fourth eigenvector
                  stringsAsFactors = FALSE)
head(tab)




## PCA for all samples
setwd("/Users/christopherkyriazis/Documents/UCLA/Moose/Analysis/SNPrelate/Plots/")
pdf(paste(genofile,"_ld",ld_thres,"_maf",maf,"_all_samps.pdf",sep=""),width=6, height=5)
par(mar=c(4.5,4.5,1,1))


col_all_samps <- c("#000000","#E69F00","#56B4E9","#56B4E9","#56B4E9","#56B4E9","#56B4E9","#56B4E9","#56B4E9","#F0E442","#009E73","#009E73","#009E73","#009E73","#009E73","#009E73","#009E73","#009E73","#009E73","#0072B2","#D55E00")
col_all_samps_legend <- c("#E69F00","#000000","#56B4E9","#009E73","#D55E00","#0072B2","#F0E442")

as.integer(tab$pop)

plot(tab$EV1, tab$EV2, col=col_all_samps, xlab=paste("PC1 (",pc[1],"%)",sep=""), 
     ylab=paste("PC2 (",pc[2],"%)",sep=""), pch=19,cex=1.6, main="", cex.axis=1.3, cex.lab=1.5)
legend("bottomright", legend=levels(tab$pop), pch=19,cex=1.3, col=col_all_samps_legend)
#text(tab$EV2~tab$EV1, labels=tab$sample.id)

dev.off()



## downsample to one individual per pop for NA samples
setwd("/Users/christopherkyriazis/Documents/UCLA/Moose/Analysis/SNPrelate/Plots/")
pdf(paste(genofile,"_ld",ld_thres,"_maf",maf,"_one_per_pop_NA.pdf",sep=""),width=3.5, height=3) 

par(mar=c(4.5,4.5,1,1))


one_per_pop_NA <- c("C06",  "HM2013", "IR3934", "JC2001", "MN96", "R199")
pop_code = c("Idaho","Alaska","Isle Royale", "Isle Royale", "Isle Royale", "Isle Royale", "Isle Royale", "Isle Royale","Isle Royale","Wyoming","Minnesota", "Minnesota", "Minnesota", "Minnesota", "Minnesota", "Minnesota", "Minnesota", "Minnesota", "Minnesota","Vermont","Sweden")

col_one_per_pop_NA <- c("#000000","#E69F00","#56B4E9","#F0E442","#009E73","#0072B2")

as.integer(tab$pop)

plot(tab$EV1, tab$EV2, col=col_one_per_pop_NA, xlab=paste("PC1 (",pc[1],"%)",sep=""), 
     ylab=paste("PC2 (",pc[2],"%)",sep=""), pch=19,cex=1.7, main="", cex.lab=1.3, cex.axis=1.1)
#text(tab$EV2~tab$EV1, labels=tab$sample.id)

dev.off()





## PCA for all samples excluding close relatives
setwd("/Users/christopherkyriazis/Documents/UCLA/Moose/Analysis/SNPrelate/Plots/")
pdf(paste(genofile,"_ld",ld_thres,"_maf",maf,"_all_samps.pdf",sep=""),width=6, height=5)
par(mar=c(4.5,4.5,1,1))



col_all_samps <- c("#000000","#E69F00","#56B4E9","#56B4E9","#56B4E9","#56B4E9","#56B4E9","#F0E442","#009E73","#009E73","#009E73","#009E73","#009E73","#009E73","#009E73","#009E73","#009E73","#0072B2","#D55E00")
col_all_samps_legend <- c("#E69F00","#000000","#56B4E9","#009E73","#D55E00","#0072B2","#F0E442")

as.integer(tab$pop)

plot(tab$EV1, tab$EV2, col=col_all_samps, xlab=paste("PC1 (",pc[1],"%)",sep=""), 
     ylab=paste("PC2 (",pc[2],"%)",sep=""), pch=19,cex=1.6, main="", cex.axis=1.3, cex.lab=1.5)
#legend("bottomright", legend=levels(tab$pop), pch=19,cex=1.3, col=col_all_samps_legend)
#text(tab$EV2~tab$EV1, labels=tab$sample.id)

dev.off()










#plot third EV
plot(tab$EV2, tab$EV3, col=as.integer(tab$pop), xlab=paste("PC1 (",pc[1],"%)",sep=""), 
     ylab=paste("PC3 (",pc[3],"%)",sep=""), pch=4,cex=1.5, main=paste("PCA of ",as.character(length(pca$snp.id))," LD Pruned SNPs",sep=""))
legend("topright", legend=levels(tab$pop), pch=4,cex=1, col=1:nlevels(tab$pop))
text(tab$EV3~tab$EV2, labels=tab$sample.id)


#close gds file
snpgdsClose(genofile)

