# tidy tuesday week 41 - Registered Nurses

# clear environment
setwd("~/Documents/GitHub/TidyTuesday/TidyTuesday")
rm(list=ls())

# load packages
list.packages <- c("ggplot2", "tidyverse", "dplyr", "tidytuesdayR", "patchwork")
for (i in list.packages) {
  if(!require(i, character.only = TRUE)) install.packages(i)
  library(i, character.only = TRUE)
}

rm(i, list.packages)

# load data
tuesdata <- tidytuesdayR::tt_load('2021-10-05')
nurses <- tuesdata$nurses

# normalizing
merge1 <- nurses %>%
  group_by(State) %>%
  summarize(sumWage=sum(`Hourly Wage Avg`), n=n())

merge1$mean <- merge1$sumWage / merge1$n
merge1 <- merge1[,c(1,4)]

nurses_merge <- merge(nurses, merge1, by = "State", all = TRUE)
nurses_merge$HourlyWageAvg_normalize <- nurses_merge$`Hourly Wage Avg` / nurses_merge$mean *100

# plot avg hourly wages by year and country
x <- ggplot(nurses_merge) +
  geom_line(aes(Year, `Hourly Wage Avg`, group = State), color = "darkolivegreen") +
  theme(legend.position = "None") +
  labs(x = "",
       y= "Avg Hourly Wages") +
  theme_light()

y <- ggplot(nurses_merge) +
  geom_line(aes(Year, HourlyWageAvg_normalize , group = State), color = "darkolivegreen") +
  theme(legend.position = "None") + 
  labs(x = "",
       y= "[(Avg Hourly Wages / Overall Avg Hourly Wages) * 100]") +
  theme_light()

x + y + plot_annotation(
  title = "Development of the Average Hourly Wages of Nurses by US states",
  caption = " Contribution to TidyTuesday (Week41) by Thomas Mock \n Data-Source: https://data.world/zendoll27/registered-nursing-labor-stats-1998-2020")

ggsave("TidyTuesdayWeek41.png")
