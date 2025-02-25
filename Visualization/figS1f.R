library(ggplot2)
setwd("G:/AI_XuLab_Data/Radial-C/figureS1/FigS1/1f_new/")

chrX <- read.table("G1_G2_chrX.bed", header = T)
pcc_chrx <- round(cor(chrX[1:2], use = 'all.obs', method = 'pearson')[1, 2], 2)
ggplot(chrX, aes(x = G1, y = G2)) +
  geom_point(color = "#386CAF", size = 0.8, alpha = 0.6, shape = 16) +
  theme_bw() +
  theme_classic() +
  theme(panel.border = element_rect(colour = "black", fill = NA, size = 1),
        axis.line.x = element_line(linetype = 0.5, color = "black", size = 0),
        axis.line.y = element_line(linetype = 0.5, color = "black", size = 0),
        axis.ticks.x = element_line(color = "black", size = 0.5),
        axis.ticks.y = element_line(color = "black", size = 0.5),
        axis.title.x = element_text(size = 15, hjust = 0.5),
        axis.title.y = element_text(size = 15),
        axis.text.x = element_text(size = 15, colour = 'black'),
        axis.text.y = element_text(size = 15, colour = 'black'),
        plot.title = element_text(colour = "black", size = 16, hjust = 0.5, vjust = 2, face = "bold"),
        plot.margin = unit(c(0.5, 1, 0.5, 0.5), "lines")) +
  labs(title = "1D score (chrX)", x = "Hap1", y = "Hap2", size = 14) +
  scale_x_continuous(lim = c(0, 1), breaks = c(0, 0.5, 1), expand = c(0.01, 0.01)) +
  scale_y_continuous(lim = c(0, 1), breaks = c(0, 0.5, 1), expand = c(0.01, 0.01)) +
  coord_fixed(ratio = 1, xlim = c(0, 1), ylim = c(0, 1)) +
  annotate("text", x = 0.35, y = 0.95, label = paste0("Pearson's r = ", pcc_chrx), color = "#A65628", size = 5)
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/figS1f_new_chrX.png", width = 3.5, height = 3.5, dpi = 600)

nochrX <- read.table("G1_G2_nochrX.bed", header = T)
pcc_nochrX <- round(cor(nochrX[1:2], use = 'all.obs', method = 'pearson')[1, 2], 2)
ggplot(nochrX, aes(x = G1, y = G2)) +
  geom_point(color = "#386CAF", size = 0.8, alpha = 0.6, shape = 16) +
  theme_bw() +
  theme_classic() +
  theme(panel.border = element_rect(colour = "black", fill = NA, size = 1),
        axis.line.x = element_line(linetype = 0.5, color = "black", size = 0),
        axis.line.y = element_line(linetype = 0.5, color = "black", size = 0),
        axis.ticks.x = element_line(color = "black", size = 0.5),
        axis.ticks.y = element_line(color = "black", size = 0.5),
        axis.title.x = element_text(size = 15, hjust = 0.5),
        axis.title.y = element_text(size = 15),
        axis.text.x = element_text(size = 15, colour = 'black'),
        axis.text.y = element_text(size = 15, colour = 'black'),
        plot.title = element_text(colour = "black", size = 16, hjust = 0.5, vjust = 2, face = "bold"),
        plot.margin = unit(c(0.5, 1, 0.5, 0.5), "lines")) +
  labs(title = "1D score (no chrX)", x = "Hap1", y = "Hap2", size = 14) +
  scale_x_continuous(lim = c(0, 1), breaks = c(0, 0.5, 1), expand = c(0.01, 0.01)) +
  scale_y_continuous(lim = c(0, 1), breaks = c(0, 0.5, 1), expand = c(0.01, 0.01)) +
  coord_fixed(ratio = 1, xlim = c(0, 1), ylim = c(0, 1)) +
  annotate("text", x = 0.35, y = 0.95, label = paste0("Pearson's r = ", pcc_nochrX), color = "#A65628", size = 5)
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/figS1f_new_nochrX.png", width = 3.5, height = 3.5, dpi = 600)