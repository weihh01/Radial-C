library(ggplot2)
library(reshape2)

setwd("G:/AI_XuLab_Data/Radial-C/figureS3/3g/")
for (i in c("2Dscore")) {
  enrichment <- read.table(file = paste0("K562_", i, "_profile.bed"), sep = "\t", header = F, skip = 2)
  enrichment <- enrichment[, -c(1)]
  colnames(enrichment) <- c("type", c(1:7))
  enrichment_m <- melt(enrichment)
  colnames(enrichment_m) <- c("type", "pos", "sig")
  enrichment_m$pos <- as.numeric(enrichment_m$pos)

  enrichment_m$type <- factor(enrichment_m$type, levels = c("MNase-1min-5min-20min_31_loop_nona.bed",
                                                            "MNase-1min-5min-20min_11-30_loop_nona.bed",
                                                            "MNase-1min-5min-20min_10_loop_nona.bed"))

  max_signal <- max(enrichment_m$sig)
  min_signal <- min(enrichment_m$sig)
  max_s <- max_signal + (max_signal - min_signal) / 7
  min_s <- min_signal - (max_signal - min_signal) / 7
  break_y <- seq(round(min_signal, 2), (round(min_signal, 2) + round((max_signal - min_signal) / 2, 2) * 2), round((max_signal - min_signal) / 2, 2))
  break_n <- length(break_y)

  p = ggplot(enrichment_m) +
    ggtitle(NULL) +
    annotate("text", x = 3.5, y = 0.39, label = "2D score", vjust = 0, size = 5.5) +
    geom_line(aes(x = pos, y = sig, color = type), lwd = 1) +
    labs(title = NULL, x = NULL, y = NULL) +
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
      axis.text.x = element_text(size = 15, colour = 'black'),
      axis.text.y = element_text(size = 15, colour = 'black'),
      legend.text = element_text(size = 14)) +
    theme(legend.position = c(0.5, 0.3), legend.background = element_rect(fill = "transparent")) +
    scale_colour_manual(name = NULL, values = c("#AEB7C8", "#76B7B1", "#DB9052"), c("Loops (Layer 31-50)", "Loops (Layer 11-30)", "Loops (Layer1-10)")) +
    scale_x_continuous(limits = c(1, 7), breaks = c(1, 2, 6, 7), labels = c("-0.1 Mb", "5' anchor", "3' anchor", "0.1 Mb")) +
    scale_y_continuous(limits = c(0, 1),
                       breaks = c(0, 0.5, 1))
  assign(paste0("p_", i), p)
  p

}


for (i in c("H3K27ac", "H3K36me3", "H3K4me3_abC")) {
  enrichment <- read.table(file = paste0("K562_", i, "_profile.bed"), sep = "\t", header = F, skip = 2)
  enrichment <- enrichment[, -c(1)]
  colnames(enrichment) <- c("type", c(1:7))
  enrichment_m <- melt(enrichment)
  colnames(enrichment_m) <- c("type", "pos", "sig")
  enrichment_m$pos <- as.numeric(enrichment_m$pos)

  enrichment_m$type <- factor(enrichment_m$type, levels = c("MNase-1min-5min-20min_31_loop_nona.bed",
                                                            "MNase-1min-5min-20min_11-30_loop_nona.bed",
                                                            "MNase-1min-5min-20min_10_loop_nona.bed"))

  max_signal <- max(enrichment_m$sig)
  min_signal <- min(enrichment_m$sig)
  max_s <- max_signal + (max_signal - min_signal) / 7
  min_s <- min_signal - (max_signal - min_signal) / 7
  break_y <- seq(round(min_signal, 2), (round(min_signal, 2) + round((max_signal - min_signal) / 2, 2) * 2), round((max_signal - min_signal) / 2, 2))
  break_n <- length(break_y)

  p = ggplot(enrichment_m) +
    ggtitle(NULL) +
    annotate("text", x = 3.5, y = round(max_s, 2) * 0.9, label = i, vjust = 0, size = 5.5) +
    geom_line(aes(x = pos, y = sig, color = type), lwd = 1) +
    labs(title = NULL, x = NULL, y = NULL) +
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
    theme(legend.position = "none", legend.background = element_rect(fill = "transparent")) +
    scale_colour_manual(name = NULL, values = c("#AEB7C8", "#76B7B1", "#DB9052"), c("Loops (Layer 31-50)", "Loops (Layer 11-30)", "Loops (Layer1-10)")) +
    scale_x_continuous(limits = c(1, 7), breaks = c(1, 2, 6, 7), labels = c("-0.1 Mb", "5' anchor", "3' anchor", "0.1 Mb")) +
    scale_y_continuous(limits = c(round(min_s, 2), round(max_s, 2)),
                       breaks = break_y)
  assign(paste0("p_", i), p)
  p

}

