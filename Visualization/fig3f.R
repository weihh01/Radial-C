library(ggplot2)
library(reshape2)

setwd("G:/AI_XuLab_Data/Radial-C/figure3/3f/")
#2D Score----
enrichment <- read.table(file = "SON_score_profile.bed", sep = "\t", header = F, skip = 2)
enrichment <- enrichment[, -c(1)]
colnames(enrichment) <- c("type", c(1:7))
enrichment_m <- melt(enrichment)
colnames(enrichment_m) <- c("type", "pos", "sig")
enrichment_m$pos <- as.numeric(enrichment_m$pos)
enrichment_m$type <- factor(enrichment_m$type, levels = rev(c("SON_0-0.5.bed", "SON_0.5-1.bed")))

p1 = ggplot(enrichment_m) +
  ggtitle(NULL) +
  annotate("text", x = 4, y = 0.7, label = "2D score", vjust = 0, size = 5.5) +
  geom_line(aes(x = pos, y = sig, color = type), lwd = 1) +
  labs(title = NULL, x = NULL, y = "2D score") +
  guides(color = guide_legend(ncol = 1)) +
  theme_bw() +
  theme(
    plot.margin = unit(c(.1, .1, 0.1, .1), 'inches'),
    plot.title = element_text(size = 16, hjust = .5),
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black"),
    axis.ticks = element_line(color = "black"),
    axis.line = element_blank(),
    axis.title.x = element_text(size = 16, colour = 'black'),
    axis.title.y = element_text(size = 16, colour = 'black'),
    axis.text.x = element_blank(),
    axis.text.y = element_text(size = 15, colour = 'black'),
    legend.text = element_text(size = 14)) +
  theme(legend.position = c(0.5, 0.5), legend.background = element_rect(fill = "transparent")) +
  scale_colour_manual(name = NULL, values = c("#7FC87F", "#9f79d3"), labels = rev(c("SON (0 - 0.5)", "SON (0.5 - 1)"))) +
  scale_x_continuous(limits = c(1, 7), breaks = c(1, 2, 6, 7), labels = c("-100kb", "start", "end", "100kb")) +
  scale_y_continuous(limits = c(0, 0.8), breaks = seq(0, 0.8, 0.4))

#H3K27ac----
enrichment <- read.table(file = "SON_K562_H3K27ac_profile.bed", sep = "\t", header = F, skip = 2)
enrichment <- enrichment[, -c(1)]
colnames(enrichment) <- c("type", c(1:7))
enrichment_m <- melt(enrichment)
colnames(enrichment_m) <- c("type", "pos", "sig")
enrichment_m$pos <- as.numeric(enrichment_m$pos)
enrichment_m$type <- factor(enrichment_m$type, levels = rev(c("SON_0-0.5.bed", "SON_0.5-1.bed")))

p2 = ggplot(enrichment_m) +
  ggtitle(NULL) +
  annotate("text", x = 4, y = 0.22, label = "H3K27ac", vjust = 0, size = 5.5) +
  geom_line(aes(x = pos, y = sig, color = type), lwd = 1) +
  labs(title = NULL, x = NULL, y = "Normalized signals") +
  guides(color = guide_legend(ncol = 1)) +
  theme_bw() +
  theme(
    plot.margin = unit(c(.1, .1, 0.1, .1), 'inches'),
    plot.title = element_text(size = 16, hjust = .5),
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black"),
    axis.ticks = element_line(color = "black"),
    #axis.ticks.length.x = unit(-0.2, "cm"),
    axis.line = element_blank(),
    axis.title.x = element_text(size = 16, colour = 'black'),
    axis.title.y = element_text(size = 16, colour = 'black'),
    axis.text.x = element_blank(),
    axis.text.y = element_text(size = 15, colour = 'black'),
    legend.text = element_text(size = 14)) +
  theme(legend.position = c(0.5, 0.2), legend.background = element_rect(fill = "transparent")) +
  scale_colour_manual(name = NULL, values = c("#7FC87F", "#9f79d3"), labels = rev(c("SON (0 - 0.5)", "SON (0.5 - 1)"))) +
  scale_x_continuous(limits = c(1, 7), breaks = c(1, 2, 6, 7), labels = c("-100kb", "start", "end", "100kb")) +
  scale_y_continuous(limits = c(0, 0.25), breaks = c(0, 0.2, 0.1))

#H3K4me3----
enrichment <- read.table(file = "SON_K562_H3K4me3_abC_profile.bed", sep = "\t", header = F, skip = 2)
enrichment <- enrichment[, -c(1)]
colnames(enrichment) <- c("type", c(1:7))
enrichment_m <- melt(enrichment)
colnames(enrichment_m) <- c("type", "pos", "sig")
enrichment_m$pos <- as.numeric(enrichment_m$pos)
enrichment_m$type <- factor(enrichment_m$type, levels = rev(c("SON_0-0.5.bed", "SON_0.5-1.bed")))

p3 = ggplot(enrichment_m) +
  ggtitle(NULL) +
  annotate("text", x = 4, y = 0.205, label = "H3K4me3", vjust = 0, size = 5.5) +
  geom_line(aes(x = pos, y = sig, color = type), lwd = 1) +
  labs(title = NULL, x = NULL, y = "Normalized signals") +
  guides(color = guide_legend(ncol = 1)) +
  theme_bw() +
  theme(
    plot.margin = unit(c(.1, .1, 0.1, .1), 'inches'),
    plot.title = element_text(size = 16, hjust = .5),
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black"),
    axis.ticks = element_line(color = "black"),
    axis.line = element_blank(),
    axis.title.x = element_text(size = 16, colour = 'black'),
    axis.title.y = element_text(size = 16, colour = 'black'),
    axis.text.x = element_text(size = 15, colour = 'black'),
    axis.text.y = element_text(size = 15, colour = 'black'),
    legend.text = element_text(size = 14)) +
  theme(legend.position = c(0.5, 0.2), legend.background = element_rect(fill = "transparent")) +
  scale_colour_manual(name = NULL, values = c("#7FC87F", "#9f79d3"), labels = rev(c("SON (0 - 0.5)", "SON (0.5 - 1)"))) +
  scale_x_continuous(limits = c(1, 7), breaks = c(1, 2, 6, 7), labels = c("-0.1 Mb", "start", " end", "1 Mb")) +
  scale_y_continuous(limits = c(0, 0.225), breaks = c(0, 0.2, 0.1))


library(ggpubr)
require(grid)
ggarrange(p1, p3, p2, ncol = 1, nrow = 3, heights = c(1:1:1), align = "hv", common.legend = FALSE) +
  theme(plot.background = element_rect(fill = 'white', colour = 'white'))

ggsave("G:/AI_XuLab_Data/Radial-C/fig3f.pdf", width = 3, height = 8.1, device = cairo_pdf)
ggsave("G:/AI_XuLab_Data/Radial-C/fig3f.png", width = 3, height = 8.1, dpi = 600)