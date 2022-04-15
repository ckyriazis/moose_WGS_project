
####### plot annotated genotype proportions #######


### deleterious
homRef_del <- c(3970, 4053, 4213, 4128, 4075, 4167, 4130, 4203, 4113, 3960, 4003, 3998, 3945, 4025, 3984, 3984, 3928, 3985, 4012, 4081, 3669)
het_del <-c(380, 1001, 919, 989, 1009, 1039, 1017, 955, 1014, 709, 1202, 1243, 1160, 1191, 1238, 1142, 1256, 1240, 1199, 620, 1736)
homAlt_del <- c(780, 982, 1190, 1139, 1119, 1111, 1133, 1168, 1136, 1001, 1055, 1034, 1058, 1055, 1053, 1049, 1000, 1046, 1072, 1018, 890)
del_muts <- rbind(homRef_del,het_del,homAlt_del)
del_geno_props <- del_muts/colSums(del_muts)
del_der_allele_count <- del_muts[2,]+del_muts[3,]*2


### tolerated
homRef_tol <-c(7996, 8191, 8564, 8448, 8337, 8455, 8485, 8535, 8474, 7937, 8151, 8199, 8078, 8127, 8242, 8194, 8068, 8166, 8200, 8201, 7539)
het_tol <- c(852, 2220, 1972, 2161, 2033, 2188, 2125, 2070, 2108, 1672, 2684, 2678, 2616, 2630, 2589, 2612, 2828, 2706, 2638, 1356, 3737)
homAlt_tol <- c(2642, 3690, 4253, 4145, 4137, 4188, 4095, 4185, 4087, 3481, 3867, 3760, 3864, 3911, 3956, 3744, 3671, 3859, 3892, 3452, 3439)
tol_muts <- rbind(homRef_tol,het_tol,homAlt_tol)
tol_geno_props <- tol_muts/colSums(tol_muts)
tol_der_allele_count <- tol_muts[2,]+tol_muts[3,]*2


### synonymous
homRef_syn <-c(12901, 13113, 13898, 13844, 13207, 13766, 13711, 13871, 13756, 12860, 13184, 13278, 12966, 13238, 13272, 13199, 13149, 13286, 13241, 13494, 12046)
het_syn <-c(1594, 3922, 3165, 3259, 3694, 3492, 3492, 3285, 3350, 2725, 4344, 4313, 4196, 4157, 4305, 4141, 4436, 4316, 4263, 2216, 6612)
homAlt_syn <-c(5849, 7971, 8991, 8850, 8582, 8780, 8696, 8855, 8675, 7688, 8291, 8177, 8301, 8366, 8365, 8175, 8029, 8287, 8404, 7550, 7309)
syn_muts <- rbind(homRef_syn,het_syn,homAlt_syn)
syn_geno_props <- syn_muts/colSums(syn_muts)
syn_der_allele_count <- syn_muts[2,]+syn_muts[3,]*2


### LOF
homRef_lof<-c(339, 360, 360, 347, 342, 346, 362, 350, 356, 328, 346, 333, 346, 364, 351, 338, 336, 348, 342, 357, 288)
het_lof <-c(36, 81, 91, 92, 92, 106, 89, 107, 91, 71, 124, 134, 105, 108, 118, 123, 130, 111, 123, 47, 167)
homAlt_lof <-c(77, 114, 124, 130, 123, 128, 121, 122, 119, 94, 102, 100, 115, 109, 108, 108, 103, 112, 107, 103, 106)
lof_muts <- rbind(homRef_lof,het_lof,homAlt_lof)
lof_geno_props <- lof_muts/colSums(lof_muts)
lof_der_allele_count <- lof_muts[2,]+lof_muts[3,]*2



### damaging
homRef_damaging <- homRef_lof+homRef_del
het_damaging <- het_lof+het_del
homAlt_damaging <- homAlt_del+homAlt_lof
damaging_muts <- rbind(homRef_damaging,het_damaging,homAlt_damaging)
damaging_geno_props <- damaging_muts/colSums(damaging_muts)
damaging_allele_count <- lof_der_allele_count+del_der_allele_count


### benign
homRef_benign <- homRef_syn+homRef_tol
het_benign <- het_syn+het_tol
homAlt_benign <- homAlt_tol+homAlt_syn
benign_muts <- rbind(homRef_benign,het_benign,homAlt_benign)
benign_geno_props <- benign_muts/colSums(benign_muts)
benign_allele_count <- syn_der_allele_count+tol_der_allele_count



