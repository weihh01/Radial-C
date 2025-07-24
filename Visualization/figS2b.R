library(ggplot2)
library(openxlsx)

setwd("G:/AI_XuLab_Data/Radial-C/figureS2/FigS2b")

one_scale_50 <- read.table("one_scale_10_layer50_0.95.count.bed", header = F)
two_scale_50 <- read.table("two_scale_10_OE_0.95_50.count.bed", header = T)
colnames(one_scale_50) <- colnames(two_scale_50)
combine_scale <- rbind(one_scale_50, two_scale_50)
combine_scale$type <- rep(c("one", "two"), each = 50)

vulome <- read.xlsx('vulome.xlsx', colNames = T)
ggplot() +
  geom_bar(data = combine_scale, aes(x = layer, y = count, fill = type, color = type), width = 0.85, position = "dodge", stat = "identity", alpha = 0.9, size = 0) +
  coord_cartesian(xlim = c(0, 50.5)) +
  geom_line(data = vulome, aes(x = layer, y = count / 2), color = "#fc9533", size = 1.5, alpha = 0.7) +
  geom_point(data = vulome, aes(x = layer, y = count / 2), size = 1, alpha = 0.7) +
  labs(title = "", x = "Layer", y = "Count of bins") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        #panel.border = element_rect(fill = NA, size = 1, color = 'black'),
        axis.line.x = element_blank(),
        axis.line.y = element_line(linetype = 1, color = "black"),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_line(colour = "black", size = 0.5),
        axis.text.x = element_text(size = 15, colour = "black", angle = 0, hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(size = 15, colour = "black"),
        axis.title.x = element_text(size = 16, color = "black", hjust = 0.5),
        axis.title.y = element_text(size = 16, color = "black", hjust = 0.5),
        plot.title = element_text(colour = "black", size = 16, vjust = 0.5, hjust = 0.5, face = "bold"),
        legend.position = c(0.7, 0.85), legend.title = element_blank(), legend.text = element_text(size = 15)) +
  scale_fill_manual("Counts", values = c("#3B7BB7", "#A22C2C"), labels = c("1D layer", "2D layer")) +
  scale_color_manual("Counts", values = c("#3B7BB7", "#A22C2C"), labels = c("1D layer", "2D layer")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 4000), breaks = seq(0, 4000, 1000),
                     sec.axis = sec_axis(~. * 2, name = "Layer volume (a.u.)", breaks = seq(0, 4000, 1000) * 2)) +
  scale_x_continuous(breaks = c(1, 10, 20, 30, 40, 50), expand = c(0.0, 0.0))

ggsave(filename = "G:/AI_XuLab_Data/Radial-C/figS2b.pdf", width = 10, height = 4.3, dpi = 600, device = cairo_pdf)
#ggsave(filename = "G:/AI_XuLab_Data/Radial-C/figS2b.png", width = 10, height = 4, dpi = 600)
