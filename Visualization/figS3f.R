library(ggplot2)
library(openxlsx)

setwd("G:/AI_XuLab_Data/Radial-C/figureS3/3f/")
aaa <- read.xlsx("loop_PC1_layer3.xlsx")
ggplot(data = aaa, mapping = aes(x = dataset, y = count, fill = type)) +
  geom_bar(stat = "identity", width = 0.9, position = "stack") +
  theme_bw() +
  scale_fill_manual(name = "", values = c("#9b2226", "#BF7173", "#E8CCCD")) +
  labs(x = "Layer", y = "% Chromatin loops", title = NULL) +
  guides(fill = guide_legend(ncol = 1)) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        axis.ticks = element_line(color = "black", size = 0.5),
        axis.line = element_line(color = "black", size = 0.5),
        axis.text.x = element_text(size = 15, colour = "black", angle = 0, hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(size = 15, colour = "black"),
        axis.title.x = element_text(size = 15, color = "black", hjust = 0.5),
        axis.title.y = element_text(size = 15, color = "black", hjust = 0.5),
        plot.title = element_text(colour = "black", face = "bold",
                                  size = 15, vjust = 2, hjust = 0)) +
  scale_x_discrete(labels = c("1-10", "11-30", "31-50")) +
  scale_y_continuous(expand = c(0, 0), breaks = c(0, 0.50, 1.00), labels = c("0", "50", "100")) +
  theme(legend.position = "right", legend.title = element_text(size = 15), legend.text = element_text(size = 14))

ggsave(filename = "G:/AI_XuLab_Data/Radial-C/figS3ar.png", width = 5, height = 3.3, dpi = 600)