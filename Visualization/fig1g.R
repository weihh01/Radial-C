library(ggplot2)
library(openxlsx)
library(reshape2)

setwd("G:/AI_XuLab_Data/Radial-C/figure1/1g")
score <- read.table("cis_one_0.95.bed", header = T)
df <- melt(score, id.vars = "distance")
df$line <- rep(c("solid", "dash", "solid", "dash", "solid", "dash"), each = 50)
ggplot(data = df) +
  geom_smooth(aes(x = distance, y = value, group = variable, color = variable, linetype = variable), method = "loess", se = FALSE, linewidth = 0.9) +
  geom_point(aes(x = distance, y = value, group = variable, color = variable, shape = variable), size = 3, alpha = 0.7) +
  theme(legend.key = element_blank()) +
  theme_bw() +
  labs(x = "1D score\nPeriphery Centroid", y = "Normalized counts") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(legend.title = element_blank(), legend.key = element_blank()) +
  theme(legend.text = element_text(size = 15), legend.text.align = 0, legend.key.width = unit(1.7, "cm")) +
  theme(plot.margin = unit(c(.1, .3, .1, .1), 'inches'),
        plot.title = element_text(size = 15, hjust = .5),
        panel.grid = element_blank(),
        axis.ticks = element_line(colour = "black", linewidth = 0.5),
        axis.line = element_line(colour = "black", linewidth = 0.5),
        panel.border = element_blank(),
        legend.position = c(0.7, 0.7),
        axis.text.x = element_text(size = 16, colour = 'black'),
        axis.text.y = element_text(size = 16, colour = 'black')) +
  theme(axis.title = element_text(size = 17)) +
  guides(color = guide_legend(override.aes = list(size = 3))) +
  scale_linetype_manual(values = c("solid", "dashed", "solid", "dashed", "solid", "dashed"),
                        breaks = c("MNase_1min_rep1", "MNase_1min_rep2", "MNase_5min_rep1", "MNase_5min_rep2", "MNase_20min_rep1", "MNase_20min_rep2"),
                        labels = c("1 min rep1", "1 min rep2", "5 min rep1", "5 min rep2", "20 min rep1", "20 min rep2")) +
  scale_shape_manual(values = c(16, 17, 16, 17, 16, 17),
                     breaks = c("MNase_1min_rep1", "MNase_1min_rep2", "MNase_5min_rep1", "MNase_5min_rep2", "MNase_20min_rep1", "MNase_20min_rep2"),
                     labels = c("1 min rep1", "1 min rep2", "5 min rep1", "5 min rep2", "20 min rep1", "20 min rep2")) +
  scale_colour_manual(values = c("#386CAF", "#386CAF", "#fc9533", "#fc9533", "#9f79d3", "#9f79d3"),
                      breaks = c("MNase_1min_rep1", "MNase_1min_rep2", "MNase_5min_rep1", "MNase_5min_rep2", "MNase_20min_rep1", "MNase_20min_rep2"),
                      labels = c("1 min rep1", "1 min rep2", "5 min rep1", "5 min rep2", "20 min rep1", "20 min rep2")) +
  theme(text = element_text(size = 15)) +
  theme(legend.spacing.y = unit(2, 'cm')) +
  guides(fill = guide_legend(byrow = TRUE)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(
    breaks = c(0, 10, 20, 30, 40, 50),
    labels = c("0", "0.2", "0.4", "0.6", "0.8", "1.0")) +
  scale_y_continuous(limits = c(0, 255),
                     breaks = seq(0, 300, 50), expand = c(0.03, 0.03)) +
  theme(legend.background = element_rect(fill = rgb(1, 1, 1, alpha = 0.001), colour = NA))

ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig1g.png", width = 3.5, height = 4.5, dpi = 600)
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig1g.pdf", width = 3.5, height = 4.5, dpi = 600)