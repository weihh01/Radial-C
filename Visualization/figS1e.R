library(DESeq2)
library(sva)
library(openxlsx)
library(ggplot2)

MNase_1min_5min_20min <- read.table("insulation.bed")

countData <- as.matrix(MNase_1min_5min_20min[1:6])
colnames(countData) <- c("MNase_1min_rep1", "MNase_1min_rep2", "MNase-5min_rep1", "MNase-5min_rep2", "MNase-20min_rep1", "MNase-20min_rep2")
row_var <- apply(countData, 1, var)
nonzero_var_rows <- which(row_var != 0)

filtered_data <- countData[nonzero_var_rows,]
data <- as.data.frame(filtered_data)
gene <- t(data)


pca1 <- prcomp(gene[, -ncol(gene)], center = TRUE, scale. = TRUE)
df1 <- pca1$x # ??ȡPC score
df1 <- as.data.frame(df1)

summ1 <- summary(pca1)
xlab1 <- paste0("PC1(", round(summ1$importance[2, 1] * 100, 2), "%)")
ylab1 <- paste0("PC2(", round(summ1$importance[2, 2] * 100, 2), "%)")

name <- c("MNase_1min", "MNase_1min", "MNase_5min", "MNase_5min", "MNase_20min", "MNase_20min")
gene <- cbind(gene, name)
gene <- as.data.frame(gene)


Insulation <- ggplot(df1) +
  geom_point(aes(x = PC1, y = PC2, color = name), alpha = 0.8, size = 4, shape = 16) +
  labs(title = "Insulation score", x = xlab1, y = ylab1, color = "Condition") +
  guides(fill = "none") +
  theme_bw() +
  theme(legend.box = "horizontal",
        legend.key.size = unit(30, "pt"),
        legend.position = "right",
        panel.grid.major = element_blank(),
        plot.margin = unit(c(0.2, 0.2, 0.5, 0.5), "lines"),
        legend.text = element_text(colour = "black", size = 15),
        panel.border = element_rect(fill = NA, size = 1, color = 'black'),
        axis.title.x = element_text(colour = "black", size = 15, vjust = 0),
        axis.title.y = element_text(colour = "black", size = 15, vjust = 2),
        axis.text.x = element_text(angle = 30, hjust = 1, vjust = 1, size = 14, colour = "black"),
        axis.text.y = element_text(angle = 0, hjust = 1, vjust = 0.5, size = 14, colour = "black"),
        plot.title = element_text(colour = "black", size = 16, vjust = 0.5, hjust = 0.5),
        axis.ticks = element_line(color = "black"),
        text = element_text(size = 15, family = "sans", colour = "black")) +
  guides(color = guide_legend(override.aes = list(size = 4))) +
  labs(x = "PC1 (37.6%)", y = "PC2 (23.9%)") +
  theme(legend.title = element_blank(), legend.key = element_blank()) +
  scale_colour_manual(values = c("#386CAF", "#fc9533", "#9f79d3"),
                      breaks = c("MNase_1min", "MNase_5min", "MNase_20min"),
                      labels = c("1 min", "5 min", "20 min")) +
  theme(text = element_text(size = 20)) +
  scale_y_continuous(limits = c(-220, 210), breaks = seq(-200, 200, 200)) +
  scale_x_continuous(limits = c(-220, 210), breaks = seq(-200, 200, 200)) +
  coord_fixed(ratio = 1)


MNase_1min_rep1 <- read.table("MNase-1min_rep1.bdg")
MNase_1min_rep2 <- read.table("MNase-1min_rep2.bdg")
MNase_1min <- merge(MNase_1min_rep1, MNase_1min_rep2, by = c("V1", "V2", "V3"))

MNase_5min_rep1 <- read.table("MNase-5min_rep1.bdg")
MNase_5min_rep2 <- read.table("MNase-5min_rep2.bdg")
MNase_5min <- merge(MNase_5min_rep1, MNase_5min_rep2, by = c("V1", "V2", "V3"))

