# tidy tuesday week 34 - star trek voice commands

# clear environment
rm(list=ls())

# load packages
list.packages <- c("ggplot2", "tidyverse", "dplyr", "tidytuesdayR", "patchwork")
for(i in list.packages) {
  if(!require(i, character.only = TRUE)) install.packages(i)
  library(i, character.only = TRUE)
}

rm(i, list.packages)

# load data
tuesdata <- tidytuesdayR::tt_load('2021-08-17')
computer <- tuesdata$computer

# manipulate data
df_picard <- computer %>%
  filter(char %in% c("Picard", "Young Picard", "Picard (V.O.)", "Picard (O.S.)", "Picard (Cont'D)")) %>%
  mutate(type = replace(type, type == "command", "Command"),
         type = replace(type, type == "question", "Question")
         )

# plot
ggplot(df_picard) +
  geom_bar(aes(type, fill=char)) +
  labs(
    title = "Tidy Tuesday Week 34 - Star Trek Voice Commands",
    subtitle = "Picards Commands to Computer by Type",
    x = "",
    y= "",
    fill = "character",
    caption = " Contribution to Tidy Tuesday by Thomas Mock \n Data-Source: www.speechinteraction.org \n Picture-Source: www.trek-center.de"
  ) + 
  theme_minimal() +
  viridis::scale_fill_viridis(discrete = TRUE, option = "C") +
  ggsave("TidyTuesdayWeek34.png", device = "png", )
