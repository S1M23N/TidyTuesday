# tidy tuesday week 42 - Registered Nurses

# clear environment
setwd("~/Documents/GitHub/TidyTuesday/TidyTuesday")
rm(list=ls())

# load packages
list.packages <- c("ggplot2", "tidyverse", "dplyr", "tidytuesdayR", "patchwork",
                   "rnaturalearth", "rnaturalearthdata")
for (i in list.packages) {
  if(!require(i, character.only = TRUE)) install.packages(i)
  library(i, character.only = TRUE)
}

rm(i, list.packages)

# load data
tuesdata <- tidytuesdayR::tt_load('2021-10-12')
seafood <- tuesdata$`capture-fisheries-vs-aquaculture`

# manipulate data
# reduce to Germany
seafood_germany <- subset(seafood, seafood$Entity == "Germany")

seafood_germany_long <- pivot_longer(seafood_germany, 
                                     cols = c("Aquaculture production (metric tons)", 
                                              "Capture fisheries production (metric tons)" ),
                                     values_to = "fish", names_to = "type")

#visualization
# create line chart
x <- ggplot(seafood_germany_long) +
  geom_line(aes(Year, fish, colour = type)) +
  geom_point(aes(Year, fish, colour = type), shape = 18) +
  labs(x = "",
       y = "fish (metric tons)") +
  theme_classic() +
  theme(legend.position = "none") +
  scale_color_manual(values=c("deepskyblue3", "orange3")) +
  annotate("text", x = 2012, y =350000, label = "Captures fisheries \n production", color = "orange3") +
  annotate("text", x = 2012, y =120000, label = "Aquaculture \n production", color = "deepskyblue3")

# create data for europe map
map <- ne_countries(scale = "medium", continent = "europe", returnclass = "sf")
map <- subset(map, sovereignt != "Russia")
map$color <- ifelse(map$sovereignt == "Germany","b","a")

# plot europe map
y <- ggplot(map) +
  geom_sf(aes(fill = color)) +
  coord_sf(ylim = c(35, 80), xlim = c(-45, 60)) +
  theme_void() +
  scale_fill_manual(values=c("white", "red")) +
  theme(legend.position = "none")

# combine plots
x + 
  plot_annotation(
    title = "Development of Seafood production and capture in Germany",
    caption = " Contribution to TidyTuesday (Week42) by Thomas Mock \n Data-Source: https://ourworldindata.org/seafood-production") + 
  inset_element(
    y,
    left = 0.5,
    bottom =0.5,
    top = 1,
    right = 1
  )  

# save visualization
setwd("~/Documents/GitHub/TidyTuesday/TidyTuesday")
ggsave( file="TidyTuesdayWeek42.png")
  