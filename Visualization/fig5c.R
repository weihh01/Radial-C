library(openxlsx)
library(ggsignif)
library(ggplot2)
library(reshape2)
library(ggpubr)
setwd("G:/AI_XuLab_Data/Radial-C/figure5/5c/")

mymap1 <- mymap2 <- mymap3 <- c("grey", "#A67BB0")
df <- read.table('score/score.bed', header = F)
colnames(df) <- c("value", "variable")
df$variable <- factor(df$variable, levels = c("none_DMSO", "inwardoutward_DMSO"))

p_score = ggplot(df, aes(x = variable, y = value)) +
  geom_boxplot(aes(fill = variable), show.legend = F, na.rm = TRUE, outlier.shape = NA) +
  theme_bw() +
  ggtitle("score") +
  scale_fill_manual(values = mymap1) +
  scale_color_manual(values = c("black", "black")) +
  theme(axis.text.x = element_text(hjust = 0.5, vjust = 0.8, colour = "black", size = 14, angle = 45),
        axis.text.y = element_text(size = 14, face = "plain", colour = "black", angle = 0),
        axis.title.x = element_text(size = 15, face = "plain", colour = "black", vjust = 0, hjust = 0.5),
        axis.title.y = element_text(size = 15, face = "plain", colour = "black", vjust = 1, hjust = 0.5),
        panel.border = element_blank(),
        axis.line.x = element_blank(),
        axis.line.y = element_line(linetype = 1, color = "black", size = 0.5),
        axis.ticks.x = element_blank(),
        axis.ticks = element_line(colour = "black", size = 0.5),
        legend.position = "none",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.margin = unit(c(0.1, 0.1, 0.1, 0.1), "lines"),
        plot.title = element_text(colour = "black", face = "plain", size = 15, vjust = 0.5, hjust = 0.5)) +
  labs(title = "2D score", x = NULL, y = "2D score") +
  coord_cartesian(ylim = c(0, 0.85)) +
  scale_x_discrete(labels = c("Static anchors", "Mobile anchors")) +
  scale_y_continuous(breaks = seq(0, 1, 0.4)) +
  theme(text = element_text(size = 14)) +
  stat_compare_means(comparisons = list(c("none_DMSO", "inwardoutward_DMSO")), label.y = c(0.76), method = "wilcox.test", label = "p.signif", na.rm = TRUE, paired = FALSE, alternative = "two.sided")


df <- read.table('H3K27ac/H3K27ac.bed', header = F)
colnames(df) <- c("value", "variable")
df$value <- log(df$value, 2)
df$variable <- factor(df$variable, levels = c("none", "inwardoutward"))
df <- df[!is.infinite(df$value),]
p_H3K27ac = ggplot(df, aes(x = variable, y = value)) +
  geom_boxplot(aes(fill = variable), show.legend = F, na.rm = TRUE, outlier.shape = NA) +
  theme_bw() +
  ggtitle("score") +
  scale_fill_manual(values = mymap3) +
  scale_color_manual(values = c("black", "black")) +
  theme(axis.text.x = element_text(hjust = 0.5, vjust = 0.8, colour = "black", size = 14, angle = 45),
        axis.text.y = element_text(size = 14, face = "plain", colour = "black", angle = 0),
        axis.title.x = element_text(size = 15, face = "plain", colour = "black", vjust = 0, hjust = 0.5),
        axis.title.y = element_text(size = 15, face = "plain", colour = "black", vjust = 1, hjust = 0.5),
        panel.border = element_blank(),
        axis.line.x = element_blank(),
        axis.line.y = element_line(linetype = 1, color = "black", size = 0.5),
        axis.ticks.x = element_blank(),
        axis.ticks = element_line(colour = "black", size = 0.5),
        legend.position = "none",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.margin = unit(c(0.1, 0.1, 0.1, 0.1), "lines"),
        plot.title = element_text(colour = "black", face = "plain", size = 15, vjust = 0.5, hjust = 0.5)) +
  labs(title = "H3K27ac", x = NULL, y = expression(log[2] * "(ChIP signal)")) +
  coord_cartesian(ylim = c(-7, 0.2)) +
  scale_x_discrete(labels = c("Static anchors", "Mobile anchors")) +
  scale_y_continuous(breaks = seq(-8, 4, 2)) +
  theme(text = element_text(size = 14)) +
  stat_compare_means(comparisons = list(c('none', 'inwardoutward')), label.y = c(-0.6), method = "wilcox.test", label = "p.signif", na.rm = TRUE, paired = FALSE, alternative = "two.sided")

library(ggpubr)
require(grid)
ggarrange(p_score, p_H3K27ac, ncol = 2, nrow = 1, heights = c(1:1), align = "hv", common.legend = FALSE) +
  theme(plot.background = element_rect(fill = 'white', colour = 'white'))

ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig5c.png", width = 4.5, height = 2.8, dpi = 600)
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig5c.pdf", width = 4.5, height = 2.8, dpi = 600, device = cairo_pdf)