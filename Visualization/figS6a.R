library(DESeq2)
library(sva)
library(openxlsx)
library(ggplot2)

#1min----
setwd('G:/AI_XuLab_Data/Radial-C/figureS6/s6a/1min/')
countData <- read.xlsx("loop_1min_all.xlsx")
colnames(countData) <- c("DMSO_rep1", "DMSO_rep2", "TPA_rep1", "TPA_rep2")
countData <- na.omit(countData)
row_var <- apply(countData, 1, var)
nonzero_var_rows <- which(row_var != 0)
filtered_data <- countData[nonzero_var_rows,]
data <- as.data.frame(filtered_data)
gene <- t(data)
pca1 <- prcomp(gene[, -ncol(gene)], center = TRUE, scale. = TRUE)
df1 <- pca1$x
df1 <- as.data.frame(df1)
summ1 <- summary(pca1)
xlab1 <- paste0("PC1(", round(summ1$importance[2, 1] * 100, 2), "%)")
ylab1 <- paste0("PC2(", round(summ1$importance[2, 2] * 100, 2), "%)")
name <- c("DMSO", "DMSO", "TPA", "TPA")
gene <- cbind(gene, name)
gene <- as.data.frame(gene)
ggplot(data = df1, aes(x = PC1, y = PC2, color = gene$name)) +
  geom_point(size = 3.5) +
  labs(x = xlab1, y = ylab1, color = "Condition") +
  guides(fill = "none") +
  theme_bw() +
  theme(legend.box = "horizontal",
        legend.key.size = unit(30, "pt"),
        legend.position = "right",
        panel.grid.major = element_blank(),
        plot.margin = unit(c(0.2, 0.2, 0.5, 0.5), "lines"),
        legend.text = element_text(colour = "black", size = 14),
        panel.border = element_rect(fill = NA, size = 1, color = 'black'),
        axis.title.x = element_text(colour = "black", size = 15, vjust = 0),
        axis.title.y = element_text(colour = "black", size = 15, vjust = 2),
        axis.text.x = element_text(angle = 0, hjust = 0.5, vjust = 1, size = 14, colour = "black"),
        axis.text.y = element_text(angle = 0, hjust = 1, vjust = 0.5, size = 14, colour = "black"),
        plot.title = element_text(colour = "black", size = 16, vjust = 0.5, hjust = 0.5),
        axis.ticks = element_line(color = "black"),
        text = element_text(size = 15, family = "sans", colour = "black")) +
  guides(color = guide_legend(override.aes = list(size = 3.5))) +
  labs(title = "1 min", x = "PC1 (55.7%)", y = "PC2 (24.8%)") +
  theme(legend.title = element_blank(), legend.key = element_blank()) +
  scale_fill_manual(values = c("#fc9533", "#386CAF")) +
  scale_colour_manual(values = c("#fc9533", "#386CAF"),
                      breaks = c("DMSO", "TPA"),
                      labels = c("DMSO", "TPA")) +
  theme(text = element_text(size = 20)) +
  scale_y_continuous(limits = c(-15, 15), breaks = seq(-20, 20, 10)) +
  scale_x_continuous(limits = c(-15, 15), breaks = seq(-20, 20, 10)) +
  coord_fixed(ratio = 1)
ggsave("G:/AI_XuLab_Data/Radial-C/figs6a_1min.pdf", width = 4.2, height = 3.2, dpi = 600, device = cairo_pdf)

#5min----
setwd('G:/AI_XuLab_Data/Radial-C/figureS6/s6a/5min/')
countData <- read.xlsx("loop_5min_all.xlsx")
colnames(countData) <- c("DMSO_rep1", "DMSO_rep2", "TPA_rep1", "TPA_rep2")
countData <- na.omit(countData)
row_var <- apply(countData, 1, var)
nonzero_var_rows <- which(row_var != 0)
filtered_data <- countData[nonzero_var_rows,]
data <- as.data.frame(filtered_data)
gene <- t(data)
pca1 <- prcomp(gene[, -ncol(gene)], center = TRUE, scale. = TRUE)
df1 <- pca1$x
df1 <- as.data.frame(df1)
summ1 <- summary(pca1)
xlab1 <- paste0("PC1(", round(summ1$importance[2, 1] * 100, 2), "%)")
ylab1 <- paste0("PC2(", round(summ1$importance[2, 2] * 100, 2), "%)")
name <- c("DMSO", "DMSO", "TPA", "TPA")
gene <- cbind(gene, name)
gene <- as.data.frame(gene)
ggplot(data = df1, aes(x = PC1, y = PC2, color = gene$name)) +
  geom_point(size = 3.5) +
  labs(x = xlab1, y = ylab1, color = "Condition") +
  guides(fill = "none") +
  theme_bw() +
  theme(legend.box = "horizontal",
        legend.key.size = unit(30, "pt"),
        legend.position = "right",
        panel.grid.major = element_blank(),
        plot.margin = unit(c(0.2, 0.2, 0.5, 0.5), "lines"),
        legend.text = element_text(colour = "black", size = 14),
        panel.border = element_rect(fill = NA, size = 1, color = 'black'),
        axis.title.x = element_text(colour = "black", size = 15, vjust = 0),
        axis.title.y = element_text(colour = "black", size = 15, vjust = 2),
        axis.text.x = element_text(angle = 0, hjust = 0.5, vjust = 1, size = 14, colour = "black"),
        axis.text.y = element_text(angle = 0, hjust = 1, vjust = 0.5, size = 14, colour = "black"),
        plot.title = element_text(colour = "black", size = 16, vjust = 0.5, hjust = 0.5),
        axis.ticks = element_line(color = "black"),
        text = element_text(size = 15, family = "sans", colour = "black")) +
  guides(color = guide_legend(override.aes = list(size = 3.5))) +
  labs(title = "5 min", x = "PC1 (67.4%)", y = "PC2 (17.8%)") +
  theme(legend.title = element_blank(), legend.key = element_blank()) +

  scale_fill_manual(values = c("#fc9533", "#386CAF")) +
  scale_colour_manual(values = c("#fc9533", "#386CAF"),
                      breaks = c("DMSO", "TPA"),
                      labels = c("DMSO", "TPA")) +
  theme(text = element_text(size = 20)) +
  scale_y_continuous(limits = c(-45, 45), breaks = seq(-50, 50, 20)) +
  scale_x_continuous(limits = c(-45, 45), breaks = seq(-50, 50, 20)) +
  coord_fixed(ratio = 1)