for (i in c("H3K9me3")) {
  enrichment <- read.table(file = paste0("K562_", i, "_profile.bed"), sep = "\t", header = F, skip = 2)
  enrichment <- enrichment[, -c(1)]
  colnames(enrichment) <- c("type", c(1:7))
  enrichment_m <- melt(enrichment)
  colnames(enrichment_m) <- c("type", "pos", "sig")
  enrichment_m$pos <- as.numeric(enrichment_m$pos)

  enrichment_m$type <- factor(enrichment_m$type, levels = c("MNase-1min-5min-20min_31_loop_nona.bed",
                                                            "MNase-1min-5min-20min_11-30_loop_nona.bed",
                                                            "MNase-1min-5min-20min_10_loop_nona.bed"))

  max_signal <- max(enrichment_m$sig) * 1.1
  min_signal <- min(enrichment_m$sig)
  max_s <- max_signal + (max_signal - min_signal) / 7
  min_s <- min_signal - (max_signal - min_signal) / 7
  break_y <- seq(round(min_signal, 2), (round(min_signal, 2) + round((max_signal - min_signal) / 2, 2) * 2), round((max_signal - min_signal) / 2, 2))
  break_n <- length(break_y)

  p = ggplot(enrichment_m) +
    ggtitle(NULL) +
    annotate("text", x = 3.5, y = round(max_s, 2) * 0.9, label = i, vjust = 0, size = 5.5) +
    geom_line(aes(x = pos, y = sig, color = type), lwd = 1) +
    labs(title = NULL, x = NULL, y = NULL) +
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
    theme(legend.position = "none", legend.background = element_rect(fill = "transparent")) +
    scale_colour_manual(name = NULL, values = c("#AEB7C8", "#76B7B1", "#DB9052"), c("Loops (Layer 31-50)", "Loops (Layer 11-30)", "Loops (Layer1-10)")) +
    scale_x_continuous(limits = c(1, 7), breaks = c(1, 2, 6, 7), labels = c("-0.1 Mb", "5' anchor", "3' anchor", "0.1 Mb")) +
    scale_y_continuous(limits = c(round(min_s, 2), round(max_s, 2)),
                       breaks = break_y)
  assign(paste0("p_", i), p)
  p

}

library(ggpubr)
require(grid)

ggarrange(p_2Dscore, p_H3K4me3_abC, p_H3K27ac, ncol = 1, nrow = 3, heights = c(1:1:1), align = "hv", common.legend = FALSE) +
  theme(plot.background = element_rect(fill = 'white', colour = 'white'))
ggsave("G:/AI_XuLab_Data/Radial-C/figS3g-1.pdf", width = 3.3, height = 8.1, device = cairo_pdf)
ggsave("G:/AI_XuLab_Data/Radial-C/figS3g-1.png", width = 3.3, height = 8.1, dpi = 600)


ggarrange(p_H3K9me3, p_H3K9me3, p_H3K36me3, ncol = 1, nrow = 3, heights = c(1:1:1), align = "hv", common.legend = FALSE) +
  theme(plot.background = element_rect(fill = 'white', colour = 'white'))
ggsave("G:/AI_XuLab_Data/Radial-C/figS3g-2.pdf", width = 3.3, height = 8.1, device = cairo_pdf)
ggsave("G:/AI_XuLab_Data/Radial-C/figS3g-2.png", width = 3.3, height = 8.1, dpi = 600)