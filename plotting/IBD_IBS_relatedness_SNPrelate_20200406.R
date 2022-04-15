# script for plotting PCA modified from Annabel's github page, accessed 8-28-18: https://github.com/ab08028/OtterExomeProject/blob/master/scripts/scripts_20180521/analyses/PCA/20180806/PCA_Step_1_PlotPCA.20180806.R
## code for plotting running and plotting PCA using SNPrelate

#load R packages
library(gdsfmt)
library(SNPRelate)
library(ggplot2)



#open the gds file
setwd("/Users/christopherkyriazis/Documents/UCLA/Moose/Analysis/SNPrelate/Data/")
genofile <- snpgdsOpen("21Moose_joint_FilterB_Round1_autosomes_SNPs_PASS.gds")

# 20180802: adding LD snp pruning: (1min); r2 threshold : 0.2; recommended by SNPRelate tutorial
# https://bioconductor.org/packages/devel/bioc/vignettes/SNPRelate/inst/doc/SNPRelateTutorial.html#ld-based-snp-pruning
ld_thres=0.2
snpset <- snpgdsLDpruning(genofile, ld.threshold=ld_thres,autosome.only = F,remove.monosnp=T)
#head(snpset)

# Get all selected snp id
snpset.id <- unlist(snpset)
#head(snpset.id)

#population information
sample.id = read.gdsn(index.gdsn(genofile, "sample.id"))
pop_code = c("Idaho","Alaska","Isle Royale", "Isle Royale", "Isle Royale", "Isle Royale", "Isle Royale", "Isle Royale","Isle Royale","Wyoming","Minnesota", "Minnesota", "Minnesota", "Minnesota", "Minnesota", "Minnesota", "Minnesota", "Minnesota", "Minnesota","Vermont","Sweden")


# for subsetting - to use, enter in "sample.id"
IR_samps <- c("IR3925" ,"IR3927" ,"IR3928", "IR3929", "IR3930", "IR3931", "IR3934")
MN_samps <- c("MN15","MN178","MN31","MN41","MN54","MN72","MN76","MN92","MN96")
NA_samps <- c("C06",  "HM2013", "IR3925" ,"IR3927" ,"IR3928", "IR3929", "IR3930", "IR3931", "IR3934", "JC2001", "MN15",   "MN178",  "MN31","MN41","MN54","MN72","MN76", "MN92", "MN96", "R199")




########### Relationship inference Using KING method of moments (all pops together) ########
# this approach might be preferable since it accounts for population structure 
# need to LD prune
# seems to be impacted a fair amount by MAF but not much by missing rate or monosnp
# negative kinship coefficients should be truncated to 0 (see Manichaikul et al 2010)
ibd.robust <- snpgdsIBDKING(genofile,autosome.only = F,remove.monosnp = T,missing.rate = 0.25, maf=0.05,snp.id=snpset.id, sample.id = NA_samps ) 

dat <- snpgdsIBDSelection(ibd.robust)
head(dat)

plot(dat$IBS0, dat$kinship, xlab="Proportion of Zero IBS",
     ylab="Estimated Kinship Coefficient (KING-robust)")

plot(dat$kinship, ylim = c(0,0.5))

# should replace all negative values with 0
dat$kinship[dat$kinship<0] <- 0

# plot kinship pairs
setwd("/Users/christopherkyriazis/Documents/UCLA/Moose/Analysis/SNPrelate/Plots/")

png(paste(genofile,"_kinship_KING.png",sep=""),width=10, height=8, units="in", res=600)

p2 <- ggplot(dat,aes(x=ID1,y=ID2,fill=kinship))+
  geom_tile()

p2

dev.off()


(0.230998168+0.237115732)/2

######### Estimate IBD coefficients (Estimating IBD Using PLINK method of moments (MoM))
# assumes no pop structure so need to separate by pop
ibd <- snpgdsIBDMoM(genofile,snp.id=snpset.id, sample.id=sample.id,
                    maf=0.1, missing.rate=0.25, num.thread=2, autosome.only = F)


# Make a data.frame
ibd.coeff <- snpgdsIBDSelection(ibd)
head(ibd.coeff)

plot(ibd.coeff$kinship)

# k0 is the prb of sharing 0 ibd; k1 is prb of sharing 1 ibd (100% ibd?) (expect diagonal? why?)
p1 <- plot(ibd.coeff$k0, ibd.coeff$k1, xlim=c(0,1), ylim=c(0,1),
           xlab="k0", ylab="k1")
lines(c(0,1), c(1,0), col="red", lty=2)
p1
# plot kinship pairs 
p2 <- ggplot(ibd.coeff,aes(x=ID1,y=ID2,fill=kinship))+
  geom_tile()

p2










########### IBS ################

ibs <- snpgdsIBS(genofile, num.thread=2, autosome.only = F)

library(gplots)

sample.id = read.gdsn(index.gdsn(genofile, "sample.id"))

png("IBS_SNPrelate_20180926.png", width=6, height=5, units="in", res=600)

heatmap.2(1-ibs$ibs,Rowv=F,Colv=F,trace ="none", main= "IBS heatmap", cellnote=round(ibs$ibs,3),
          notecol='black', density.info='none', labRow=sample.id, labCol = sample.id, key=F, cexRow=0.9, cexCol=0.9)

dev.off()


## Hierarchical clustering based on IBS results

hc <- snpgdsHCluster(ibs, sample.id=sample.id)
rv <- snpgdsCutTree(hc)
rv


setwd("/Users/christopherkyriazis/Documents/UCLA/Moose/Analysis/SNPrelate/Plots/")
pdf("IBS_tree_21moose.pdf", width=5, height=4)

plot(rv$dendrogram, main="", ylab="Individual dissimilarity", col=5, edgePar = list(lwd=2),leaflab = "none")

dev.off()



snpgdsDrawTree(rv, main = "Hierarchical clustering based on IBS", edgePar=list(col=rgb(0.5,0.5,0.5, 0.75)))
               
               


######### Inbreeding coefficeints ##########


AF <- snpgdsSNPRateFreq(genofile)
g <- read.gdsn(index.gdsn(genofile, "genotype"), start=c(1,1), count=c(-1,1))

snpgdsIndInbCoef(g, AF$AlleleFreq, method="mom.weir")
snpgdsIndInbCoef(g, AF$AlleleFreq, method="mom.visscher")
snpgdsIndInbCoef(g, AF$AlleleFreq, method="mle")



rv <- snpgdsIndInb(genofile, method="mom.visscher", remove.monosnp = T, autosome.only = F, missing.rate = 0.25, maf=0.05)
plot(rv$inbreeding)








#close gds file
snpgdsClose(genofile)