ggsave("G:/AI_XuLab_Data/Radial-C/figs6a_5min.pdf", width = 4.2, height = 3.2, dpi = 600, device = cairo_pdf)

#20min----
setwd('G:/AI_XuLab_Data/Radial-C/figureS6/s6a/20min/')
countData <- read.xlsx("loop_20min_all.xlsx")
colnames(countData) <- c("DMSO_rep1", "DMSO_rep2", "TPA_rep1", "TPA_rep2")
countData <- na.omit(countData)
row_var <- apply(countData, 1, var)
nonzero_var_rows <- which(row_var != 0)
filtered_data <- countData[nonzero_var_rows,]
data <- as.data.frame(filtered_data)
gene <- t(data)
pca1 <- prcomp(gene[, -ncol(gene)], center = TRUE, scale. = TRUE)
df1 <- pca1$x
df1 <- as.data.frame(df1)
summ1 <- summary(pca1)
xlab1 <- paste0("PC1(", round(summ1$importance[2, 1] * 100, 2), "%)")
ylab1 <- paste0("PC2(", round(summ1$importance[2, 2] * 100, 2), "%)")
name <- c("DMSO", "DMSO", "TPA", "TPA")
gene <- cbind(gene, name)
gene <- as.data.frame(gene)
ggplot(data = df1, aes(x = PC1, y = PC2, color = gene$name)) +
  geom_point(size = 3.5) +
  labs(x = xlab1, y = ylab1, color = "Condition") +
  guides(fill = "none") +
  scale_y_continuous(limits = c(-15, 15)) +
  scale_x_continuous(limits = c(-15, 15)) +
  theme_bw() +
  theme(legend.box = "horizontal",
        legend.key.size = unit(30, "pt"),
        legend.position = "right",
        panel.grid.major = element_blank(),
        plot.margin = unit(c(0.2, 0.2, 0.5, 0.5), "lines"),
        legend.text = element_text(colour = "black", size = 14),
        panel.border = element_rect(fill = NA, size = 1, color = 'black'),
        axis.title.x = element_text(colour = "black", size = 15, vjust = 0),
        axis.title.y = element_text(colour = "black", size = 15, vjust = 2),
        axis.text.x = element_text(angle = 0, hjust = 0.5, vjust = 1, size = 14, colour = "black"),
        axis.text.y = element_text(angle = 0, hjust = 1, vjust = 0.5, size = 14, colour = "black"),
        plot.title = element_text(colour = "black", size = 16, vjust = 0.5, hjust = 0.5),
        axis.ticks = element_line(color = "black"),
        text = element_text(size = 15, family = "sans", colour = "black")) +
  guides(color = guide_legend(override.aes = list(size = 3.5))) +
  labs(title = "20 min", x = "PC1 (72.0%)", y = "PC2 (16.6%)") +
  theme(legend.title = element_blank(), legend.key = element_blank()) +
  scale_fill_manual(values = c("#fc9533", "#386CAF")) +
  scale_colour_manual(values = c("#fc9533", "#386CAF"),
                      breaks = c("DMSO", "TPA"),
                      labels = c("DMSO", "TPA")) +
  theme(text = element_text(size = 20)) +
  scale_y_continuous(limits = c(-60, 60), breaks = seq(-60, 60, 30)) +
  scale_x_continuous(limits = c(-60, 60), breaks = seq(-60, 60, 30)) +
  coord_fixed(ratio = 1)
ggsave("G:/AI_XuLab_Data/Radial-C/figs6a_20min.pdf", width = 4.2, height = 3.2, dpi = 600, device = cairo_pdf)