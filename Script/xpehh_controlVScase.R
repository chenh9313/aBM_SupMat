#Author: Huan Chen
#Date: 10-2023

#! /bin/R

rm(list = ls())
library(rehh)
library(tidyverse)
library(qqman)

chrs <- list("1","2","3","4","5","6","7","8","9","10")
for(i in chrs) {
  # haplotype file name for each chromosome
  hap_file = paste("hap_chr_", i, ".modern", sep = "")
  
  # create internal representation
  hh_modern <- data2haplohh(hap_file = "modern.vcf",
                        polarize_vcf = FALSE, min_perc_geno.mrk = 3,
                        chr.name = i)
  # perform scan on a single chromosome (calculate iHH values)
  scan <- scan_hh(hh_modern)
  # concatenate chromosome-wise data frames to
  # a data frame for the whole genome
  # (more efficient ways certainly exist...)
  if (i == "1") {
    wgscan.modern <- scan
  } else {
    wgscan.modern <- rbind(wgscan.modern, scan)
  }
}
# calculate genome-wide iHS values
wgscan.ihs.modern <- ihh2ihs(wgscan.modern)
head(wgscan.ihs.modern$ihs)
head(wgscan.ihs.modern$frequency.class)
freqbinplot(wgscan.ihs.modern)

for(i in chrs) {
  # haplotype file name for each chromosome
  hap_file = paste("hap_chr_", i, ".ancient", sep = "")
  
  # create internal representation
  hh_ancient <- data2haplohh(hap_file = "ancient.vcf",
                              polarize_vcf = FALSE, min_perc_geno.mrk = 12.5,
                              chr.name = i)
  # perform scan on a single chromosome (calculate iHH values)
  scan <- scan_hh(hh_ancient)
  # concatenate chromosome-wise data frames to
  # a data frame for the whole genome
  # (more efficient ways certainly exist...)
  if (i == "1") {
    wgscan.ancient <- scan
  } else {
    wgscan.ancient <- rbind(wgscan.ancient, scan)
  }
}
wgscan.ihs.ancient <- ihh2ihs(wgscan.ancient)
head(wgscan.ihs.ancient$ihs)
head(wgscan.ihs.ancient$frequency.class)
freqbinplot(wgscan.ihs.ancient)

rsb.modern_ancient <- ines2rsb(scan_pop1 = wgscan.modern,
                            scan_pop2 = wgscan.ancient,
                            popname1 = "modern",
                            popname2 = "ancient")
head(rsb.modern_ancient)
#ies2xpehh 
xpehh.modern_ancient <- ies2xpehh(scan_pop1 = wgscan.modern,
                                  scan_pop2 = wgscan.ancient,
                                  popname1 = "modern",
                                  popname2 = "ancient")
head(xpehh.modern_ancient)

#RSB vs XPEHH
plot(rsb.modern_ancient[, "RSB_modern_ancient"],
     xpehh.modern_ancient[, "XPEHH_modern_ancient"],
     xlab = "Rsb",
     ylab = "XP-EHH",
     pch = ".", cex = 3,
     xlim = c(-7.5, 7.5),
     ylim = c(-7.5, 7.5))
# add dashed diagonal
abline(a = 0, b = 1, lty = 5)
# add red circle for marker with name "F1205400"
#points(rsb.ancient_modern["2523", "RSB_ancient_modern"],
       #xpehh.ancient_modern["2523", "XPEHH_ancient_modern"],
       #col = "red",
       #pch = 19)

head(xpehh.modern_ancient)
ggplot(xpehh.modern_ancient, aes(POSITION, XPEHH_modern_ancient)) + geom_point()
ggplot(xpehh.modern_ancient, aes(POSITION, LOGPVALUE)) + geom_point()

qq(10**(-xpehh.modern_ancient$LOGPVALUE), main="Q-Q plot of p-value modern_ancient", 
   xlim=c(0,10), ylim=c(0,15), pch=19, col = "blue4", cex=1, las=1)

as.data.frame(table(xpehh.modern_ancient$CHR))

#select candidate genes
cr.modern_ancient <- calc_candidate_regions(xpehh.modern_ancient,
                                         threshold = 2,
                                         pval = TRUE,
                                         window_size = 1E6,
                                         overlap = 1E5,
                                         min_n_extr_mrk = 2)
cr.modern_ancient

manhattanplot(xpehh.modern_ancient,main = "modern vs ancient")
write_tsv(xpehh.modern_ancient,file="xpehh.modern_vs_ancient.tsv")

manhattanplot(xpehh.modern_ancient,
              pval = TRUE,
              threshold = 6)

manhattanplot(xpehh.modern_ancient, 
              pval = TRUE,
              threshold = 6, 
              cr = cr.modern_ancient,
              inset = 1E+7,
              resolution = c(200000, 0.05),
              cex.axis = 1)
ihs <- xpehh.modern_ancient$XPEHH_modern_ancient

wgscan.modern_ancient.ihs.qqman <- data.frame(
  CHR = as.integer(factor(xpehh.modern_ancient$CHR, 
                          levels = unique(xpehh.modern_ancient$CHR))),# chromosomes as integers
  BP = xpehh.modern_ancient$POSITION,         # base pairs
  P = 10**(-xpehh.modern_ancient$LOGPVALUE),  # transform back to p-values
  SNP = row.names(xpehh.modern_ancient)       # SNP names
)
pdf(file="manhattan_modern_vs_ancient.pdf")
qqman::manhattan(wgscan.modern_ancient.ihs.qqman,
                 col = c("red","green"),
                 chrlabs = unique(xpehh.modern_ancient$CHR),
                 suggestiveline = 2,
                 genomewideline = F,
                 annotatePval = 0.01,
                 ylim=c(0,12),
                 cex.axis = 1.2)
dev.off()




