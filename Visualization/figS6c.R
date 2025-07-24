library(ggplot2)
library(reshape2)

#1min----
enrichment <- read.table(file = "MNase_50_35.1min.plotProfile.bed", sep = "\t", header = F, skip = 2)
enrichment <- enrichment[, -c(2)]
colnames(enrichment) <- c("type", c(1:200))
enrichment_m <- melt(enrichment)
colnames(enrichment_m) <- c("type", "pos", "sig")
enrichment_m$pos <- as.numeric(enrichment_m$pos)

enrichment_m$type <- factor(enrichment_m$type, levels = c("DMSO", "TPA"))

p1 = ggplot(enrichment_m) +
  ggtitle(NULL) +
  geom_line(aes(x = pos, y = sig, color = type), lwd = 1.5) +
  labs(title = "1 min", x = NULL, y = "Radial-C (1D)") +
  guides(color = guide_legend(ncol = 1)) +
  theme_bw() +
  theme(
    plot.margin = unit(c(.1, .3, 0.1, .1), 'inches'),
    plot.title = element_text(size = 16, hjust = .5),
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black"),
    axis.ticks = element_line(color = "black"),
    axis.line = element_blank(),
    axis.title.x = element_text(size = 16, colour = 'black'),
    axis.title.y = element_text(size = 16, colour = 'black'),
    axis.text.x = element_text(size = 16, colour = 'black'),
    axis.text.y = element_text(size = 16, colour = 'black'),
    legend.text = element_text(size = 16)) +
  theme(legend.position = c(0.78, 0.25), legend.background = element_rect(fill = "transparent")) +
  scale_colour_manual(name = NULL, values = c("#DB9052", "#386CAF")) +
  scale_x_continuous(expand = c(0.01, 0.01), limits = c(1, 200), breaks = c(1, 100.5, 200), labels = c(" -1 kb", "Nucleosome", "1 kb ")) +
  scale_y_continuous(expand = c(0.002, 0.002), limits = c(0.0, 0.04), breaks = c(0, 0.04))

#5min----
enrichment <- read.table(file = "MNase_50_35.5min.plotProfile.bed", sep = "\t", header = F, skip = 2)
enrichment <- enrichment[, -c(2)]
colnames(enrichment) <- c("type", c(1:200))
enrichment_m <- melt(enrichment)
colnames(enrichment_m) <- c("type", "pos", "sig")
enrichment_m$pos <- as.numeric(enrichment_m$pos)

enrichment_m$type <- factor(enrichment_m$type, levels = c("DMSO", "TPA"))

p2 = ggplot(enrichment_m) +
  ggtitle(NULL) +
  geom_line(aes(x = pos, y = sig, color = type), lwd = 1.5) +
  labs(title = "5 min", x = NULL, y = "Radial-C (1D)") +
  guides(color = guide_legend(ncol = 1)) +
  theme_bw() +
  theme(
    plot.margin = unit(c(.1, .3, 0.1, .1), 'inches'),
    plot.title = element_text(size = 16, hjust = .5),
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black"),
    axis.ticks = element_line(color = "black"),
    axis.line = element_blank(),
    axis.title.x = element_text(size = 16, colour = 'black'),
    axis.title.y = element_text(size = 16, colour = 'black'),
    axis.text.x = element_text(size = 16, colour = 'black'),
    axis.text.y = element_text(size = 16, colour = 'black'),
    legend.text = element_text(size = 16)) +
  theme(legend.position = c(0.78, 0.25), legend.background = element_rect(fill = "transparent")) +
  scale_colour_manual(name = NULL, values = c("#DB9052", "#386CAF")) +
  scale_x_continuous(expand = c(0.01, 0.01), limits = c(1, 200), breaks = c(1, 100.5, 200), labels = c(" -1 kb", "Nucleosome", "1 kb ")) +
  scale_y_continuous(expand = c(0.002, 0.002), limits = c(0.0, 0.04), breaks = c(0, 0.04))

#20min----
enrichment <- read.table(file = "MNase_50_35.20min.plotProfile.bed", sep = "\t", header = F, skip = 2)
enrichment <- enrichment[, -c(2)]
colnames(enrichment) <- c("type", c(1:200))
enrichment_m <- melt(enrichment)
colnames(enrichment_m) <- c("type", "pos", "sig")
enrichment_m$pos <- as.numeric(enrichment_m$pos)

enrichment_m$type <- factor(enrichment_m$type, levels = c("DMSO", "TPA"))

p3 = ggplot(enrichment_m) +
  ggtitle(NULL) +
  geom_line(aes(x = pos, y = sig, color = type), lwd = 1.5) +
  labs(title = "20 min", x = NULL, y = "Radial-C (1D)") +
  guides(color = guide_legend(ncol = 1)) +
  theme_bw() +
  theme(
    plot.margin = unit(c(.1, .3, 0.1, .1), 'inches'),
    plot.title = element_text(size = 16, hjust = .5),
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black"),
    axis.ticks = element_line(color = "black"),
    axis.line = element_blank(),
    axis.title.x = element_text(size = 16, colour = 'black'),
    axis.title.y = element_text(size = 16, colour = 'black'),
    axis.text.x = element_text(size = 16, colour = 'black'),
    axis.text.y = element_text(size = 16, colour = 'black'),
    legend.text = element_text(size = 16)) +
  theme(legend.position = c(0.78, 0.25), legend.background = element_rect(fill = "transparent")) +
  scale_colour_manual(name = NULL, values = c("#DB9052", "#386CAF")) +
  scale_x_continuous(expand = c(0.01, 0.01), limits = c(1, 200), breaks = c(1, 100.5, 200), labels = c(" -1 kb", "Nucleosome", "1 kb ")) +
  scale_y_continuous(expand = c(0.002, 0.002), limits = c(0.0, 0.04), breaks = c(0, 0.04))

library(ggpubr)
require(grid)
ggarrange(p1, p2, p3, ncol = 3, nrow = 1, heights = c(1:1:1), align = "hv", common.legend = FALSE) +
  theme(plot.background = element_rect(fill = 'white', colour = 'white'))