## tidy tuesday week 51 - Spice Girls

# clear environment
rm(list=ls())

# set working directory
setwd("~/Documents/GitHub/TidyTuesday/TidyTuesday")

# load packages

list.packages <- c("tidyverse","tidytuesdayR", "ggplot2", "dplyr", "patchwork")
for(i in list.packages) {
  if(!require(i , character.only = TRUE)) install.packages(i)
  library(i, character.only = TRUE)
}

rm(list.packages, i)

## load tt-data
tuesdata <- tidytuesdayR::tt_load('2021-12-14')
album <- tuesdata$studio_album_tracks
album$album_release_year <- as.character(album$album_release_year)

x<- ggplot(album, aes(album_release_year, danceability, fill = album_release_year)) +
  ggdist::stat_halfeye(
    adjust = .5,
    width = .6,
    .width = 0,
    justification = -.3,
    point_colour = NA
  ) +
  geom_boxplot(
    width = .25,
    outlier.shape = NA,
  ) +
  geom_point(
    shape = 95,
    size = 10,
    alpha = .2
  ) +
  labs(title = "Danceability of Spice Girls Songs",
       subtitle = "by Album Release Year",
       x = "",
       y = "",
       caption = "Contribution to TidyTuesday (Week51) by Thomas Mock \n Data-Source: R-packages spotifyr & geniusr",
       ) +
  theme_classic() 

x + theme(legend.position = "none")

ggsave("993_TidyTuesdayWeek51.png")