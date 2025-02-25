library(ggplot2)
library(openxlsx)
library(reshape2)

setwd("G:/AI_XuLab_Data/Radial-C/figureS4/4d/")
aaa <- read.xlsx("top500.xlsx")
aaa$type <- factor(aaa$type, levels = c("A-A", "B-B", "A-B/B-A"), labels = c("A-A", "B-B", "A-B"))
aaa$dataset <- factor(aaa$dataset, levels = c("top500_in5", "top500_out5"))
ggplot(data = aaa, mapping = aes(x = dataset, y = count, fill = type)) +
  geom_bar(stat = "identity", position = "stack", width = 0.9) +
  #scale_fill_manual(name="",values=c("#0074B3","#8B96AD","#D9DEE7"))+
  scale_fill_manual(name = "", values = c("#ff0000", "#281713", "#00a0ff")) +
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
  scale_x_discrete(labels = c("proximal trans", "distal trans")) +
  scale_y_continuous(expand = c(0, 0), breaks = c(0, 0.50, 1.00), labels = c("0.0", "0.5", "1.0")) +
  theme(legend.position = "right", legend.title = element_text(size = 15), legend.text = element_text(size = 14))

ggsave(filename = "G:/AI_XuLab_Data/Radial-C/figS4d.png", width = 5, height = 3.3, dpi = 600)
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/figS4d.pdf", width = 5, height = 3.3, dpi = 600, device = cairo_pdf)