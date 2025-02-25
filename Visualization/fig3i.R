library(ggplot2)
library(reshape2)

setwd("G:/AI_XuLab_Data/Radial-C/figure3/3i/")
#2stripe----
enrichment <- read.table(file = "2stripes_nona_profile.bed", sep = "\t", header = F, skip = 2)
enrichment <- enrichment[, -c(1)]
colnames(enrichment) <- c("type", c(1:7))
enrichment_m <- melt(enrichment)
colnames(enrichment_m) <- c("type", "pos", "sig")
enrichment_m$pos <- as.numeric(enrichment_m$pos)
p1 = ggplot(enrichment_m) +
  ggtitle(NULL) +
  geom_line(aes(x = pos, y = sig, color = type), lwd = 2) +
  labs(title = NULL, x = NULL, y = "2D score") +
  guides(color = guide_legend(ncol = 1)) +
  theme_bw() +
  theme(
    plot.margin = unit(c(.1, .1, 0.1, .1), 'inches'),
    plot.title = element_text(size = 16, hjust = .5),
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black", linewidth = 1.5),
    axis.ticks = element_line(color = "black"),
    axis.line = element_blank(),
    axis.title.x = element_text(size = 16, colour = 'black'),
    axis.title.y = element_text(size = 16, colour = 'black'),
    axis.text.x = element_text(size = 15, colour = 'black'),
    axis.text.y = element_text(size = 15, colour = 'black'),
    legend.text = element_text(size = 15)) +
  theme(legend.position = "none", legend.background = element_rect(fill = "transparent")) +
  scale_colour_manual(name = NULL, values = c("#386CAF"), labels = "double stripe") +
  scale_x_continuous(limits = c(1, 7), breaks = c(1, 2, 6, 7), labels = c("-0.1", "left", "right", "0.1 Mb")) +
  scale_y_continuous(limits = c(0.15, 0.23), breaks = seq(0.15, 0.21, 0.05))

#left_stripe----
enrichment <- read.table(file = "leftstripes_nona_profile.bed", sep = "\t", header = F, skip = 2)
enrichment <- enrichment[, -c(1)]
colnames(enrichment) <- c("type", c(1:7))
enrichment_m <- melt(enrichment)
colnames(enrichment_m) <- c("type", "pos", "sig")
enrichment_m$pos <- as.numeric(enrichment_m$pos)
p2 = ggplot(enrichment_m) +
  ggtitle(NULL) +
  geom_line(aes(x = pos, y = sig, color = type), lwd = 2) +
  labs(title = NULL, x = NULL, y = "2D score") +
  guides(color = guide_legend(ncol = 1)) +
  theme_bw() +
  theme(
    plot.margin = unit(c(.1, .1, 0.1, .1), 'inches'),
    plot.title = element_text(size = 16, hjust = .5),
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black", linewidth = 1.5),
    axis.ticks = element_line(color = "black"),
    axis.line = element_blank(),
    axis.title.x = element_text(size = 16, colour = 'black'),
    axis.title.y = element_text(size = 16, colour = 'black'),
    axis.text.x = element_text(size = 15, colour = 'black'),
    axis.text.y = element_text(size = 15, colour = 'black'),
    legend.text = element_text(size = 15)) +
  theme(legend.position = "none", legend.background = element_rect(fill = "transparent")) +
  scale_colour_manual(name = NULL, values = c("#386CAF"), labels = "left stripe") +
  scale_x_continuous(limits = c(1, 7), breaks = c(1, 2, 6, 7), labels = c("-0.1", "left", "right", "0.1 Mb")) +
  scale_y_continuous(limits = c(0.15, 0.23), breaks = seq(0.15, 0.21, 0.05))


#right_stripe----
enrichment <- read.table(file = "rightstripes_nona_profile.bed", sep = "\t", header = F, skip = 2)
enrichment <- enrichment[, -c(1)]
colnames(enrichment) <- c("type", c(1:7))
enrichment_m <- melt(enrichment)
colnames(enrichment_m) <- c("type", "pos", "sig")
enrichment_m$pos <- as.numeric(enrichment_m$pos)
p3 = ggplot(enrichment_m) +
  ggtitle(NULL) +
  geom_line(aes(x = pos, y = sig, color = type), lwd = 2) +
  labs(title = NULL, x = NULL, y = "2D score") +
  guides(color = guide_legend(ncol = 1)) +
  theme_bw() +
  theme(
    plot.margin = unit(c(.1, .1, 0.1, .1), 'inches'),
    plot.title = element_text(size = 16, hjust = .5),
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black", linewidth = 1.5),
    axis.ticks = element_line(color = "black"),
    axis.line = element_blank(),
    axis.title.x = element_text(size = 16, colour = 'black'),
    axis.title.y = element_text(size = 16, colour = 'black'),
    axis.text.x = element_text(size = 15, colour = 'black'),
    axis.text.y = element_text(size = 15, colour = 'black'),
    legend.text = element_text(size = 15)) +
  theme(legend.position = "none", legend.background = element_rect(fill = "transparent")) +
  scale_colour_manual(name = NULL, values = c("#386CAF"), labels = "right stripe") +
  scale_x_continuous(limits = c(1, 7), breaks = c(1, 2, 6, 7), labels = c("-0.1", "left", "right", "0.1 Mb")) +
  scale_y_continuous(limits = c(0.15, 0.23), breaks = seq(0.15, 0.21, 0.05))

library(ggpubr)
require(grid)
ggarrange(p1, p2, p3, ncol = 3, nrow = 1, heights = c(1:1:1), align = "hv", common.legend = FALSE) +
  theme(plot.background = element_rect(fill = 'white', colour = 'white'))
ggsave("G:/AI_XuLab_Data/Radial-C/fig3i.pdf", width = 15, height = 3, device = cairo_pdf)
ggsave("G:/AI_XuLab_Data/Radial-C/fig3i.png", width = 15, height = 3, dpi = 600)