library(openxlsx)
library(ggplot2)
library(dplyr)

#TAD=----
TADratio <- read.xlsx('TAD.xlsx', colNames = F)
colnames(TADratio) <- c("layer", "anchor", "value")
TADratio$value <- round(TADratio$value * 100, 2)
TADratio$rank <- abs(TADratio$layer)

TADratio %>%
  mutate(abs_layer = abs(layer)) %>%
  group_by(anchor, abs_layer) %>%
  summarise(total_value = sum(value), .groups = "drop") %>%
  arrange(anchor, abs_layer) %>%
  group_by(anchor) %>%
  mutate(cumulative = cumsum(total_value)) -> TAD_cumulative

ggplot(TAD_cumulative, aes(x = abs_layer, y = cumulative, color = anchor)) +
  geom_line(size = 1.5, alpha = 1) +
  geom_point(size = 2) +
  labs(x = "Δ(layer)", y = "Cumulative % of TADs",
       title = "TAD borders") +
  theme_bw() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    axis.line = element_line(color = "black"),
    axis.ticks.x = element_line(color = "black"),
    axis.text = element_text(size = 18, color = "black"),
    axis.title = element_text(size = 18),
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
    legend.position = c(0.82, 0.25), legend.title = element_blank(), legend.text = element_text(size = 18)
  ) +
  scale_color_manual(
    values = c("#3B7BB7", "#A22C2C"),
    labels = c("1D score", "2D score")
  ) +
  scale_x_continuous(
    limits = c(-0.5, 2.5),
    breaks = 0:2,
    labels = c("0", "±1", "±2"),
    expand = c(0, 0)
  ) +
  scale_y_continuous(
    limits = c(0, max(TAD_cumulative$cumulative) * 1.1),
    expand = c(0, 0), breaks = seq(0, 25, 5)
  )


#loop----
Loopratio <- read.xlsx('loop.xlsx', colNames = F)
colnames(Loopratio) <- c("layer", "anchor", "value")
Loopratio$value <- round(Loopratio$value * 100, 2)
Loopratio$rank <- abs(Loopratio$layer)

Loopratio %>%
  mutate(abs_layer = abs(layer)) %>%
  group_by(anchor, abs_layer) %>%
  summarise(total_value = sum(value), .groups = "drop") %>%
  arrange(anchor, abs_layer) %>%
  group_by(anchor) %>%
  mutate(cumulative = cumsum(total_value)) -> Loop_cumulative

ggplot(Loop_cumulative, aes(x = abs_layer, y = cumulative, color = anchor)) +
  geom_line(size = 1.5, alpha = 1) +
  geom_point(size = 2) +
  labs(x = "Δ(layer)", y = "Cumulative % of chromatin loops",
       title = "Loop anchors") +
  theme_bw() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    axis.line = element_line(color = "black"),
    axis.ticks.x = element_line(color = "black"),
    axis.text = element_text(size = 18, color = "black"),
    axis.title = element_text(size = 18),
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
    legend.position = c(0.82, 0.25), legend.title = element_blank(), legend.text = element_text(size = 18)
  ) +
  scale_color_manual(
    values = c("#3B7BB7", "#A22C2C"),
    labels = c("1D score", "2D score")
  ) +
  scale_x_continuous(
    limits = c(-0.5, 2.5),
    breaks = 0:2,
    labels = c("0", "±1", "±2"),
    expand = c(0, 0)
  ) +
  scale_y_continuous(
    limits = c(0, max(Loop_cumulative$cumulative) * 1.1),
    expand = c(0, 0), breaks = seq(0, 25, 5)
  )