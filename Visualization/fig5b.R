library(ggplot2)
library(dplyr)
library(data.table)
library(dplyr)

setwd("G:/AI_XuLab_Data/Radial-C/figure6/6b/")
score <- fread("DMSO_TPA_allscore01.txt")
layer <- fread("DMSO_TPA_layer50.txt")
colnames(score) <- c("chrom", "start", "end", "FNR", "DMSO_rep1", "TPA_rep1", "DMSO_rep2", "TPA_rep2", "DMSO_all", "TPA_all")
colnames(layer) <- c("chrom", "start", "end", "FNR", "DMSO_rep1", "TPA_rep1", "DMSO_rep2", "TPA_rep2", "DMSO_all", "TPA_all")

score$DMSO_all <- 1 - score$DMSO_all
score$TPA_all <- 1 - score$TPA_all
score$type[score$DMSO_all - score$TPA_all > 0.04] <- "inward"
score$type[score$DMSO_all - score$TPA_all < -0.04] <- "outward"
score$type[between(score$DMSO_all - score$TPA_all, -0.04, 0.04)] <- "static"
layer$type <- score$type
layer <- layer[!is.na(layer$type),]
table(layer$type)

layer$layer_range_all <- cut(layer$DMSO_all, breaks = c(0, 1, seq(5, 50, 5)))
layer_table <- as.data.frame(table(layer[, c(11, 12)]))
layer_table$type <- factor(layer_table$type, levels = c("outward", "inward", "static"))


layer_table$layer_range_all <- factor(layer_table$layer_range_all,
                                      levels = c("(0,1]", "(1,5]", "(5,10]", "(10,15]", "(15,20]", "(20,25]", "(25,30]", "(30,35]", "(35,40]", "(40,45]", "(45,50]"),
                                      labels = c("1", "2-5", "6-10", "11-15", "16-20", "21-25", "26-30", "31-35", "36-40", "41-45", "46-50"))
ggplot(data = layer_table, aes(x = layer_range_all, y = Freq, fill = type)) +
  geom_bar(stat = "identity", position = "stack", width = 0.8) +
  labs(fill = "") +
  scale_y_continuous(expand = c(0, 0)) +
  scale_x_discrete(labels = unique(layer_table$layer_range_all)) +
  scale_fill_manual(values = c("#FF6666", "#0099CC", "#848484")) +
  theme_bw() +
  xlab("Layer") +
  ylab("Counts") +
  coord_flip() +
  ggtitle("") +
  theme(axis.text.x = element_text(color = "black", size = 15, angle = 0, hjust = 0.5, vjust = 0.6, colour = "black"),
        axis.text.y = element_text(color = "black", size = 15, angle = 0, hjust = 1, colour = "black"),
        axis.line.y = element_blank(),
        axis.ticks.x = element_line(color = "black", linewidth = 0.5),
        axis.ticks.y = element_blank(),
        axis.title.y = element_text(size = 15, hjust = 0.5, vjust = 1),
        axis.title.x = element_text(size = 15, hjust = 0.5, vjust = 0.5),
        legend.text = element_text(colour = "black", size = 15),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_blank(),
        legend.position = c(0.7, 0.7),
        legend.title = element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(color = "black", size = 0.5),
        plot.margin = unit(c(0.1, 0.1, 0.1, 0.1), 'cm'))

ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig6b.png", width = 6, height = 3.5, dpi = 600)