
##################################################### #
### TidyTuesday wk12 (2022) - Baby Names #########
##################################################### #

rm(list=ls()) # clear environment

# set working directory
setwd("~/Documents/GitHub/TidyTuesday/")

# load packages
list.packages <- c("tidyverse","tidytuesdayR", "ggplot2", "dplyr", "devtools")
for(i in list.packages) {
  if(!require(i , character.only = TRUE)) install.packages(i)
  library(i, character.only = TRUE)
}
rm(list.packages, i)

# load tt-data
tuesdata <- tidytuesdayR::tt_load('2022-03-22')
babynames <- tuesdata$babynames
babynames_2000 <- subset(babynames, year >= 2000)

babynames_2000 <- babynames_2000 %>%
  group_by(sex,year) %>% 
  summarize(sum = sum(n))
  

# plot
ggplot(babynames_2000) +
  geom_point(aes(year, sex, size = sum, color = sum), alpha = 0.7) +
  scale_size(range = c(1, 13)) +
  theme(legend.position = "none" 
        ) +
  labs(title = "Number of babies that are named like at least 4 other babies \nin the US in that year",
       subtitle = "by sex",
       caption = "Source: http://hadley.github.io/babynames \nProject: Thomas Mock (2021). Tidy Tuesday",
       x = "",
       y = "")
  


## save png
ggsave("~/Documents/GitHub/TidyTuesday/988_TidyTuesday2022Week12.png")
