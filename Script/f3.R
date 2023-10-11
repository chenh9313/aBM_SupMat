#Author: Huan Chen
#Date: 10-2023

#!/bin/R

library(admixr)
library(tidyverse)
library(usethis)
library(devtools)

result_f3 <- read.table("result_f3_Tripsacum.txt",header = T)
result_f3
ordered <- filter(result_f3, A == "Tripsacum", B != "Tripsacum") %>% arrange(f3) %>% .[["B"]] %>% c("Tripsacum")

p1 <- result_f3 %>%
  filter(A != B) %>%
  mutate(A = factor(A, levels = ordered),
         B = factor(B, levels = ordered)) %>%
  ggplot(aes(A, B)) + geom_tile(aes(fill = f3))
p1
