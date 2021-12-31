## tidy tuesday week 52 - starbucks

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
tuesdata <- tidytuesdayR::tt_load('2021-12-21')
starbucks <- tuesdata$starbucks

starbucks$milktype <- ifelse(starbucks$milk == 0, "no milk",
                             ifelse(starbucks$milk %in% c(1,2,5), "milk", "plant"))
starbucks <- subset(starbucks,trans_fat_g != "02")

ggplot(starbucks) +
  geom_jitter(aes(trans_fat_g, sugar_g, color = milktype), width = 0.2) +
  labs( title = "Amount of Sugar and Trans-Fat in Starbucks Drinks",
        subtitle = "divided into drinks with milk, vegetable milk and without milk",
        x = "Amount of Trans-Fat",
        y = "Amount of Sugar",
        color = "Contains",
        caption = "Contribution to TidyTuesday (Week52) by Thomas Mock \n Data-Source: https://globalassets.starbucks.com/assets/94fbcc2ab1e24359850fa1870fc988bc.pdf"
        ) +
  scale_colour_manual(values = c("red", "#327143", "#000000")) +
  theme(legend.position = "bottom", 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = "lightblue",
                                        colour = "lightblue",
                                        linetype = "solid")) 

ggsave("992_TidyTuesdayWeek52.png")
