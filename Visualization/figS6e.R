library(openxlsx)
library(ggsignif)
library(ggplot2)
library(reshape2)
library(ggpubr)

setwd("G:/AI_XuLab_Data/Radial-C/figureS6/s6e/")
df <- read.table('DMSO.bed', header = F)
colnames(df) <- c("value", "variable")
df$variable[df$variable == "outward-static"] <- "static-outward"
unique(df$variable)
df$variable <- factor(df$variable, levels = c("static-static", "static-inward", "static-outward"))
my_comparisons <- list(c("static-outward", "static-static"), c("static-static", "static-inward"), c('static-inward', 'static-outward'))
ggplot(df, aes(x = variable, y = value)) +
  geom_violin(trim = FALSE, color = NA, aes(fill = variable), size = 0.1, width = 1, scale = "area", alpha = 0.8, na.rm = TRUE) +
  geom_boxplot(width = 0.2, position = position_dodge(0.9), size = 0.5, alpha = 1, outlier.shape = NA, fill = NA) +
  scale_fill_manual(values = c("grey", "#86B83F", "#9C8BCA")) +
  theme_bw() +
  theme(axis.text.x = element_text(hjust = 0.5, vjust = 1, colour = "black", size = 14, angle = 15),
        axis.text.y = element_text(size = 14, face = "plain", colour = "black"),
        axis.title.x = element_text(size = 15, face = "plain", colour = "black", vjust = -1.5, hjust = 0.5),
        axis.title.y = element_text(size = 15, face = "plain", colour = "black", vjust = 2, hjust = 0.5),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.ticks.x = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.line.x = element_blank(),
        legend.position = "none",
        plot.margin = unit(c(0.1, 0.1, 0.1, 0.1), "lines"),
        plot.title = element_text(colour = "black", face = "plain", size = 15, vjust = 0.5, hjust = 0.5)) +
  labs(title = "2D score", x = NULL, y = NULL) +
  scale_y_continuous(limits = c(-0, 1.3), expand = c(0.05, 0.01), breaks = seq(0, 1, 0.5), labels = seq(0, 1, 0.5)) +
  stat_compare_means(comparisons = my_comparisons, label.y = c(1.2, 1.05, 0.9), method = "wilcox.test", label = "p.signif", paired = FALSE, alternative = "two.sided")

ggsave(filename = "G:/AI_XuLab_Data/Radial-C/figS6e.png", width = 5.5, height = 3, dpi = 600)
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/figS6e.pdf", width = 5, height = 3, dpi = 600, device = cairo_pdf)