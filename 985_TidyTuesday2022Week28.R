
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
tuesdata <- tidytuesdayR::tt_load('2022-07-12')
flights <- tuesdata$flights

# manipulate data
flightsSum <-flights %>%
  group_by(YEAR, STATE_NAME) %>%
  summarise(arrive = sum(FLT_DEP_1),
            depart = sum(FLT_ARR_1))


flightsSum$depart <- flightsSum$depart*(-1)
flightDep <- flightsSum[, c(1,2,4)] 
flightArr <- flightsSum[, c(1,2,3)]

colnames(flightDep) <- c("YEAR", "STATE_NAME", "FLIGHT")
colnames(flightArr) <- c("YEAR", "STATE_NAME", "FLIGHT")
flightTotal <- rbind(flightDep,flightArr)
flightTotal$type <- ifelse(flightTotal$FLIGHT > 0, "depatures", "arrivals")
flightTotal$type <- factor(flightTotal$type)

# plot
ggplot(flightTotal, aes(x=YEAR, y=FLIGHT, fill=type)) +
  geom_bar(stat = "identity") +
  labs(
    x="",
    y="",
    title ="Departures and Arrivals in Europe between 2016 and 2022",
    caption = "Source: www.ansperformance.eu/data \nProject: Thomas Mock (2021). Tidy Tuesday"
  ) +
  theme(legend.title = element_blank(),
        legend.position = "top",
        panel.background = element_rect((fill = "white"))
  ) +
  scale_y_continuous(labels = NULL, breaks = NULL) +
  scale_x_continuous(n.breaks = 7, )

## save png
ggsave("~/Documents/GitHub/TidyTuesday/985_TidyTuesday2022Week28.png")
