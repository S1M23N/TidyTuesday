## tidy tuesday week 46 - spider

# clear environment
rm(list=ls())

# set working directory
setwd("~/Documents/GitHub/TidyTuesday/TidyTuesday")

# load packages

list.packages <- c("tidyverse", "tidytext","tidytuesdayR", "ggplot2", "dplyr", "patchwork","ggwordcloud")
for(i in list.packages) {
  if(!require(i , character.only = TRUE)) install.packages(i)
  library(i, character.only = TRUE)
}

rm(list.packages, i)

## load tt-data
tuesdata <- tidytuesdayR::tt_load('2021-12-07')
spiders <- tuesdata$spiders

## prepare wordcloud data
spiders_BRA <- subset(spiders, grepl("Brazil",distribution))

spiders_BRA_fam <- spiders_BRA %>%
  select(family) %>%
  count(family, sort=TRUE)

spiders_BRA_fam_angle <- spiders_BRA_fam %>%
  mutate(angle=45*sample(-2:2, n(), replace = TRUE,
                         prob=c(1,1,4,1,1)))

spiders_BRA_gen <- spiders_BRA %>%
  select(genus) %>%
  count(genus, sort=TRUE)

spiders_BRA_spec <- spiders_BRA %>%
  select(species) %>%
  count(species, sort=TRUE)

## generate wordcloud
set.seed(123)
cloud <- ggplot(spiders_BRA_fam_angle, aes(label = family, size = n, color = n)) +
            geom_text_wordcloud_area(rm_outside = TRUE, shape = "circle") +
            scale_size_area(max_size = 15) +
            theme_light()

cloud + labs(title = "Spiderfamilies in Brazil",
             subtitle = "from 1891 to 2021",
             caption = "Contribution to TidyTuesday (Week50) by Thomas Mock \n Data-Source: https://wsc.nmbe.ch/dataresources",
             ) +
  theme(plot.title = element_text(color = "red"), plot.subtitle = element_text(color = "red"),
        plot.caption = element_text(color = "red"))

## save plot
ggsave(file="994_TidyTuesdayWeek50.png")