### % changes

# damaging hets
1 - mean(damaging_muts[2,3:9])/mean(damaging_muts[2,11:19])

# benign hets
1 - mean(benign_muts[2,3:9])/mean(benign_muts[2,11:19])

# damaging homozygotes
1 - mean(damaging_muts[3,3:9])/mean(damaging_muts[3,11:19])

# benign homozygotes
1 - mean(benign_muts[3,3:9])/mean(benign_muts[3,11:19])


### Plot damaging and benign
setwd("~/Documents/UCLA/Moose/Analysis/count_variants/Plots")
pdf("moose_genotype_proportions_21Moose_round1.pdf", width=5, height=7)

par(mfrow=c(3,2), mar=c(3,4,2,1))

cex=1.3

names <- c("MN","IR")
colors <- c("#009E73","#56B4E9")

# heterozygotes
bp<-barplot(c(mean(damaging_muts[2,11:19]),mean(damaging_muts[2,3:9])), names = names, main = "Damaging heterozygotes", col = colors, ylab="genotype counts", ylim=c(0,1800), cex.lab  = 1.4)
points(x=rep(bp[1,1], times=length(damaging_muts[2,11:19])), y=damaging_muts[2,11:19], pch =18, cex=cex)
points(x=rep(bp[2,1], times=length(damaging_muts[2,3:9])), y=damaging_muts[2,3:9], pch =18, cex=cex)

bp<-barplot(c(mean(benign_muts[2,11:19]),mean(benign_muts[2,3:9])), names = names, main = "Benign heterozygotes", col = colors, ylab="", ylim=c(0,7500))
points(x=rep(bp[1,1], times=length(benign_muts[2,11:19])), y=benign_muts[2,11:19], pch =18, cex=cex)
points(x=rep(bp[2,1], times=length(benign_muts[2,3:9])), y=benign_muts[2,3:9], pch =18, cex=cex)

# homozygotes
bp<-barplot(c(mean(damaging_muts[3,11:19]),mean(damaging_muts[3,3:9])),names = names, main = "Damaging homozygotes",col = colors, ylim=c(0,1800), ylab="genotype counts", cex.lab  = 1.4, cex.lab  = 1.4)
points(x=rep(bp[1,1], times=length(damaging_muts[3,11:19])), y=damaging_muts[3,11:19], pch =18, cex=cex)
points(x=rep(bp[2,1], times=length(damaging_muts[3,3:9])), y=damaging_muts[3,3:9], pch =18, cex=cex)

bp<-barplot(c(mean(benign_muts[3,11:19]),mean(benign_muts[3,3:9])),names = names, main = "Benign homozygotes",col = colors, ylim=c(0,15000))
points(x=rep(bp[1,1], times=length(benign_muts[3,11:19])), y=benign_muts[3,11:19], pch =18, cex=cex)
points(x=rep(bp[2,1], times=length(benign_muts[3,3:9])), y=benign_muts[3,3:9], pch =18, cex=cex)

# derived allele count

bp<-barplot(c(mean(damaging_allele_count[11:19]),mean(damaging_allele_count[3:9])),names = names, main = "Damaging alleles",col = colors, ylim=c(0,4000), ylab="allele counts", cex.lab  = 1.4)
points(x=rep(bp[1,1], times=length(damaging_allele_count[11:19])), y=damaging_allele_count[11:19], pch =18, cex=cex)
points(x=rep(bp[2,1], times=length(damaging_allele_count[3:9])), y=damaging_allele_count[3:9], pch =18, cex=cex)

bp<-barplot(c(mean(benign_allele_count[11:19]),mean(benign_allele_count[3:9])),names = names, main = "Benign alleles",col = colors, ylim=c(0,35000))
points(x=rep(bp[1,1], times=length(benign_allele_count[11:19])), y=benign_allele_count[11:19], pch =18, cex=cex)
points(x=rep(bp[2,1], times=length(benign_allele_count[3:9])), y=benign_allele_count[3:9], pch =18, cex=cex)

dev.off()













#### plot DEL, SYN, LOF, TOL
setwd("~/Documents/UCLA/Moose/Analysis/count_variants/Plots")
png("moose_genotype_proportions_21Moose_round1.png", width=5, height=8, units="in", res=600)

