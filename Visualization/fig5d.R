library(ggplot2)
library(openxlsx)
library(reshape2)

setwd("G:/AI_XuLab_Data/Radial-C/figure5/5d/")
xx <- read.xlsx('count.xlsx', colNames = F)
xx <- xx[order(xx$X2, decreasing = T),]
xx$X1 <- factor(xx$X1,
                levels = c("static-static", "inward-static", "outward-static", "inward-outward", "inward-inward", "outward-outward"),
                labels = c("static-static", "static-inward", "static-outward", "inward-outward", "inward-inward", "outward-outward"))
ggplot(xx, aes(x = X1, y = X2)) +
  geom_bar(position = "dodge", stat = "identity", fill = "#386CAF", width = 0.9) +
  theme_bw() +
  labs(title = "CTCF-CTCF", x = NULL, y = "Counts") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        plot.title = element_text(size = 16, angle = 0, vjust = 0.5, hjust = 0.5),
        axis.title.y = element_text(colour = "black", size = 16, hjust = 0.5, vjust = 1, angle = 90),
        axis.text.x = element_text(size = 16, angle = 30, vjust = 0.95, hjust = 0.95),
        axis.text.y = element_text(size = 16, colour = "black", angle = 0, hjust = 1),
        axis.line = element_line(size = 0.5, colour = "black"),
        axis.ticks = element_line(colour = "black", size = 0.5),
        axis.ticks.x = element_blank(),
        axis.line.x = element_blank(),
        plot.margin = unit(c(0.4, 0.2, 0.2, 0.2), "inches"),
        legend.text = element_text(size = 15),
        legend.position = "none",
        legend.background = element_rect(fill = "transparent")) +
  scale_y_continuous(name = "Counts", breaks = seq(0, 4000, 1500), expand = c(0, 0))
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig5d.png", width = 4.95, height = 3.1, dpi = 600)