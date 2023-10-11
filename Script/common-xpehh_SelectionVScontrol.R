#Author: Huan Chen
#Date: 10-2023

#! /bin/R

rm(list = ls())
library(rehh)
library(tidyverse)
library(qqman)

xpehh.modern_ancient <- read.csv("xpehh.modern_vs_ancient_positiveSelection.tsv", sep = "\t")
head(xpehh.modern_ancient)
# create new data frame
wgscan.modern_ancient.ihs.qqman <- data.frame(
  CHR = as.integer(factor(xpehh.modern_ancient$CHR, 
                          levels = unique(xpehh.modern_ancient$CHR))),# chromosomes as integers
  BP = xpehh.modern_ancient$POSITION,         # base pairs
  P = 10**(-xpehh.modern_ancient$LOGPVALUE),  # transform back to p-values
  SNP = row.names(xpehh.modern_ancient)       # SNP names
)
tail(wgscan.modern_ancient.ihs.qqman)
highlight_points <- c("98",
                      "856","875",
                      "957","1811","1908","1942","2101","2124",
                      "2462","2463","2464",
                      "3228","3229",
                      "3361","3361")
#point_colors <- ifelse(wgscan.modern_ancient.ihs.qqman$SNP %in% highlight_points, "red", "grey")
qqman::manhattan(wgscan.modern_ancient.ihs.qqman,
                 col = c("grey", "#808080"),
                 #chrlabs = unique(xpehh.modern_ancient$CHR),
                 chrlabs = as.character(unique(wgscan.modern_ancient.ihs.qqman$CHR)),
                 suggestiveline = 2,
                 genomewideline = F,
                 highlight = highlight_points,
                 highlightsize = 10,
                 annotatePval = 0.01,
                 ylim=c(0,12),
                 cex.axis = 1.2)



