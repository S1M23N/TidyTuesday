# tidy tuesday week 42 - Registered Nurses

# clear environment
setwd("~/Documents/GitHub/TidyTuesday/TidyTuesday")
rm(list=ls())

# load packages
list.packages <- c("ggplot2", "tidyverse", "dplyr", "tidytuesdayR", "patchwork")
for (i in list.packages) {
  if(!require(i, character.only = TRUE)) install.packages(i)
  library(i, character.only = TRUE)
}

rm(list.packages, i)

# load data
tuesdata <- tidytuesdayR::tt_load("2021-10-19")
pumpkins <- tuesdata$pumpkins

# manipulate data
pumpkins_split <- pumpkins %>%
  separate(id, c("year", "type"), "-")

pumpkins_split$weight_lbs <- as.numeric(pumpkins_split$weight_lbs)

pumpkins_split$type2 <- ifelse(pumpkins_split$type == "F", "Field Pumpkin", pumpkins_split$type)
pumpkins_split$type2 <- ifelse(pumpkins_split$type == "P", "Giant Pumpkin", pumpkins_split$type2)
pumpkins_split$type2 <- ifelse(pumpkins_split$type == "S", "Giant Squash", pumpkins_split$type2)
pumpkins_split$type2 <- ifelse(pumpkins_split$type == "W", "Giant Watermelon", pumpkins_split$type2)
pumpkins_split$type2 <- ifelse(pumpkins_split$type == "L", "Long Gourd", pumpkins_split$type2)
pumpkins_split$type2 <- ifelse(pumpkins_split$type == "T", "Tomato", pumpkins_split$type2)


# ggplot
ggplot(pumpkins_split) +
  geom_boxplot(aes(year, weight_lbs,)) +
  facet_wrap(~type2) +
  labs(
    title = "Distribution of Pumpkins-Weights from the GPC by Type from 2013 - 2021",
    caption = "Contribution to TidyTuesday (Week43) by Thomas Mock \n Data-Source: https://http://www.bigpumpkins.com",
    x = "",
    y = "weight in lbs"
  ) +
  theme_light()
