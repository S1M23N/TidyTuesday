## tidy tuesday week 4 (2022) - Board Games

# clear environment
rm(list=ls())

# set working directory
setwd("~/Documents/GitHub/TidyTuesday/TidyTuesday")

# load packages


list.packages <- c("tidyverse","tidytuesdayR", "ggplot2", "dplyr", "patchwork","devtools", "bbplot")
for(i in list.packages) {
  if(!require(i , character.only = TRUE)) install.packages(i)
  library(i, character.only = TRUE)
}

devtools::install_github('bbc/bbplot')
rm(list.packages, i)

## load tt-data
tuesdata <- tidytuesdayR::tt_load('2022-01-25')
ratings <- tuesdata$ratings
details <- tuesdata$details

# manipulate data
df <- merge(ratings, details, by = "id")

# aggregate by data
df_year <- df %>% 
  group_by(year) %>% 
  filter(average == max(average) & year %in% 2000:2021) %>%
  arrange(year)

# plot graph in BBC style https://bbc.github.io/rcookbook/
plot1 <- ggplot(df_year, aes(year, average)) +
  geom_line(colour = "#1380A1", size = 1) +
  geom_hline(yintercept = 0, size = 1, colour="#333333") +
  bbc_style() +
  labs(title="TidyTuesday contribution week 4 in 2022 ",
       subtitle = "Boardgame ratings since 2000 (BBC style graphics)") 

plot1 + 
  geom_curve(
    aes(
      x=2002, 
      y=7.7, 
      xend=2004, 
      yend=4.4),
    colour = "#555555", 
    curvature = 0.2,
    size=0.5
    ) +
  geom_label(
    aes(
      x=2008, 
      y=3.8, 
      label = "all-time lowest average \nranking of a winnig boardgame \n'Funkenschlag: EnBW'"
      )
    ) +
    geom_curve(
      aes(
        x=2021, 
        y=9.2, 
        xend=2018, 
        yend=7.0),
      colour = "#555555", 
      curvature = -0.2,
      size=0.5
      ) +
    geom_label(
      aes(
        x=2014, 
        y=6.5, 
        label = "all-time highest average \nranking of a winnig boardgame \n'Erune'"
      )
    )

## save png
ggsave("~/Documents/GitHub/TidyTuesday/990_TidyTuesday2022Week4.png")
