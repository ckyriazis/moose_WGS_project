
setwd("~/Documents/UCLA/Moose/Analysis/FST")
fst <- read.table("IR_MN_21Moose_joint_FilterB_Round1_autosomes_SNPs_PASS.weir.fst.removeNaN.txt", header=T)

head(fst)

mean(fst$WEIR_AND_COCKERHAM_FST)

median(fst$WEIR_AND_COCKERHAM_FST)

hist(fst$WEIR_AND_COCKERHAM_FST)



fst_chr1 <- fst[which(fst$CHROM == "NC_037328.1"),]
plot(fst_chr1$WEIR_AND_COCKERHAM_FST, pch = 20)
