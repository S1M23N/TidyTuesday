
##################################################### #
### TidyTuesday wk13 (2022) - Sport Budget #########
##################################################### #

rm(list=ls()) # clear environment

# set working directory
setwd("~/Documents/GitHub/TidyTuesday/")

# load packages
list.packages <- c("tidyverse","sf","tidytuesdayR","rgdal", "ggplot2", "dplyr", "devtools", "usmap")
for(i in list.packages) {
  if(!require(i , character.only = TRUE)) install.packages(i)
  library(i, character.only = TRUE)
}
rm(list.packages, i)

# load tt-data
tuesdata <- tidytuesdayR::tt_load('2022-03-29')
sports <- tuesdata$sports
sports_red <- sports %>%
  select(year, state_cd, exp_women, exp_men) %>%
  group_by(year, state_cd) %>%
  summarise(men = sum(exp_men, na.rm = TRUE), woman = sum(exp_women, na.rm=TRUE))

sports_red = sports_red[!is.na(sports_red$state_cd),]
sports_red$diff = sports_red$men - sports_red$woman

state_help <- data.frame(cbind(state.abb, state.name))
sports_red2 <- merge(sports_red, state_help, by.x ="state_cd", 
                     by.y ="state.abb", all.x = TRUE, all.y=FALSE )
sports_red2$state.name <- tolower(sports_red2$state.name)
sports_red2 <- subset(sports_red2, year == "2019")
sports_red2 = sports_red2[!is.na(sports_red2$state.name),]

us <- map_data("state")
sports_red2 <- merge(sports_red2, us, by.x ="state.name", by.y ="region")

sports_red2 <- sports_red2 %>%
  arrange(group, order)

# plot
ggplot(sports_red2,aes(long, lat, group = group)) +
  geom_sf(fill = diff, colour = "grey50") + 
  coord_quickmap()

## save png
ggsave("~/Documents/GitHub/TidyTuesday/988_TidyTuesday2022Week12.png")
