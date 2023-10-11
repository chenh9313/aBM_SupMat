#Author: Huan Chen
#Date: 10-2023

#! /bin/sh

#Chr1:XPCLR_score == 1.167156
xpclr_data <- read.csv("top1precent_Chr1_out.xpclr.txt", sep = " ")
plot1 <- ggplot(xpclr_data, aes(x = physical_pos, y = XPCLR_score)) +
  geom_point(color = ifelse(xpclr_data$XPCLR_score == 1.167156, "green", "grey"),
             size = ifelse(xpclr_data$XPCLR_score %in% c(1.167156), 3, 1)) +
  theme_minimal() + guides(color = FALSE) + labs(x = NULL, y = NULL, title = "Chr1") +
  scale_y_continuous(limits = c(0, 10))
plot1

#Chr2: c(0.895205, 0.671608)
xpclr_data <- read.csv("top1precent_Chr2_out.xpclr.txt", sep = " ")
plot2 <- ggplot(xpclr_data, aes(x = physical_pos, y = XPCLR_score)) +
  geom_point(color = ifelse(xpclr_data$XPCLR_score %in% c(0.895205, 0.671608), "green", "grey"),
             size = ifelse(xpclr_data$XPCLR_score %in% c(0.895205, 0.671608), 3, 1)) +
  theme_minimal() + guides(color = FALSE) + labs(x = NULL, y = NULL, title = "Chr2") +
  scale_y_continuous(limits = c(0, 10))
plot2

#Chr3: c(0.895205, 0.671608)
xpclr_data <- read.csv("top1precent_Chr3_out.xpclr.txt", sep = " ")
plot3 <- ggplot(xpclr_data, aes(x = physical_pos, y = XPCLR_score)) +
  geom_point(color = ifelse(xpclr_data$XPCLR_score %in% c(0.988146, 0.561803), "green", "grey"),
             size = ifelse(xpclr_data$XPCLR_score %in% c(0.988146, 0.561803), 3, 1)) +
  theme_minimal() + guides(color = FALSE) + labs(x = NULL, y = NULL, title = "Chr3") +
  scale_y_continuous(limits = c(0, 10))
plot3

#Chr4: NA
xpclr_data <- read.csv("top1precent_Chr4_out.xpclr.txt", sep = " ")
plot4 <- ggplot(xpclr_data, aes(x = physical_pos, y = XPCLR_score)) +
  geom_point(color = "gray") +
  scale_y_continuous(limits = c(0, 10)) +
  labs(title = "Chr4") + theme_minimal() +
  guides(color = FALSE) + labs(x = NULL, y = NULL, title = "Chr4")
plot4

#Chr5: c(0.696665,0.619823,1.047640,0.610584,0.577612,1.554466)
xpclr_data <- read.csv("top1precent_Chr5_out.xpclr.txt", sep = " ")
plot5 <- ggplot(xpclr_data, aes(x = physical_pos, y = XPCLR_score)) +
  geom_point(color = ifelse(xpclr_data$XPCLR_score %in% c(0.696665,0.619823,1.047640,0.610584,0.577612,1.554466), "green", "grey"),
             size = ifelse(xpclr_data$XPCLR_score %in% c(0.696665,0.619823,1.047640,0.610584,0.577612,1.554466), 3, 1)) +
  theme_minimal() + guides(color = FALSE) + labs(x = NULL, y = NULL, title = "Chr5") +
  scale_y_continuous(limits = c(0, 10))
plot5

#Chr6: NA
xpclr_data <- read.csv("top1precent_Chr6_out.xpclr.txt", sep = " ")
plot6 <- ggplot(xpclr_data, aes(x = physical_pos, y = XPCLR_score)) +
  geom_point(color = "grey") +
  scale_y_continuous(limits = c(0, 10)) +
  labs(title = "Chr6") + theme_minimal() +
  guides(color = FALSE) + labs(x = NULL, y = NULL, title = "Chr6")
plot6

#Chr7: c(0.561719)
xpclr_data <- read.csv("top1precent_Chr7_out.xpclr.txt", sep = " ")
plot7 <- ggplot(xpclr_data, aes(x = physical_pos, y = XPCLR_score)) +
  geom_point(color = ifelse(xpclr_data$XPCLR_score %in% c(0.561719), "green", "grey"),
             size = ifelse(xpclr_data$XPCLR_score %in% c(0.561719), 3, 1)) +
  theme_minimal() + guides(color = FALSE) + labs(x = NULL, y = NULL, title = "Chr7") +
  scale_y_continuous(limits = c(0, 10))
plot7

#Chr8: NA
xpclr_data <- read.csv("top1precent_Chr8_out.xpclr.txt", sep = " ")
plot8 <- ggplot(xpclr_data, aes(x = physical_pos, y = XPCLR_score)) +
  geom_point(color = "gray") +
  scale_y_continuous(limits = c(0, 10)) +
  labs(title = "Chr8") + theme_minimal() +
  guides(color = FALSE) + labs(x = NULL, y = NULL, title = "Chr8")
plot8

#Chr9: c(0.695338)
xpclr_data <- read.csv("top1precent_Chr9_out.xpclr.txt", sep = " ")
plot9 <- ggplot(xpclr_data, aes(x = physical_pos, y = XPCLR_score)) +
  geom_point(color = ifelse(xpclr_data$XPCLR_score %in% c(0.695338), "green", "grey"),
             size = ifelse(xpclr_data$XPCLR_score %in% c(0.695338), 3, 1)) +
  theme_minimal() + guides(color = FALSE) + labs(x = NULL, y = NULL, title = "Chr9") +
  scale_y_continuous(limits = c(0, 10))
plot9

#Chr10: c(0.589311,0.726437,0.837458,0.547309)
xpclr_data <- read.csv("top1precent_Chr10_out.xpclr.txt", sep = " ")
plot10 <- ggplot(xpclr_data, aes(x = physical_pos, y = XPCLR_score)) +
  geom_point(color = ifelse(xpclr_data$XPCLR_score %in% c(0.589311,0.726437,0.837458,0.547309), "green", "grey"),
             size = ifelse(xpclr_data$XPCLR_score %in% c(0.589311,0.726437,0.837458,0.547309), 3, 1)) +
  theme_minimal() + guides(color = FALSE) + labs(x = NULL, y = NULL, title = "Chr10") +
  scale_y_continuous(limits = c(0, 10))
plot10

# Combine the plots using the patchwork package
final_plot <- plot1 + plot2 + plot3 + plot4 + plot5 + plot6 + plot7 + plot8 + plot9 + plot10 + plot_layout(ncol = 10)
final_plot