par(mfrow=c(4,2), mar=c(4,4,2,2))
# tolerated
bp<-barplot(c(mean(tol_geno_props[2,3:9]),mean(tol_geno_props[2,11:19])), names = c("IR","MN"), main = "Het. tolerated", col = c("#56B4E9","#009E73"), ylab="genotype proportion", ylim=c(0,0.35))
points(x=rep(bp[1,1], times=length(tol_geno_props[2,3:9])), y=tol_geno_props[2,3:9], pch =15, cex=0.5)
points(x=rep(bp[2,1], times=length(tol_geno_props[2,11:19])), y=tol_geno_props[2,11:19], pch =15, cex=0.5)

bp<-barplot(c(mean(tol_geno_props[3,3:9]),mean(tol_geno_props[3,11:19])),names = c("IR","MN"), main = "homDer tolerated",col = c("#56B4E9","#009E73"), ylim=c(0,0.35))
points(x=rep(bp[1,1], times=length(tol_geno_props[3,3:9])), y=tol_geno_props[3,3:9], pch =15, cex=0.5)
points(x=rep(bp[2,1], times=length(tol_geno_props[3,11:19])), y=tol_geno_props[3,11:19], pch =15, cex=0.5)




# synonymous
bp<-barplot(c(mean(syn_geno_props[2,3:9]),mean(syn_geno_props[2,11:19])), names = c("IR","MN"), main = "Het. syn", col = c("#56B4E9","#009E73"), ylab="genotype proportion", ylim=c(0,0.35))
points(x=rep(bp[1,1], times=length(syn_geno_props[2,3:9])), y=syn_geno_props[2,3:9], pch =15, cex=0.5)
points(x=rep(bp[2,1], times=length(syn_geno_props[2,11:19])), y=syn_geno_props[2,11:19], pch =15, cex=0.5)

bp<-barplot(c(mean(syn_geno_props[3,3:9]),mean(syn_geno_props[3,11:19])),names = c("IR","MN"), main = "homDer syn",col = c("#56B4E9","#009E73"), ylim=c(0,0.35))
points(x=rep(bp[1,1], times=length(syn_geno_props[3,3:9])), y=syn_geno_props[3,3:9], pch =15, cex=0.5)
points(x=rep(bp[2,1], times=length(syn_geno_props[3,11:19])), y=syn_geno_props[3,11:19], pch =15, cex=0.5)



# deleterious
bp<-barplot(c(mean(del_geno_props[2,3:9]),mean(del_geno_props[2,11:19])), names = c("IR","MN"), main = "Het. del", col = c("#56B4E9","#009E73"), ylab="genotype proportion", ylim=c(0,0.35))
points(x=rep(bp[1,1], times=length(del_geno_props[2,3:9])), y=del_geno_props[2,3:9], pch =15, cex=0.5)
points(x=rep(bp[2,1], times=length(del_geno_props[2,11:19])), y=del_geno_props[2,11:19], pch =15, cex=0.5)

bp<-barplot(c(mean(del_geno_props[3,3:9]),mean(del_geno_props[3,11:19])),names = c("IR","MN"), main = "homDer del",col = c("#56B4E9","#009E73"), ylim=c(0,0.35))
points(x=rep(bp[1,1], times=length(del_geno_props[3,3:9])), y=del_geno_props[3,3:9], pch =15, cex=0.5)
points(x=rep(bp[2,1], times=length(del_geno_props[3,11:19])), y=del_geno_props[3,11:19], pch =15, cex=0.5)

# LOF
bp<-barplot(c(mean(lof_geno_props[2,3:9]),mean(lof_geno_props[2,11:19])), names = c("IR","MN"), main = "Het. lof", col = c("#56B4E9","#009E73"), ylab="genotype proportion", ylim=c(0,0.35))
points(x=rep(bp[1,1], times=length(lof_geno_props[2,3:9])), y=lof_geno_props[2,3:9], pch =15, cex=0.5)
points(x=rep(bp[2,1], times=length(lof_geno_props[2,11:19])), y=lof_geno_props[2,11:19], pch =15, cex=0.5)

bp<-barplot(c(mean(lof_geno_props[3,3:9]),mean(lof_geno_props[3,11:19])),names = c("IR","MN"), main = "homDer lof",col = c("#56B4E9","#009E73"), ylim=c(0,0.35))
points(x=rep(bp[1,1], times=length(lof_geno_props[3,3:9])), y=lof_geno_props[3,3:9], pch =15, cex=0.5)
points(x=rep(bp[2,1], times=length(lof_geno_props[3,11:19])), y=lof_geno_props[3,11:19], pch =15, cex=0.5)

dev.off()

