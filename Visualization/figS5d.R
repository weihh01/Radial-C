library(ggplot2)
library(openxlsx)
library(reshape2)

setwd("G:/AI_XuLab_Data/Radial-C/figureS6/s6d/")

score <- read.table("cis.bed", header = T)
df <- melt(score, id.vars = "distance")
ggplot(data = df, aes(x = distance, y = value, group = variable, color = variable)) +
  geom_point() +
  ylim(0.6, 1.8) +
  geom_smooth(method = "loess") +
  theme(legend.key = element_blank()) +
  theme_bw() +
  labs(x = "Normalized GPSeq score layers", y = "Normalized count of Radial Hi-C") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(legend.title = element_blank(), legend.key = element_blank()) +
  theme(legend.text = element_text(size = 12)) +
  theme(legend.position = c(0.3, 0.8)) +
  theme(axis.title = element_text(size = 14)) +
  theme(legend.key = element_blank()) +
  scale_colour_hue(breaks = c("CTCF_degron", "Flavo", "TPA"), labels = c("CTCF_degron_dTAG/DMSO", "Flavo_Flavo/DMSO", "TPA_TPA/DMSO"))

df = df[!df$variable %in% "Flavo",]
ggplot(data = df) +
  geom_smooth(aes(x = distance, y = value, group = variable, color = variable), method = "loess", se = FALSE, linewidth = 1) +
  geom_point(aes(x = distance, y = value, group = variable, color = variable), size = 3, alpha = 0.7, shape = 16) +
  geom_hline(yintercept = c(1), color = '#708090', linetype = 'dashed', lwd = 0.5) +
  theme(legend.key = element_blank()) +
  theme_bw() +
  labs(title = "Counts per layer", x = "Radial layer", y = "Treatment / Control") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(legend.title = element_blank(), legend.key = element_blank()) +
  theme(legend.text = element_text(size = 15), legend.text.align = 0, legend.key.width = unit(1.7, "cm")) +
  theme(plot.margin = unit(c(.1, .3, .1, .1), 'inches'),
        plot.title = element_text(size = 17, hjust = .5),
        panel.grid = element_blank(),
        axis.ticks = element_line(colour = "black", linewidth = 0.5),
        axis.line = element_line(colour = "black", linewidth = 0.5),
        panel.border = element_blank(),
        legend.position = c(0.7, 0.95),
        axis.text.x = element_text(size = 16, colour = 'black'),
        axis.text.y = element_text(size = 16, colour = 'black')) +
  theme(axis.title = element_text(size = 17)) +
  guides(color = guide_legend(override.aes = list(size = 3))) +
  scale_linetype_manual(values = c("#fc9533", "#9f79d3"),
                        breaks = c("CTCF_degron", "TPA"),
                        labels = c("CTCF degron", "TPA")) +
  scale_colour_manual(values = c("#fc9533", "#9f79d3"),
                      breaks = c("CTCF_degron", "TPA"),
                      labels = c("CTCF degron", "TPA")) +
  theme(text = element_text(size = 15)) +
  theme(legend.spacing.y = unit(2, 'cm')) +
  guides(fill = guide_legend(byrow = TRUE)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(
    breaks = c(1, 10, 20, 30, 40, 50)) +
  scale_y_continuous(limits = c(0.5, 1.6),
                     breaks = seq(0.5, 1.6, 0.5), expand = c(0.05, 0.05)) +
  theme(legend.background = element_rect(fill = rgb(1, 1, 1, alpha = 0.001), colour = NA))

ggsave(filename = "G:/AI_XuLab_Data/Radial-C/figS5d.png", width = 5, height = 2.8, dpi = 600)
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/figS5d.pdf", width = 5, height = 2.8, dpi = 600, device = cairo_pdf)