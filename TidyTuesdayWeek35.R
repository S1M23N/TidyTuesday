# tidy tuesday week 35 - Lemurs

# clear environment
setwd("~/Documents/GitHub/TidyTuesday/TidyTuesday")
rm(list=ls())

# load packages
list.packages <- c("ggplot2", "tidyverse", "grid","jpeg","dplyr", "tidytuesdayR", "lubridate")
for (i in list.packages) {
  if(!require(i, character.only = TRUE)) install.packages(i)
  library(i, character.only = TRUE)
}

rm(i, list.packages)

# load data
tuesdata <- tidytuesdayR::tt_load('2021-08-24')
lemurs <- tuesdata$lemur_data

# manipulate data
lemurs_short <- lemurs %>%
  select(dlc_id, sex, name, birth_institution, birth_type, dob) %>%
  group_by(dlc_id, sex, name, birth_institution, birth_type, dob) %>%
  summarise(n=n())

# add year of birth
lemurs_short$year <- year(lemurs_short$dob)

# group by year and reduce to Duke Lemur Center
lemurs_short_year <- lemurs_short %>%
  select(year, sex, birth_institution) %>%
  filter(birth_institution == "Duke Lemur Center",
         year > 1999,
         sex %in% c("M", "F")) %>%
  group_by(year, sex, birth_institution) %>%
  summarize(n = n())

# exclude all other sex than female and male
lemurs_short_year$n <- ifelse(
  lemurs_short_year$sex == "F", lemurs_short_year$n*(-1), lemurs_short_year$n
  )

# load picture from wikipedia.org/wiki/Lemuren#/media/Datei:Ruffed_Lemur_Singapore.JPG
setwd()
imgage <- jpeg::readJPEG("Lemuren.jpg")

#create ggplot
ggplot(lemurs_short_year, aes(x = year, y = n, fill = sex)) +
  annotation_custom(rasterGrob(imgage, 
                               width = unit(1,"npc"), 
                               height = unit(1,"npc")), 
                    -Inf, Inf, -Inf, Inf) +
  geom_bar(stat = "identity", alpha = 0.7) +
  labs(title = "Number of Lemur Births at Duke Lemur Center",
       x = "",
       y= "",
       caption = " Contribution to TidyTuesday (Week35) by Thomas Mock \n Data-Source: https://www.kaggle.com/jessemostipak/duke-lemur-center-data \n Picture: wikipedia.org/wiki/Lemuren#/media/Datei:Ruffed_Lemur_Singapore.JPG") +
  ggsave("TidyTuesdayWeek35.png")
