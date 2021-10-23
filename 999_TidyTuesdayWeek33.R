
library("tidyverse")
library("ggplot2")
library("tidytuesdayR")
library("dplyr")
library("patchwork")

tuesdata <- tidytuesdayR::tt_load('2021-08-10')
tuesdata <- tidytuesdayR::tt_load(2021, week = 33)

investment <- tuesdata$investment

# analysis categories
unique(investment$category)
unique(investment$meta_cat)
unique(investment$year)

# reduce dataset to transportation categories
invest_trans <- investment %>%
  filter(category %in% 
           c("Total basic infrastructure", 
             "Total social infrastructure", 
             "Total digital infrastructure")) %>%
  group_by(category, year) %>%
  summarize(gross_inv = sum(gross_inv))

# visualize the distribution
p1 <- ggplot(invest_trans) +
  geom_line(aes(year, gross_inv, color=category)) +
  geom_point(aes(year, gross_inv, color=category)) +
  viridis::scale_color_viridis(discrete = TRUE, option = "D") +
  theme_void() +
  theme(legend.position = "none", panel.background = element_rect(fill="grey")) +
  gghighlight::gghighlight(category %in% c("Total basic infrastructure", 
                                           "Total social infrastructure", 
                                           "Total digital infrastructure"))

p2 <- ggplot(invest_trans, aes(x="", y=gross_inv, fill=category)) +
    geom_bar(stat="identity", width=1) +
    coord_polar("y", start=0) +
    viridis::scale_fill_viridis(discrete = TRUE, option = "D") +
    theme_void() +
    theme(legend.position = "none", panel.background = element_rect(fill="grey"))

p1 + 
  plot_annotation(
    title="Total Investment in US- Infrastructure",
    subtitle = "from 1947 to 2017",
    caption = "Source: www.bea.gov \n Project: Thomas Mock (2021). Tidy Tuesday") + 
  plot_annotation(tag_levels = 'A') +
  
  inset_element(
    p2,
    left = 0.01,
    bottom =0.3,
    top = 0.7,
    right = 0.5
  ) +
  ggsave( file="TidyTuesdayWeek33.png")
