
##################################################### #
### TidyTuesday wk27 #########
##################################################### #

rm(list=ls()) # clear environment

# set working directory
setwd("~/Documents/GitHub/TidyTuesday/")

# load packages
list.packages <- c("tidytuesdayR", "ggplot2", "dplyr")
for(i in list.packages) {
  if(!require(i , character.only = TRUE)) install.packages(i)
  library(i, character.only = TRUE)
}
rm(list.packages, i)

# load tt-data
tuesdata <- tidytuesdayR::tt_load('2022-07-05')
rent <- tuesdata$rent

# manipulate data
rent_summary <- rent %>%
  group_by(year) %>%
  summarise(sd = sd(price),
            mean = mean(price))


# plot
ggplot(rent_summary, aes(year, mean)) +
  geom_bar(stat ="identity", color = "black", fill = "khaki") +
  geom_errorbar(aes(ymin = mean-sd, ymax = mean+sd), width = 0.2) +
  labs(x = "",
       y = "",
       title = "Average Craigslist rents in San Francisco",
       subtitle = "by year with standard deviations",
       caption = "Source: www.katepennington.org/data \nProject: Thomas Mock (2021). Tidy Tuesday"
  ) +
  scale_y_continuous(labels=scales::dollar_format()) +
  theme(panel.background = element_rect((fill = "grey"))
  )


## save png
ggsave("~/Documents/GitHub/TidyTuesday/986_TidyTuesday2022Week27.png")
