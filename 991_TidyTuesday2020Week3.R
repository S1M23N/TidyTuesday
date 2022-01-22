## tidy tuesday week 3 (2022) - Choclate Bar rating

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
tuesdata <- tidytuesdayR::tt_load('2022-01-18')
chocolate <- tuesdata$chocolate

# manipulate data
# change percentage to numeric (source code command from https://www.kaggle.com/willcanniford/chocolate-bar-ratings-extensive-eda)
chocolate$cocoa_percent_num <- as.numeric(sapply(chocolate$cocoa_percent, function(x) gsub("%", "", x)))
# aggregate by data
chocolate_year <- chocolate %>%
  group_by(review_date) %>%
  summarize(mean = mean(rating))

# plot graph in BBC style https://bbc.github.io/rcookbook/
plot1 <- ggplot(chocolate_year, aes(review_date, mean)) + 
            geom_line(colour = "#1380A1", size = 1) +
            geom_hline(yintercept = 0, size = 1, colour="#333333") +
            bbc_style()
            
plot1 + geom_curve(aes(x = 2008, y = 2.9, xend = 2012, yend = 2.4), 
             colour = "#555555", 
             curvature = 0.2,
             size=0.5) +
  geom_label(aes(x = 2012, y = 2.4, label = "lowest position in the ranking"), 
             hjust = 0, 
             vjust = 0.5, 
             colour = "#555555", 
             fill = "white", 
             label.size = NA, 
             family="Helvetica", 
             size = 6) +
  labs(title="TidyTuesday contribution week 3 in 2022 ",
       subtitle = "Choclate ratings over time (BBC style graphics)") 

  

## save png
ggsave("~/Documents/GitHub/TidyTuesday/991_TidyTuesday2022Week3.png")
