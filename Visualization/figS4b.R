library(openxlsx)
library(ggplot2)
library(reshape2)

setwd("G:/AI_XuLab_Data/Radial-C/figureS4/4b/")

df <- read.table("delta.bed", header = T, fill = T)
df$variable <- factor(df$variable, levels = c("1min", "5min", "20min"), labels = c("1 min", "5 min", "20 min"))

ggplot(df, aes(x = value, fill = variable)) +
  geom_density(aes(fill = variable, color = variable), alpha = 0.3, size = 0.5, linetype = "solid") +
  theme_bw() +
  scale_fill_manual(values = c("#386CAF", "#fc9533", "#9f79d3")) +
  scale_color_manual(values = c("#386CAF", "#fc9533", "#9f79d3")) +
  geom_vline(xintercept = c(0.0918, -0.0918), color = '#708090', linetype = 'dashed', lwd = 0.5) +
  theme(plot.title = element_text(size = 16, vjust = 0.5, hjust = 0.5),
        legend.title = element_blank(),
        legend.text = element_text(size = 15),
        legend.position = c(0.25, 0.75),
        legend.key.size = unit(0.4, 'cm'),
        axis.line = element_line(size = 0, color = "black"),
        axis.text.x = element_text(size = 15, vjust = 0.5, hjust = 0.5, colour = "black"),
        axis.text.y = element_text(size = 15, vjust = 0.5, hjust = 0.5, colour = "black"),
        axis.title.x = element_text(size = 16, vjust = 0.5, hjust = 0.5, colour = "black"),
        axis.title.y = element_text(size = 16, vjust = 1.5, hjust = 0.5, colour = "black"),
        panel.border = element_rect(fill = NA, size = 1, color = 'black'),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank()) +
  labs(title = ' ', x = "Δ(2D score)", y = 'Density') +
  scale_x_continuous(limits = c(-1, 1), breaks = seq(-1, 1, 0.5))

ggsave(filename = "G:/AI_XuLab_Data/Radial-C/figS4b.png", height = 3, width = 4.8, dpi = 600)
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/figS4b.pdf", height = 3, width = 4.8, dpi = 600, device = cairo_pdf)