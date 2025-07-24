library(DESeq2)
library(sva)
library(openxlsx)
library(ggplot2)

#20min----
setwd('G:/AI_XuLab_Data/Radial-C/figureS6/s6b')
countData <- read.xlsx("loop_20min_all.xlsx")
colnames(countData) <- c("DMSO_1min", "DMSO_5min", "DMSO_20min", "TPA_1min", "TPA_5min", "TPA_20min")
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
name <- c("DMSO_1min", "DMSO_5min", "DMSO_20min", "TPA_1min", "TPA_5min", "TPA_20min")
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
  labs(title = "", x = "PC1 (55.2%)", y = "PC2 (16.3%)") +
  theme(legend.title = element_blank(), legend.key = element_blank()) +
  scale_fill_manual(values = c("#E8CCCD", "#BF7173", "#9b2226", "#D9DEE7", "#8B96AD", "#0074B3")) +
  scale_colour_manual(values = c("#E8CCCD", "#BF7173", "#9b2226", "#D9DEE7", "#8B96AD", "#0074B3"),
                      breaks = c("DMSO_1min", "DMSO_5min", "DMSO_20min", "TPA_1min", "TPA_5min", "TPA_20min"),
                      labels = c("DMSO 1 min", "DMSO 5 min", "DMSO 20 min", "TPA 1 min", "TPA 5 min", "TPA 20 min")) +
  theme(text = element_text(size = 20)) +
  scale_y_continuous(limits = c(-40, 40), breaks = seq(-40, 40, 20)) +
  scale_x_continuous(limits = c(-40, 40), breaks = seq(-40, 40, 20)) +
  coord_fixed(ratio = 1)
ggsave("G:/AI_XuLab_Data/Radial-C/figs6b_20min.pdf", width = 4.8, height = 3.2, dpi = 600, device = cairo_pdf)