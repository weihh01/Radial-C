library(ggplot2)
library(viridis)
library(dplyr)

TAD <- read.table("MNase-1min_layer.bed")
TAD_sum <- nrow(TAD)
TAD_counts <- TAD %>% count(V1, V2)
TAD_counts_ <- as.data.frame(TAD_counts)
ggplot(TAD_counts_, aes(x = V1, y = V2)) +
  geom_tile(aes(fill = n)) +
  scale_fill_gradient2(name = "Counts", low = "white", mid = "#3F73B2", high = "#19477D", midpoint = (max(TAD_counts_$n) / 2)) +
  theme_bw() +
  theme_classic() +
  coord_cartesian(xlim = c(1, 50), ylim = c(1, 50)) +
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
        plot.margin = unit(c(0.3, 0.3, 0.3, 0.3), "lines"),
        legend.position = "right",
        legend.title = element_text(size = 15, colour = "black"),
        legend.text = element_text(colour = "black", size = 14)) +
  scale_x_continuous(lim = c(0.5, 50.5), breaks = c(1, 10, 20, 30, 40, 50), expand = c(0, 0)) +
  scale_y_continuous(lim = c(0.5, 50.5), breaks = c(1, 10, 20, 30, 40, 50), expand = c(0, 0)) +
  labs(title = "TADs (1 min)", x = "Layer (border 1)", y = "Layer (border 2)") +
  coord_fixed(ratio = 1) +
  annotate("text", x = 37, y = 5, label = paste0("n = ", format(TAD_sum, big.mark = ",")), color = "#C29B39", size = 5)

TAD <- read.table("MNase-5min_layer.bed")
TAD_sum <- nrow(TAD)
TAD_counts <- TAD %>% count(V1, V2)
TAD_counts_ <- as.data.frame(TAD_counts)
ggplot(TAD_counts_, aes(x = V1, y = V2)) +
  geom_tile(aes(fill = n)) +
  scale_fill_gradient2(name = "Counts", low = "white", mid = "#3F73B2", high = "#19477D", midpoint = (max(TAD_counts_$n) / 2)) +
  theme_bw() +
  theme_classic() +
  coord_cartesian(xlim = c(1, 50), ylim = c(1, 50)) +
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
        plot.margin = unit(c(0.3, 0.3, 0.3, 0.3), "lines"),
        legend.position = "right",
        legend.title = element_text(size = 15, colour = "black"),
        legend.text = element_text(colour = "black", size = 14)) +
  scale_x_continuous(lim = c(0.5, 50.5), breaks = c(1, 10, 20, 30, 40, 50), expand = c(0, 0)) +
  scale_y_continuous(lim = c(0.5, 50.5), breaks = c(1, 10, 20, 30, 40, 50), expand = c(0, 0)) +
  labs(title = "TADs (5 min)", x = "Layer (border 1)", y = "Layer (border 2)") +
  coord_fixed(ratio = 1) +
  annotate("text", x = 37, y = 5, label = paste0("n = ", format(TAD_sum, big.mark = ",")), color = "#C29B39", size = 5)

TAD <- read.table("MNase-20min_layer.bed")
TAD_sum <- nrow(TAD)
TAD_counts <- TAD %>% count(V1, V2)
TAD_counts_ <- as.data.frame(TAD_counts)
max(TAD_counts_$n) / 2
ggplot(TAD_counts_, aes(x = V1, y = V2)) +
  geom_tile(aes(fill = n)) +
  scale_fill_gradient2(name = "Counts", low = "white", mid = "#3F73B2", high = "#19477D", midpoint = (max(TAD_counts_$n) / 2)) +
  theme_bw() +
  theme_classic() +
  coord_cartesian(xlim = c(1, 50), ylim = c(1, 50)) +
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
        plot.margin = unit(c(0.3, 0.3, 0.3, 0.3), "lines"),
        legend.position = "right",
        legend.title = element_text(size = 15, colour = "black"),
        legend.text = element_text(colour = "black", size = 14)) +
  scale_x_continuous(lim = c(0.5, 50.5), breaks = c(1, 10, 20, 30, 40, 50), expand = c(0, 0)) +
  scale_y_continuous(lim = c(0.5, 50.5), breaks = c(1, 10, 20, 30, 40, 50), expand = c(0, 0)) +
  labs(title = "TADs (20 min)", x = "Layer (border 1)", y = "Layer (border 2)") +
  coord_fixed(ratio = 1) +
  annotate("text", x = 37, y = 5, label = paste0("n = ", format(TAD_sum, big.mark = ",")), color = "#C29B39", size = 5)