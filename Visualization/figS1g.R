library("openxlsx")
library(ggsignif)
library(ggplot2)
library(reshape2)
library(ggpubr)

df <- read.table("score_20M_FigS1g.bed", header = T)
df$variable <- as.character(df$variable)
df$variable[which(df$variable == "MNase_1min")] <- "1 min"
df$variable[which(df$variable == "MNase_5min")] <- "5 min"
df$variable[which(df$variable == "MNase_20min")] <- "20 min"
df$variable <- factor(df$variable, levels = c("1 min", "5 min", "20 min"))

ggplot(df, aes(x = variable, y = value)) +
  geom_boxplot(aes(fill = variable), show.legend = F, na.rm = TRUE) +
  scale_fill_manual(values = c("#386CAF", "#fc9533", "#9f79d3")) +
  scale_color_manual(values = c("black", "black", "black")) +
  theme_bw() +
  theme(axis.text.x = element_text(hjust = 0.5, vjust = 3, colour = "black", size = 21, angle = 0),
        axis.text.y = element_text(size = 21, face = "plain", colour = "black", angle = 0),
        axis.title.x = element_text(size = 21, face = "plain", colour = "black", vjust = 0, hjust = 0.5),
        axis.title.y = element_text(size = 21, face = "plain", colour = "black", vjust = 1, hjust = 0.5),
        panel.border = element_blank(),
        axis.line.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.ticks = element_line(colour = "black", size = 0.5),
        legend.position = "none",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.margin = unit(c(0.1, 0.1, 0.5, 0.1), "lines"),
        plot.title = element_text(colour = "black", face = "plain", size = 18, vjust = 8, hjust = 1)) +
  labs(x = NULL, y = "GPSeq score") +
  coord_cartesian(ylim = c(0, 1)) +
  scale_y_continuous(breaks = seq(0, 1, 0.2)) +
  theme(text = element_text(size = 20))