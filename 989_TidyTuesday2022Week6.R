
##################################################### #
### TidyTuesday wk6 (2022) - Tuskegee Airmen #########
##################################################### #

rm(list=ls()) # clear environment

# set working directory
setwd("~/Documents/GitHub/TidyTuesday/")

# load packages
list.packages <- c("tidyverse","tidytuesdayR", "ggplot2", "dplyr", "devtools","patchwork","striprtf")
for(i in list.packages) {
  if(!require(i , character.only = TRUE)) install.packages(i)
  library(i, character.only = TRUE)
}
rm(list.packages, i)

# load tt-data
df <- read.csv("988_TidyTuesday2022Week7Data.csv")
df2 <- df %>% separate(State, into = c('state', 'population'), sep = 2, convert = TRUE)
df2 <- df2[,1:2]
df2$population<- substr(df2$population, 3, nchar(df2$population)-1)
df2$population <- factor(df2$population,  
                         levels = c("UNDER - 10,000", "10,000 - 25,000", "25,000 - 50,000", 
                                    "50,000 - 100,000", "200,000 - 300,000", "300,000 - 500,000", 
                                    "500,000 - 600,000", "600,000 - 750,000","750,000 AND OVER")
)

# define colors
mycols <- colors()[c(230,76,558,35,240,30,79,392,250,153)] #
# manipulate data



## save png
ggsave("~/Documents/GitHub/TidyTuesday/988_TidyTuesday2022Week7.png")
