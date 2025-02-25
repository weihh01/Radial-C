library(ggplot2)
library(reshape2)

setwd("G:/AI_XuLab_Data/Radial-C/figure3/3d/")
#2D Score----
enrichment <- read.table(file = "Lamin_score_profile.bed", sep = "\t", header = F, skip = 2)
enrichment <- enrichment[, -c(1)]
colnames(enrichment) <- c("type", c(1:7))
enrichment_m <- melt(enrichment)
colnames(enrichment_m) <- c("type", "pos", "sig")
enrichment_m$pos <- as.numeric(enrichment_m$pos)
enrichment_m$type <- factor(enrichment_m$type, levels = rev(c("LaminAC_nona.bed", "LaminB1_nona.bed")))

p1 = ggplot(enrichment_m) +
  ggtitle(NULL) +
  annotate("text", x = 4, y = 0.23, label = "2D score", vjust = 0, size = 5.5) +
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
    #axis.ticks.length.x = unit(-0.2, "cm"),
    axis.line = element_blank(),
    axis.title.x = element_text(size = 16, colour = 'black'),
    axis.title.y = element_text(size = 16, colour = 'black'),
    axis.text.x = element_blank(),
    axis.text.y = element_text(size = 15, colour = 'black'),
    legend.text = element_text(size = 14)) +
  theme(legend.position = c(0.5, 0.5), legend.background = element_rect(fill = "transparent")) +
  scale_colour_manual(name = NULL, values = c("#FFA500", "#696969"), labels = rev(c("Lamin A/C", "Lamin B1"))) +
  scale_x_continuous(limits = c(1, 7), breaks = c(1, 2, 4, 6, 7), labels = c("-100kb", "left", "domain", "right", "100kb")) +
  scale_y_continuous(limits = c(0, 0.25), breaks = seq(0, 0.25, 0.1))

#H3K9me3----
enrichment <- read.table(file = "Lamin_K562_H3K9me3_profile.bed", sep = "\t", header = F, skip = 2)
enrichment <- enrichment[, -c(1)]
colnames(enrichment) <- c("type", c(1:7))
enrichment_m <- melt(enrichment)
colnames(enrichment_m) <- c("type", "pos", "sig")
enrichment_m$pos <- as.numeric(enrichment_m$pos)
enrichment_m$type <- factor(enrichment_m$type, levels = rev(c("LaminAC_nona.bed", "LaminB1_nona.bed")))

p2 = ggplot(enrichment_m) +
  ggtitle(NULL) +
  annotate("text", x = 4, y = 0.115, label = "H3K9me3", vjust = 0, size = 5.5) +
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
  scale_colour_manual(name = NULL, values = c("#FFA500", "#696969"), labels = rev(c("Lamin A/C", "Lamin B1"))) +
  scale_x_continuous(limits = c(1, 7), breaks = c(1, 2, 4, 6, 7), labels = c("-100kb", "left", "domain", "right", "100kb")) +
  scale_y_continuous(limits = c(0.04, 0.12), breaks = c(0.04, 0.07, 0.10))

#H3K27me3----
enrichment <- read.table(file = "Lamin_K562_H3K27me3_profile.bed", sep = "\t", header = F, skip = 2)
enrichment <- enrichment[, -c(1)]
colnames(enrichment) <- c("type", c(1:7))
enrichment_m <- melt(enrichment)
colnames(enrichment_m) <- c("type", "pos", "sig")
enrichment_m$pos <- as.numeric(enrichment_m$pos)
enrichment_m$type <- factor(enrichment_m$type, levels = rev(c("LaminAC_nona.bed", "LaminB1_nona.bed")))

p3 = ggplot(enrichment_m) +
  ggtitle(NULL) +
  annotate("text", x = 4, y = 0.087, label = "H3K27me3", vjust = 0, size = 5.5) +
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
  theme(legend.position = c(0.5, 0.78), legend.background = element_rect(fill = "transparent")) +
  scale_colour_manual(name = NULL, values = c("#FFA500", "#696969"), labels = rev(c("Lamin A/C", "Lamin B1"))) +
  scale_x_continuous(limits = c(1, 7), breaks = c(1, 2, 4, 6, 7), labels = c("-0.1 Mb", "start", "domain", "end", "1 Mb")) +
  scale_y_continuous(limits = c(0.04, 0.09), breaks = c(0.04, 0.06, 0.08))

library(ggpubr)
require(grid)
ggarrange(p1, p2, p3, ncol = 1, nrow = 3, heights = c(1:1:1), align = "hv", common.legend = FALSE) +
  theme(plot.background = element_rect(fill = 'white', colour = 'white'))
ggsave("G:/AI_XuLab_Data/Radial-C/fig3d.pdf", width = 3, height = 8.1, device = cairo_pdf)
ggsave("G:/AI_XuLab_Data/Radial-C/fig3d.png", width = 3, height = 8.1, dpi = 600)