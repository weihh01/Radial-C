library(ggplot2)
library(openxlsx)
library(reshape2)

setwd("G:/AI_XuLab_Data/Radial-C/figureS4/4e/")
aaa <- read.xlsx("top500.xlsx")
aaa$type <- factor(aaa$type, levels = c("H3K27ac", "H3K9me3H3K27me3", "others"), labels = c("H3K27ac", "H3K9me3/H3K27me3", "Others"))
aaa$dataset <- factor(aaa$dataset, levels = c("AA", "BB"), labels = c("A-A", "B-B"))

ggplot(data = aaa, mapping = aes(x = dataset, y = count, fill = type)) +
  geom_bar(stat = "identity", position = "stack", width = 0.9) +
  scale_fill_manual(name = "", values = c("#ECBC35", "#284F7A", "#A5A5A5")) +
  #scale_fill_manual(name="",values=c("#F0803D","#4473B8","#A5A5A5"))+
  labs(x = "", y = "Frequency", title = NULL) +
  guides(fill = guide_legend(ncol = 1)) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        axis.ticks = element_line(color = "black", linewidth = 0.5),
        axis.line = element_line(color = "black", linewidth = 0.5),
        axis.text.x = element_text(size = 15, colour = "black", angle = 0, hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(size = 15, colour = "black"),
        axis.title.x = element_text(size = 15, color = "black", hjust = 0.5),
        axis.title.y = element_text(size = 15, color = "black", hjust = 0.5),
        plot.title = element_text(colour = "black", face = "bold",
                                  size = 15, vjust = 2, hjust = 0)) +
  scale_x_discrete(labels = c("A-A", "B-B")) +
  scale_y_continuous(expand = c(0, 0), breaks = c(0, 0.50, 1.00), labels = c("0.0", "0.5", "1.0")) +
  theme(legend.position = "right", legend.title = element_text(size = 15), legend.text = element_text(size = 14))

ggsave(filename = "G:/AI_XuLab_Data/Radial-C/figS4e.png", width = 6.5, height = 3.3, dpi = 600)