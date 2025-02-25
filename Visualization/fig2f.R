library(openxlsx)
library(ggplot2)

setwd("G:/AI_XuLab_Data/Radial-C/figure2/Fig2f/")

distance <- read.xlsx('distance.xlsx', colNames = F)
colnames(distance) <- c("layer", "distance", "value")
distance$value <- round(distance$value * 100, 2)

distance$layer <- factor(distance$layer, levels = c("-5", "-4", "-3", "-2", "-1", "0", "1", "2", "3", "4", "5"))
distance$distance <- factor(distance$distance, levels = rev(c("400kb-600kb", "600kb-800kb", "800kb-1M")), labels = rev(c("400 kb - 600 kb", "600 kb - 800 kb", "800 kb - 1 Mb")))

ggplot(distance, aes(x = layer, y = value, fill = distance)) +
  geom_line(aes(x = layer, y = value, group = distance, color = distance), linewidth = 2, alpha = 1) +
  geom_point(aes(x = layer, y = value, group = distance, fill = distance), size = 1.5, alpha = 0.7) +
  labs(title = "TAD borders", x = "Δ(layer)", y = "% TADs") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(colour = "black", linewidth = 0.5),
        axis.ticks = element_line(colour = "black", size = 0.5),
        axis.text.x = element_text(size = 17, colour = "black", angle = 0, hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(size = 17, colour = "black"),
        axis.title.x = element_text(size = 18, color = "black", hjust = 0.5),
        axis.title.y = element_text(size = 18, color = "black", hjust = 0.5),
        plot.title = element_text(colour = "black", size = 18, vjust = 0.5, hjust = 0.5, face = "bold"),
        legend.position = c(0.5, 0.14),
        legend.title = element_blank(),
        legend.text = element_text(size = 16),
        legend.background = element_rect(fill = "transparent")) +
  scale_fill_manual(values = c("#F18E2B", "#76B7B1", "#4E79A7")) +
  scale_color_manual(values = c("#F18E2B", "#76B7B1", "#4E79A7")) +
  scale_y_continuous(limits = c(0, 15), breaks = seq(0, 15, 5), expand = c(0.00, 0.003))

ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig2f.png", width = 4.5, height = 4.3, dpi = 600)
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig2f.pdf", width = 4.5, height = 4.3, dpi = 600)