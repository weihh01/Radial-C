library(ggplot2)
library(reshape2)

setwd("G:/AI_XuLab_Data/Radial-C/figure3/3c/")
enrichment <- read.table(file = "IS.bed", sep = "\t", header = F, skip = 2)
enrichment <- enrichment[, -c(1)]
colnames(enrichment) <- c("type", c(1:100))
enrichment_m <- melt(enrichment)
colnames(enrichment_m) <- c("type", "pos", "sig")
enrichment_m$pos <- as.numeric(enrichment_m$pos)
enrichment_m$type <- factor(enrichment_m$type, levels = rev(c("MNase-20min_domains_10_tad.bed", "MNase-20min_domains_11-30_tad.bed", "MNase-20min_domains_31_tad.bed")))

ggplot(enrichment_m) +
  ggtitle(NULL) +
  geom_line(aes(x = pos, y = sig, color = type), lwd = 1) +
  labs(title = "TADs", x = "", y = "Insulation score") +
  guides(color = guide_legend(ncol = 1)) +
  theme_bw() +
  theme(plot.margin = unit(c(.1, .1, 0.1, .1), 'inches'),
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
  scale_colour_manual(name = NULL, values = c("#9f79d3", "#fc9533", "#386CAF"), labels = rev(c("Layer 1-10", "Layer 11-30", "Layer 31-50"))) +
  scale_x_continuous(limits = c(1, 100), breaks = c(1, 50.5, 100), labels = c(" -0.5 Mb", "Border", "0.5 Mb "))
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig3c.png", width = 5.1, height = 3.8, dpi = 600)
  