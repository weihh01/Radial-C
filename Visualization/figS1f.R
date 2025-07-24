library(ggplot2)
library(reshape2)

#Lamin----
enrichment <- read.table(file = "Lamin_score_profile.bed", sep = "\t", header = F, skip = 2)
enrichment <- enrichment[, -c(2)]
colnames(enrichment) <- c("type", c(1:7))
enrichment_m <- melt(enrichment)
colnames(enrichment_m) <- c("type", "pos", "sig")
enrichment_m$pos <- as.numeric(enrichment_m$pos)

enrichment_m$type <- factor(enrichment_m$type, levels = c("MNase-1min", "MNase-5min", "MNase-20min", "K562_MicroC"))

ggplot(enrichment_m) +
  ggtitle(NULL) +
  geom_line(aes(x = pos, y = sig, color = type), lwd = 1) +
  labs(title = "LADs (Lamin B1)", x = NULL, y = "1D coverage") +
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
  theme(legend.position = c(0.5, 0.23), legend.background = element_rect(fill = "transparent")) +
  scale_colour_manual(name = NULL, values = c("#386CAF", "#fc9533", "#9f79d3", "#86A873"), labels = c("Radial-C (1 min)", "Radial-C (5 min)", "Radial-C (20 min)", "Micro-C")) +
  scale_x_continuous(limits = c(1, 7), breaks = c(1, 2, 6, 7), labels = c("-0.1 Mb", "start", "end", "0.1 Mb")) +
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, 25))


#SON----
enrichment <- read.table(file = "SON_score_profile.bed", sep = "\t", header = F, skip = 2)
enrichment <- enrichment[, -c(2)]
colnames(enrichment) <- c("type", c(1:7))
enrichment_m <- melt(enrichment)
colnames(enrichment_m) <- c("type", "pos", "sig")
enrichment_m$pos <- as.numeric(enrichment_m$pos)

enrichment_m$type <- factor(enrichment_m$type, levels = c("MNase-1min", "MNase-5min", "MNase-20min", "K562_MicroC"))

ggplot(enrichment_m) +
  ggtitle(NULL) +
  geom_line(aes(x = pos, y = sig, color = type), lwd = 1) +
  labs(title = "Speckles", x = NULL, y = "1D coverage") +
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
    axis.text.x = element_text(size = 15, colour = 'black', angle = 30, vjust = 1, hjust = 1),
    axis.text.y = element_text(size = 15, colour = 'black'),
    legend.text = element_text(size = 14)) +
  theme(legend.position = "None", legend.background = element_rect(fill = "transparent")) +
  scale_colour_manual(name = NULL, values = c("#386CAF", "#fc9533", "#9f79d3", "#86A873"), labels = c("Radial-C (1 min)", "Radial-C (5 min)", "Radial-C (20 min)", "Micro-C")) +
  scale_x_continuous(limits = c(1, 7), breaks = c(1, 2, 6, 7), labels = c("-0.1 Mb", "star