MNase_20min_rep1 <- read.table("MNase-20min_rep1.bdg")
MNase_20min_rep2 <- read.table("MNase-20min_rep2.bdg")
MNase_20min <- merge(MNase_20min_rep1, MNase_20min_rep2, by = c("V1", "V2", "V3"))

MNase_1min_5min <- merge(MNase_1min, MNase_5min, by = c("V1", "V2", "V3"))
MNase_1min_5min_20min <- merge(MNase_1min_5min, MNase_20min, by = c("V1", "V2", "V3"))

countData <- as.matrix(MNase_1min_5min_20min[4:9])
colnames(countData) <- c("MNase_1min_rep1", "MNase_1min_rep2", "MNase-5min_rep1", "MNase-5min_rep2", "MNase-20min_rep1", "MNase-20min_rep2")


row_var <- apply(countData, 1, var)

nonzero_var_rows <- which(row_var != 0)

filtered_data <- countData[nonzero_var_rows,]
data <- as.data.frame(filtered_data)
gene <- t(data)


pca1 <- prcomp(gene[, -ncol(gene)], center = TRUE, scale. = TRUE)
df1 <- pca1$x # ??ȡPC score
df1 <- as.data.frame(df1)

summ1 <- summary(pca1)
xlab1 <- paste0("PC1(", round(summ1$importance[2, 1] * 100, 2), "%)")
ylab1 <- paste0("PC2(", round(summ1$importance[2, 2] * 100, 2), "%)")

name <- c("MNase_1min", "MNase_1min", "MNase_5min", "MNase_5min", "MNase_20min", "MNase_20min")
gene <- cbind(gene, name)
gene <- as.data.frame(gene)


PC1 <- ggplot(df1) +
  geom_point(aes(x = PC1, y = PC2, color = name), alpha = 0.8, size = 4, shape = 16) +
  labs(title = "PC1 value", x = xlab1, y = ylab1, color = "Condition") +
  guides(fill = "none") +
  theme_bw() +
  theme(legend.box = "horizontal",
        legend.key.size = unit(30, "pt"),
        legend.position = "right",
        panel.grid.major = element_blank(),
        plot.margin = unit(c(0.2, 0.2, 0.5, 0.5), "lines"),
        legend.text = element_text(colour = "black", size = 15),
        panel.border = element_rect(fill = NA, size = 1, color = 'black'),
        axis.title.x = element_text(colour = "black", size = 15, vjust = 0),
        axis.title.y = element_text(colour = "black", size = 15, vjust = 2),
        axis.text.x = element_text(angle = 30, hjust = 1, vjust = 1, size = 14, colour = "black"),
        axis.text.y = element_text(angle = 0, hjust = 1, vjust = 0.5, size = 14, colour = "black"),
        plot.title = element_text(colour = "black", size = 16, vjust = 0.5, hjust = 0.5),
        axis.ticks = element_line(color = "black"),
        text = element_text(size = 15, family = "sans", colour = "black")) +
  guides(color = guide_legend(override.aes = list(size = 4))) +
  labs(x = "PC1 (54.4%)", y = "PC2 (20.0%)") +
  theme(legend.title = element_blank(), legend.key = element_blank()) +
  scale_colour_manual(values = c("#386CAF", "#fc9533", "#9f79d3"),
                      breaks = c("MNase_1min", "MNase_5min", "MNase_20min"),
                      labels = c("1 min", "5 min", "20 min")) +
  theme(text = element_text(size = 20)) +
  scale_y_continuous(limits = c(-220, 210), breaks = seq(-200, 200, 200)) +
  scale_x_continuous(limits = c(-220, 210), breaks = seq(-200, 200, 200)) +
  coord_fixed(ratio = 1)

library(ggpubr)
require(grid)
ggarrange(Insulation, PC1, ncol = 2, nrow = 1, heights = c(1:1), align = "v", common.legend = TRUE, legend = "right") +
  theme(plot.background = element_rect(fill = 'white', colour = 'white'))
