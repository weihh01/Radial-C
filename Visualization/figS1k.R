library(ggplot2)
library(ggpubr)
library(reshape2)
library(dplyr)

options(scipen = 999)
setwd("G:/AI_XuLab_Data/Radial-C/revision1/cor/3DChromatin_ReplicateQC/")
reproducibility_summary <- data.frame(matrix(ncol = 6, nrow = 0))
colnames(reproducibility_summary) <- c("Sample1", "Sample2", "algorithms", "reproducibility", "chr", "resolution")

for (res in c(500000, 250000, 100000, 50000)) {
  for (chrs in seq(1, 22)) {
    reproducibility <- read.table(file = paste0("3DChromatin_ReplicateQC_res", res, "/scores/", "reproducibility.chr", chrs, ".txt"), header = T, comment.char = "")
    reproducibility_m <- melt(reproducibility, id.vars = c("X.Sample1", "Sample2"),
                              measure.vars = c("GenomeDISCO", "HiC.Spector", "HiCRep", "QuASAR.Rep"),
                              variable.name = "algorithms",
                              value.name = "reproducibility")

    reproducibility_m$chr <- paste0("chr", chrs)
    reproducibility_m$resolution <- res

    reproducibility_summary <- rbind(reproducibility_summary, reproducibility_m)
  }
}

reproducibility_summary <- reproducibility_summary[reproducibility_summary$algorithms != "HiC.Spector" &
                                                     reproducibility_summary$resolution == 250000 &
                                                     !(reproducibility_summary$X.Sample1 == "K562_MicroC_20min_rep1" & reproducibility_summary$Sample2 == "K562_MicroC_20min_rep2"),]
reproducibility_summary$algorithms <- factor(reproducibility_summary$algorithms, levels = c("HiCRep", "QuASAR.Rep", "GenomeDISCO"), labels = c("HiC-Rep", "QuASAR", "GenomeDISCO"))

#rep1----
rep1 <- reproducibility_summary[grep("rep1", reproducibility_summary$X.Sample1),]
rep1$resolution <- factor(rep1$X.Sample1, levels = c("K562_MicroC_1min_rep1", "K562_MicroC_5min_rep1", "K562_MicroC_20min_rep1"), labels = c(1, 2, 3))
rep1$resolution <- as.numeric(rep1$resolution)
rep1_mean <- rep1 %>%
  group_by(algorithms, resolution) %>%
  summarize(mean(reproducibility))
ggplot(rep1, aes(x = resolution, y = reproducibility, group = algorithms, color = algorithms)) +
  geom_line(size = 1, alpha = 1, stat = "summary") +
  stat_summary(aes(colour = algorithms), fun.data = 'mean_sd', geom = "errorbar", width = 0.2) +
  geom_point(size = 3, alpha = 1, stat = "summary", aes(shape = algorithms)) +
  theme_bw() +
  theme_classic() +
  theme(legend.position = c(0.7, 0.4),
        legend.text = element_text(colour = "black", size = 13),
        legend.background = element_rect(fill = "transparent"),
        axis.line.x = element_line(linetype = 1, color = "black"),
        axis.line.y = element_line(linetype = 1, color = "black"),
        axis.ticks.x = element_line(color = "black"),
        axis.ticks.y = element_line(color = "black"),
        axis.ticks.length = unit(-0.1, "cm"),
        axis.title.x = element_text(size = 14, vjust = 0.5, hjust = 1),
        axis.title.y = element_text(size = 14),
        axis.text.x = element_text(size = 14, colour = 'black', angle = 0, hjust = 0.5, vjust = 8),
        axis.text.y = element_text(size = 14, colour = 'black'),
        plot.title = element_text(colour = "black", size = 14, hjust = 0.5)) +
  guides(color = guide_legend(override.aes = list(size = 3))) +
  scale_color_manual(NULL, values = c("#EE7E31", "#71AD46", "#4871B7")) +
  scale_shape_manual(NULL, values = c(16, 17, 15)) +
  labs(title = "Radial-C rep1 vs. Micro-C", x = NULL, y = "Reproducibility score", size = 15) +
  scale_y_continuous(expand = c(0, 0), limits = c(-0.5, 1.0), breaks = seq(-1, 1, 0.5)) +
  scale_x_continuous(expand = c(0, 0), limits = c(0.5, 3.5), breaks = seq(0.5, 3.5, 0.5), labels = c("", "1 min", "", "5 min", "", "20 min", ""))

#rep2----
rep2 <- reproducibility_summary[grep("rep2", reproducibility_summary$X.Sample1),]
rep2$resolution <- factor(rep2$X.Sample1, levels = c("K562_MicroC_1min_rep2", "K562_MicroC_5min_rep2", "K562_MicroC_20min_rep2"), labels = c(1, 2, 3))
rep2$resolution <- as.numeric(rep2$resolution)
rep2_mean <- rep2 %>%
  group_by(algorithms, resolution) %>%
  summarize(mean(reproducibility))
ggplot(rep2, aes(x = resolution, y = reproducibility, group = algorithms, color = algorithms)) +
  geom_line(size = 1, alpha = 1, stat = "summary") +
  stat_summary(aes(colour = algorithms), fun.data = 'mean_sd', geom = "errorbar", width = 0.2) +
  geom_point(size = 3, alpha = 1, stat = "summary", aes(shape = algorithms)) +
  theme_bw() +
  theme_classic() +
  theme(legend.position = c(0.7, 0.4),
        legend.text = element_text(colour = "black", size = 13),
        legend.background = element_rect(fill = "transparent"),
        axis.line.x = element_line(linetype = 1, color = "black"),
        axis.line.y = element_line(linetype = 1, color = "black"),
        axis.ticks.x = element_line(color = "black"),
        axis.ticks.y = element_line(color = "black"),
        axis.ticks.length = unit(-0.1, "cm"),
        axis.title.x = element_text(size = 14, vjust = 0.5, hjust = 1),
        axis.title.y = element_text(size = 14),
        axis.text.x = element_text(size = 14, colour = 'black', angle = 0, hjust = 0.5, vjust = 8),
        axis.text.y = element_text(size = 14, colour = 'black'),
        plot.title = element_text(colour = "black", size = 14, hjust = 0.5)) +
  guides(color = guide_legend(override.aes = list(size = 3))) +
  scale_color_manual(NULL, values = c("#EE7E31", "#71AD46", "#4871B7")) +
  scale_shape_manual(NULL, values = c(16, 17, 15)) +
  labs(title = "Radial-C rep2 vs. Micro-C", x = NULL, y = "Reproducibility score", size = 15) +
  scale_y_continuous(expand = c(0, 0), limits = c(-0.5, 1.0), breaks = seq(-1, 1, 0.5)) +
  scale_x_continuous(expand = c(0, 0), limits = c(0.5, 3.5), breaks = seq(0.5, 3.5, 0.5), labels = c("", "1 min", "", "5 min", "", "20 min", ""))