library(ggplot2)
setwd("G:/AI_XuLab_Data/Radial-C/figureS1/FigS1/FigS1i/")

#1min----
a1min <- read.table("MNase-1min.bed", header = F)
colnames(a1min) <- c("fragment1", "fragment2")

p1 = ggplot(a1min, aes(x = fragment1, y = fragment2)) +
  geom_bin2d(bins = 40) +
  aes(fill = after_stat(count / max(count))) +
  scale_fill_gradient2(name = "Normalized\nfrequency", low = "white", mid = "#3F73B2", high = "#19477D", midpoint = 0.5, limits = c(0, 1), breaks = c(0, 0.5, 1)) +
  coord_cartesian(xlim = c(0, 1), ylim = c(0, 1)) +
  scale_x_continuous(expand = c(0.003, 0.003), breaks = c(0, 0.5, 1)) +
  scale_y_continuous(expand = c(0.003, 0.003), breaks = c(0, 0.5, 1)) +
  labs(x = "Fragment 1 (1 min)", y = "Fragment 2 (1 min)", title = "1D score") +
  theme_bw(base_size = 12) +
  theme(panel.border = element_rect(colour = "black", fill = NA, size = 0.7),
        axis.line.x = element_line(linetype = 0.5, color = "black", size = 0),
        axis.line.y = element_line(linetype = 0.5, color = "black", size = 0),
        axis.ticks.x = element_line(color = "black", size = 0.5),
        axis.ticks.y = element_line(color = "black", size = 0.5),
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold", margin = margin(b = 5)),
        axis.title.x = element_text(margin = margin(t = 5), colour = 'black', size = 13),
        axis.title.y = element_text(margin = margin(r = 5), colour = 'black', size = 13),
        axis.text.x = element_text(size = 12, colour = 'black'),
        axis.text.y = element_text(size = 12, colour = 'black'),
        panel.grid = element_blank(),
        legend.title = element_text(size = 11, vjust = 0.9, hjust = 0),
        legend.text = element_text(colour = "black", size = 11),
        plot.margin = unit(c(0.1, 0.1, 0.1, 0.01), "inches"),
        legend.position = "right",
        legend.key.height = unit(0.4, "cm"),
        legend.key.width = unit(0.6, "cm")) +
  coord_fixed(ratio = 1)

#5min----
a5min <- read.table("MNase-5min.bed", header = F)
colnames(a5min) <- c("fragment1", "fragment2")

p2 = ggplot(a5min, aes(x = fragment1, y = fragment2)) +
  geom_bin2d(bins = 40) +
  aes(fill = after_stat(count / max(count))) +
  scale_fill_gradient2(name = "Normalized\nfrequency", low = "white", mid = "#3F73B2", high = "#19477D", midpoint = 0.5, limits = c(0, 1), breaks = c(0, 0.5, 1)) +
  coord_cartesian(xlim = c(0, 1), ylim = c(0, 1)) +
  scale_x_continuous(expand = c(0.003, 0.003), breaks = c(0, 0.5, 1)) +
  scale_y_continuous(expand = c(0.003, 0.003), breaks = c(0, 0.5, 1)) +
  labs(x = "Fragment 1 (5 min)", y = "Fragment 2 (5 min)", title = "1D score") +
  theme_bw(base_size = 12) +
  theme(panel.border = element_rect(colour = "black", fill = NA, size = 0.7),
        axis.line.x = element_line(linetype = 0.5, color = "black", size = 0),
        axis.line.y = element_line(linetype = 0.5, color = "black", size = 0),
        axis.ticks.x = element_line(color = "black", size = 0.5),
        axis.ticks.y = element_line(color = "black", size = 0.5),
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold", margin = margin(b = 5)),
        axis.title.x = element_text(margin = margin(t = 5), colour = 'black', size = 13),
        axis.title.y = element_text(margin = margin(r = 5), colour = 'black', size = 13),
        axis.text.x = element_text(size = 12, colour = 'black'),
        axis.text.y = element_text(size = 12, colour = 'black'),
        panel.grid = element_blank(),
        legend.title = element_text(size = 11, vjust = 0.9, hjust = 0),
        legend.text = element_text(colour = "black", size = 11),
        plot.margin = unit(c(0.1, 0.1, 0.1, 0.01), "inches"),
        legend.position = "bottom",
        legend.key.height = unit(0.4, "cm"),
        legend.key.width = unit(0.6, "cm")) +
  coord_fixed(ratio = 1)

#20min----
a20min <- read.table("MNase-20min.bed", header = F)
colnames(a20min) <- c("fragment1", "fragment2")

p3 = ggplot(a20min, aes(x = fragment1, y = fragment2)) +
  geom_bin2d(bins = 40) +
  aes(fill = after_stat(count / max(count))) +
  scale_fill_gradient2(name = "Normalized\nfrequency", low = "white", mid = "#3F73B2", high = "#19477D", midpoint = 0.5, limits = c(0, 1), breaks = c(0, 0.5, 1)) +
  coord_cartesian(xlim = c(0, 1), ylim = c(0, 1)) +
  scale_x_continuous(expand = c(0.003, 0.003), breaks = c(0, 0.5, 1)) +
  scale_y_continuous(expand = c(0.003, 0.003), breaks = c(0, 0.5, 1)) +
  labs(x = "Fragment 1 (20 min)", y = "Fragment 2 (20 min)", title = "1D score") +
  theme_bw(base_size = 12) +
  theme(panel.border = element_rect(colour = "black", fill = NA, size = 0.7),
        axis.line.x = element_line(linetype = 0.5, color = "black", size = 0),
        axis.line.y = element_line(linetype = 0.5, color = "black", size = 0),
        axis.ticks.x = element_line(color = "black", size = 0.5),
        axis.ticks.y = element_line(color = "black", size = 0.5),
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold", margin = margin(b = 5)),
        axis.title.x = element_text(margin = margin(t = 5), colour = 'black', size = 13),
        axis.title.y = element_text(margin = margin(r = 5), colour = 'black', size = 13),
        axis.text.x = element_text(size = 12, colour = 'black'),
        axis.text.y = element_text(size = 12, colour = 'black'),
        panel.grid = element_blank(),
        legend.title = element_text(size = 11, vjust = 0.9, hjust = 0),
        legend.text = element_text(colour = "black", size = 11),
        plot.margin = unit(c(0.1, 0.1, 0.1, 0.01), "inches"),
        legend.position = "bottom",
        legend.key.height = unit(0.4, "cm"),
        legend.key.width = unit(0.6, "cm")) +
  coord_fixed(ratio = 1)

library(ggpubr)
require(grid)
ggarrange(p1, p2, p3, ncol = 3, nrow = 1, heights = c(1:1:1), align = "v", common.legend = TRUE, legend = "right") +
  theme(plot.background = element_rect(fill = 'white', colour = 'white'))
ggsave("G:/AI_XuLab_Data/Radial-C/figS1i.png", width = 9.5, height = 2.8, dpi = 600)