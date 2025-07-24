library(openxlsx)
library(ggplot2)
library(reshape2)

setwd("G:/AI_XuLab_Data/Radial-C/figure5/5e/")

#static----
aaa <- read.table("nonenone.bed", header = F, fill = T)
colnames(aaa) <- c("anchor1", "anchor2", "type")
ggplot(aaa, aes(x = anchor1, y = anchor2)) +
  geom_point(aes(color = type), size = 1.3, alpha = 0.8, shape = 16) +
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
        plot.title = element_text(colour = "black", size = 16, hjust = 0.5, vjust = 0.5),
        plot.margin = unit(c(0.3, 0.1, 0.1, 0.1), "lines"),
        legend.title = element_blank(),
        legend.position = c(0.3, 0.8),
        legend.background = element_rect(fill = "transparent", color = NA),
        legend.text = element_text(colour = "black", size = 14)) +
  guides(color = guide_legend(override.aes = list(size = 1.5))) +
  labs(title = "2D score", x = "Static CTCF", y = "Static-static\nStatic CTCF", size = 14) +
  scale_x_continuous(lim = c(0, 1), breaks = seq(0, 1, 0.5), expand = c(0.01, 0.01)) +
  scale_y_continuous(lim = c(0, 1), breaks = seq(0, 1, 0.5), expand = c(0.01, 0.01)) +
  coord_fixed(ratio = 1, xlim = c(0, 1), ylim = c(0, 1)) +
  scale_color_manual(values = c("#DB9052", "#386CAF"))
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig5e_static.png", width = 2.8, height = 2.6, dpi = 600)
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig5e_static.pdf", width = 2.8, height = 2.6, dpi = 600, device = cairo_pdf)


#inward----
aaa <- read.table("noneup.bed", header = F, fill = T)
colnames(aaa) <- c("anchor1", "anchor2", "type")
ggplot(aaa, aes(x = anchor1, y = anchor2)) +
  geom_point(aes(color = type), size = 1.3, alpha = 0.8, shape = 16) +
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
        plot.title = element_text(colour = "black", size = 16, hjust = 0.5, vjust = 0.5),
        plot.margin = unit(c(0.3, 0.1, 0.1, 0.1), "lines"),
        legend.title = element_blank(),
        legend.position = "none",
        legend.text = element_text(colour = "black", size = 14)) +
  guides(color = guide_legend(override.aes = list(size = 1.5))) +
  labs(title = "", x = "Static CTCF", y = "Static-inward\nInward CTCF", size = 14) +
  scale_x_continuous(lim = c(0, 1), breaks = seq(0, 1, 0.5), expand = c(0.01, 0.01)) +
  scale_y_continuous(lim = c(0, 1), breaks = seq(0, 1, 0.5), expand = c(0.01, 0.01)) +
  coord_fixed(ratio = 1, xlim = c(0, 1), ylim = c(0, 1)) +
  scale_color_manual(values = c("#DB9052", "#386CAF"))
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig5e_inward.png", width = 2.8, height = 2.6, dpi = 600)
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig5e_inward.pdf", width = 2.8, height = 2.6, dpi = 600, device = cairo_pdf)

#outward----
aaa <- read.table("nonedown.bed", header = F, fill = T)
colnames(aaa) <- c("anchor1", "anchor2", "type")
ggplot(aaa, aes(x = anchor1, y = anchor2)) +
  geom_point(aes(color = type), size = 1.3, alpha = 0.8, shape = 16) +
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
        plot.title = element_text(colour = "black", size = 16, hjust = 0.5, vjust = 0.5),
        plot.margin = unit(c(0.3, 0.1, 0.1, 0.1), "lines"),
        legend.title = element_blank(),
        legend.position = "none",
        legend.text = element_text(colour = "black", size = 14)) +
  guides(color = guide_legend(override.aes = list(size = 1.5))) +
  labs(title = "", x = "Static CTCF", y = "Static-outward\nOutward CTCF", size = 14) +
  scale_x_continuous(lim = c(0, 1), breaks = seq(0, 1, 0.5), expand = c(0.01, 0.01)) +
  scale_y_continuous(lim = c(0, 1), breaks = seq(0, 1, 0.5), expand = c(0.01, 0.01)) +
  coord_fixed(ratio = 1, xlim = c(0, 1), ylim = c(0, 1)) +
  scale_color_manual(values = c("#DB9052", "#386CAF"))


ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig5e_outward.png", width = 2.8, height = 2.6, dpi = 600)
ggsave(filename = "G:/AI_XuLab_Data/Radial-C/fig5e_outward.pdf", width = 2.8, height = 2.6, dpi = 600, device = cairo_pdf)