
##################################################### #
### TidyTuesday wk6 (2022) - Tuskegee Airmen #########
##################################################### #

rm(list=ls()) # clear environment

# set working directory
setwd("~/Documents/GitHub/TidyTuesday/TidyTuesday")

# load packages
list.packages <- c("tidyverse","tidytuesdayR", "ggplot2", "dplyr", "devtools")
for(i in list.packages) {
  if(!require(i , character.only = TRUE)) install.packages(i)
  library(i, character.only = TRUE)
}
rm(list.packages, i)

# load tt-data
tuesdata <- tidytuesdayR::tt_load('2022-02-08')
airmen <- tuesdata$airmen

# manipulate data
airmen_aggr <- airmen %>%
  mutate(pilot_type = replace(pilot_type, pilot_type == "Liason pilot", "Liaison pilot")) %>%
  group_by(pilot_type) %>%
  summarise(n = n())

# barplot
ggplot(airmen_aggr, aes(pilot_type, n, fill=pilot_type)) +
  geom_bar(sta="identity") +
  geom_text(aes(label=n), vjust= -0.5) +
  labs(title = "Pilot Types of the Tuskegee Airmen",
      x = "",
      y = "", 
      caption = "Contribution to TidyTuesday 2022/6 \n#TuskegeeAirmenChallenge"
      ) +
  theme(legend.position = "none", 
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = "white"),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.ticks.x=element_blank(),
        plot.title = element_text(size=20)
        ) +
  geom_text(
    aes(
      x="Liaison pilot", 
      y=500, 
      label = "'The Tuskegee Airmen were a \ngroup of primarily African American \nmilitary pilots (fighter and bomber) \nand airmen who fought in \nWorld War II.'\n (Source: Wikipedia)"
    )
  ) 

## save png
ggsave("~/Documents/GitHub/TidyTuesday/989_TidyTuesday2022Week6.png")
