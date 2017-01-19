library(ggplot2)

png(filename = "joy.png", width = 1200, height = 1000)

g <- ggplot(df)+
  geom_density(aes(x = tempm), fill = "white", color = "white", size = 2.5)+
  geom_density(aes(x = tempm), fill = "#3A3F4A", color = "#3A3F4A", size = 1)+
  geom_linerange(data = medians_df, aes(x = median, ymin = 0, ymax = y), color = "#EFF2F4", size = 1.5)+
  geom_text(data = medians_df[medians_df$month == "січень",], 
            aes(x = median, y = y+0.05, label = "медіана", 
                family = "Ubuntu Condensed"),
            size = 6, color = "#5D646F", fontface = "plain")+
  scale_x_continuous(limits = c(-25, 35),
                     breaks = seq(-20, 35, 5), expand = c(0, 0))+
  facet_grid(month~., switch = "y")+
  labs(title = "Температура в Києві",
       subtitle = "Розподіл за місяцями у 2016 році",
       caption = "Дані: Weather Underground | Візуалізація: Textura.in.ua")+
  theme_minimal(base_family = "Ubuntu Condensed")+
  theme(text = element_text(family = "Ubuntu Condensed", face = "plain", color = "#3A3F4A"),
        axis.title = element_blank(),
        strip.text.y = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(size = 18),
        panel.spacing.y = unit(-1.25, "lines"),
        plot.title = element_text(face = "bold", size = 40, margin = margin(b = 10, t = 20)),
        plot.subtitle = element_text(size = 20, face = "plain"),
        plot.caption = element_text(size = 16, margin = margin(b = 10, t = 50), color = "#5D646F"),
        plot.background = element_rect(fill = "#EFF2F4"),
        plot.margin = unit(c(2, 3, 2, 3), "cm"))

for (i in unique(as.character(medians_df$month))) {
  
  g = g + geom_text(data = medians_df[medians_df$month == i,],
                    aes(x = -25, y = 0.075, label = month, family = "Ubuntu Condensed"), 
                    hjust = 0, color = "#3A3F4A", size = 6, fontface = "bold")
  
}

g

dev.off()