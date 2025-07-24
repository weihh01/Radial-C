library(ggplot2)
library(reshape2)
library(plyr)
library(openxlsx)

xx <- read.xlsx('count.xlsx', colNames = F)
xx$X1 <- factor(xx$X1,
                levels = c("MAZstaticCTCFstatic",
                           "MAZinwardCTCFstatic",
                           "MAZstaticCTCFinward",
                           "MAZinwardCTCFinward",
                           "MAZoutwardCTCFstatic",
                           "MAZinwardCTCFoutward",
                           "MAZstaticCTCFoutward",
                           "MAZoutwardCTCFinward",
                           "MAZoutwardCTCFoutward"),
                labels = c("static CTCF-static MAZ",
                           "static CTCF-inward MAZ",
                           "static MAZ-inward CTCF",
                           "inward CTCF-inward MAZ",
                           "static CTCF-outward MAZ",
                           "outward CTCF-inward MAZ",
                           "static MAZ-outward CTCF",
                           "inward CTCF-outward MAZ",
                           "outward CTCF-outward MAZ"))
ggplot(xx, aes(x = X1, y = X2)) +
  geom_bar(position = "dodge", stat = "identity", fill = "#B2521F", width = 0.9) +
  theme_bw() +
  labs(title = " CTCF-MAZ", x = NULL, y = "Counts") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        plot.title = element_text(size = 16, angle = 0, vjust = 0.5, hjust = 0.5),
        axis.title.y = element_text(colour = "black", size = 16, hjust = 0.5, vjust = 1, angle = 90),
        axis.text.x = element_text(size = 15, angle = 30, vjust = 1, hjust = 1),
        axis.text.y = element_text(size = 15, colour = "black", angle = 0, hjust = 1),
        axis.line = element_line(size = 0.5, colour = "black"),
        axis.ticks = element_line(colour = "black", size = 0.5),
        axis.ticks.x = element_blank(),
        axis.line.x = element_blank(),
        plot.margin = unit(c(0.1, 0.1, 0.1, 0.8), "inches"),
        legend.text = element_text(size = 15),
        legend.position = "none",
        legend.background = element_rect(fill = "transparent")) +
  scale_y_continuous(name = "Counts", breaks = seq(0, 4000, 500), expand = c(0, 0))