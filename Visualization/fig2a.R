setwd('G:/AI_XuLab_Data/Radial-C/figure2/Fig2a/')
library(openxlsx)
library(ggsignif)
library(ggplot2)
library(reshape2)
df = read.xlsx('count.xlsx')

cbPalette <- c("#E69F00", "#CC79A7", "#56B4E9", "#009E73", "#CC79A7", "#F0E442", "#999999", "#0072B2", "#D55E00")
cbPalette <- c("#3F73B2", "#5B8CB8", "#7F9FC1", "#9CAEB4", "#BCC3C2", "#AEB7C8")
cbPalette <- c("#A67BB0", "#86A6CE", "#AAD5A8", "#AFA476", "#D3AFAC", "#D3D3D3")
cbPalette <- c("#C34E52", "#fc9533", "#9f79d3", "#386CAF", "#7FC87F", "#C29B39")
border <- c("#BCC3C2", "#BCC3C2", "#BCC3C2", "#BCC3C2", "#BCC3C2", "#BCC3C2")
ggplot(df, aes(x = variable, y = value)) +
  geom_boxplot(size = 0.8, fill = "white", outlier.shape = NA) +
  geom_jitter(alpha = 1, aes(color = variable, fill = variable), width = 0.1, shape = 21, size = 2.6) +
  scale_fill_manual(values = cbPalette) +
  scale_colour_manual(values = border) +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  theme(axis.line = element_line(colour = "black")) +
  theme(axis.text.x = element_text(hjust = 0.5, vjust = 0.5, colour = "black", size = 16, angle = 0),
        axis.text.y = element_text(size = 16, face = "plain", colour = "black", angle = 0),
        axis.title.x = element_text(size = 17, face = "plain", colour = "black", vjust = 0.5, hjust = 0.5),
        axis.title.y = element_text(size = 17, face = "plain", colour = "black", vjust = 1, hjust = 0.5),
        panel.border = element_blank(),
        axis.ticks = element_line(colour = "black", size = 0.5),
        legend.position = "none",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.margin = unit(c(0.1, 0.1, 0.5, 0.1), "lines"),
        plot.title = element_text(colour = "black", face = "plain", size = 18, vjust = 8, hjust = 1)) +
  theme(legend.position = "none") +
  scale_x_discrete(breaks = c("N", "N_1", "N_2", "N_3", "N_4", "N_5"), labels = c("0", "1", "2", "3", "4", "5")) +
  labs(title = NULL, x = "Δ(interval)", y = "Normalized counts", size = 21)

ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig2a.png", width = 4.1, height = 3.8, dpi = 600)
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig2a.pdf", width = 4.1, height = 3.8, dpi = 600)