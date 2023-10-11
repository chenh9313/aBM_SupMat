#Author: Huan Chen
#Date: 10-2023

#! /bin/R

# load packages
library(tidyverse)
# read in the gff
list1 <- list("Chr1","Chr2","Chr3","Chr4","Chr5","Chr6","Chr7","Chr8","Chr9","Chr10")
for (j in list1){
print(j)
gff <-  read_tsv(paste(j,".gff3",sep=""), col_names = FALSE)
gff
# subset and clear up the gff - add names
colnames(gff) <- c("chr", "source", "feature", "start", "end", "score",
                   "strand", "frame", "attribute")
# select genes only
new_gff <- gff %>% filter(feature == "gene")
# arrange the gff
new_gff <- new_gff %>% arrange(start, end)
# make a gene mid point variable
new_gff <- new_gff %>% mutate(mid = start + (end-start)/2)
new_gff

Aim_bac <- read_tsv(paste(j,"_modern_vs_ancient_positiveSelection_xpehh6.tsv",sep=""))
Aim_bac
dim(Aim_bac)
hits <- Aim_bac %>% arrange(desc(LOGPVALUE)) %>% top_n(nrow(Aim_bac))
hits
# find the nearest genes to our highest hit
for (i in 1:nrow(Aim_bac)) {
  x <- hits$POSITION[i] #I will changed here to choose differnt snp
  print(x)
  # find hits closest to genes
  new_gff %>% mutate(hit_dist = abs(mid - x)) %>% arrange(hit_dist)
  # find hits within 100 Kb
  gene_hits <- new_gff %>% mutate(hit_dist = abs(mid - x)) %>% arrange(hit_dist) %>% filter(hit_dist < 5000)
  gene_hits
  # what are these genes?
  gene_hits <- gene_hits %>% select(chr, start,end, attribute,hit_dist)
  # separate out the attribute column
  target_genes <- gene_hits %>% pull(attribute)
  target_genes
  write.table(target_genes,paste0("K5_",j,"_target_genes",i,".txt"))
}

