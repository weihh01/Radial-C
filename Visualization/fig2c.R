library(openxlsx)
library(ggplot2)

setwd("G:/AI_XuLab_Data/Radial-C/figure2/Fig2c/")
TADratio <- read.xlsx('800kb-1M.xlsx', colNames = F)
colnames(TADratio) <- c("layer", "anchor", "value")
TADratio$value <- round(TADratio$value * 100, 2)
setwd("G:/AI_XuLab_Data/Radial-C/figure2/Fig2c/dendity/")
one <- read.table("1D_600kb.bed", col.names = c("layer", "nothing", "type"))
two <- read.table("2D_600kb.bed", col.names = c("layer", "nothing", "type"))
TADdensity <- rbind.data.frame(one, two)
TADdensity <- TADdensity[, -c(2)]
TADdensity$type <- factor(TADdensity$type, levels = c("one", "two"), labels = c("1D_score", "2D_score"))

ggplot() +
  geom_bar(data = TADratio, aes(x = layer, y = value, fill = anchor, color = anchor), width = 0.8, position = "dodge", stat = "identity", alpha = 0.9, size = 0) +
  coord_cartesian(xlim = c(-5.5, 5.5)) +
  labs(title = "TAD borders", x = "Δ(layer)", y = "% TADs") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        axis.line.x = element_blank(),
        axis.line.y = element_line(linetype = 1, color = "black"),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_line(colour = "black", size = 0.5),
        axis.text.x = element_text(size = 17, colour = "black", angle = 0, hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(size = 17, colour = "black"),
        axis.title.x = element_text(size = 18, color = "black", hjust = 0.5),
        axis.title.y = element_text(size = 18, color = "black", hjust = 0.5),
        plot.title = element_text(colour = "black", size = 18, vjust = 0.5, hjust = 0.5, face = "bold"),
        legend.position = c(0.82, 0.85), legend.title = element_blank(), legend.text = element_text(size = 17)) +
  scale_fill_manual(values = c("#3B7BB7", "#A22C2C"), labels = c("1D score", "2D score")) +
  scale_color_manual(values = c("#3B7BB7", "#A22C2C"), labels = c("1D score", "2D score")) +
  scale_y_continuous(limits = c(0, 15), breaks = seq(0, 15, 5), expand = c(0.00, 0)) +
  scale_x_continuous(expand = c(0.01, 0.01), breaks = seq(-5, 5, 1))

ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig2c.png", width = 5, height = 4.3, dpi = 600)