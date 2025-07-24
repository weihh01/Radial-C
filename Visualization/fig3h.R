library(ggplot2)
library(openxlsx)
library(reshape2)

aaa <- read.xlsx("loop_E-P_layer3.xlsx")
aaa_m <- melt(aaa)
colnames(aaa_m) <- c("layer", "type", "ratio")
aaa_m$type <- factor(aaa_m$type, levels = c("others", "struc-struc", "P-P", "E-E", "E-P"), labels = c("others", "Structural", "Pro-Pro", "Enh-Enh", "Enh-Pro"))
aaa_m$layer <- factor(aaa_m$layer, levels = c("MNase-1min-5min-20min_10", "MNase-1min-5min-20min_11-30", "MNase-1min-5min-20min_31"), labels = c("1-10", "11-30", "31-50"))
aaa_m <- aaa_m[aaa_m$type != "others",]

ggplot(data = aaa_m, mapping = aes(x = layer, y = ratio, fill = type)) +
  geom_bar(stat = "identity", position = "stack", width = 0.85) +
  scale_fill_manual(name = "", values = c("#A67BB0", "#7FC87F", "#386CAF", "#EC8C49")) +
  labs(x = "Layer", y = "% Loop types", title = NULL) +
  guides(fill = guide_legend(ncol = 1)) +
  geom_text(aes(label = paste0(round(ratio * 100, 1))), position = position_stack(vjust = 0.5), size = 4.5, colour = "black") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_line(color = "black", linewidth = 0.5),
        axis.line.x = element_blank(),
        axis.line.y = element_line(color = "black", linewidth = 0.5),
        axis.text.x = element_text(size = 14, colour = "black", angle = 0, hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(size = 14, colour = "black"),
        axis.title.x = element_text(size = 14, color = "black", hjust = 0.5),
        axis.title.y = element_text(size = 14, color = "black", hjust = 0.5),
        plot.title = element_text(colour = "black", face = "bold",
                                  size = 14, vjust = 2, hjust = 0)) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 0.75), breaks = seq(0, 1, 0.25), labels = seq(0, 1, 0.25) * 100) +
  theme(legend.position = "right", legend.title = element_text(size = 14), legend.text = element_text(size = 13))

ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig3h.png", width = 4.4, height = 3.3, dpi = 600)