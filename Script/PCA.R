#Author: Huan Chen
#Date: 10-2023

#! /bin/R

rm(list=ls())
library(tidyverse)
pca <- read_table("All.eigenvec", col_names = FALSE)
eigenval <- scan("All.eigenval")
Name <- read.table("Name.txt",header = T)
#add NAME in the first line
Name <- Name$NAME
Name
# sort out the pca data
# remove nuisance column
pca <- pca[,-1]
# set names
names(pca)[1] <- "ind"
names(pca)[2:ncol(pca)] <- paste0("PC", 1:(ncol(pca)-1))
names(pca)
# sort out the individual species and pops
# spp
spp <- rep(NA, length(pca$ind))
spp[grep("BM", pca$ind)] <- "BM"
spp[grep("Argentina", pca$ind)] <- "Argentina"
spp[grep("Brazil", pca$ind)] <- "Brazil"
spp[grep("Chile", pca$ind)] <- "Chile"
spp[grep("Colombia", pca$ind)] <- "Colombia"
spp[grep("Bolivia", pca$ind)] <- "Bolivia"
spp[grep("Ecuador", pca$ind)] <- "Ecuador"
spp[grep("Guatemala", pca$ind)] <- "Guatemala"
spp[grep("Honduras", pca$ind)] <- "Honduras"
spp[grep("Mexico", pca$ind)] <- "Mexico"
spp[grep("Paraguay", pca$ind)] <- "Paraguay"
spp[grep("Peru", pca$ind)] <- "Peru"
spp[grep("USA", pca$ind)] <- "USA"
spp[grep("Parviglumis", pca$ind)] <- "Parviglumis"
spp[grep("TripsacumDactyloides", pca$ind)] <- "TripsacumDactyloides"
spp[grep("mexicana", pca$ind)] <- "mexicana"

# location
loc <- rep(NA, length(pca$ind))
loc[grep("BM", pca$ind)] <- "BM"
loc[grep("Argentina", pca$ind)] <- "Argentina"
loc[grep("Brazil", pca$ind)] <- "Brazil"
loc[grep("Chile", pca$ind)] <- "Chile"
loc[grep("Colombia", pca$ind)] <- "Colombia"
loc[grep("Bolivia", pca$ind)] <- "Bolivia"
loc[grep("Ecuador", pca$ind)] <- "Ecuador"
loc[grep("Guatemala", pca$ind)] <- "Guatemala"
loc[grep("Honduras", pca$ind)] <- "Honduras"
loc[grep("Mexico", pca$ind)] <- "Mexico"
loc[grep("Paraguay", pca$ind)] <- "Paraguay"
loc[grep("Peru", pca$ind)] <- "Peru"
loc[grep("USA", pca$ind)] <- "USA"
loc[grep("Parviglumis", pca$ind)] <- "Parviglumis"
loc[grep("TripsacumDactyloides", pca$ind)] <- "TripsacumDactyloides"
loc[grep("mexicana", pca$ind)] <- "mexicana"

# combine - if you want to plot each in different colours
spp_loc <- paste0(spp, "_", loc)
spp_loc
# remake data.frame
pca <- as_tibble(data.frame(pca, spp, loc, spp_loc))
pca

# first convert to percentage variance explained
pve <- data.frame(PC = 1:20, pve = eigenval/sum(eigenval)*100)
pve
# make plot
a <- ggplot(pve, aes(PC, pve)) + geom_bar(stat = "identity")
a + ylab("Percentage variance explained") + theme_light()
# calculate the cumulative sum of the percentage variance explained
cumsum(pve$pve)

# plot pca with lable PC1 vs PC2
b <- ggplot(pca, aes(PC1, PC2, col = spp, shape = loc, label=Name)) + 
  geom_point(size = 3) + scale_shape_manual(values=seq(0,22))
b <- b + coord_equal() + theme_light()
b
b + xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)")) + ylab(paste0("PC2 (", signif(pve$pve[2], 3), "%)"))






