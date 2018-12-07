# Load required packages 
require(dplyr)
require(tidyr)
require(lubridate)
require(stringr)

# Load the dataset
setwd('~/Data Science/Advent of Code/2018/Day 4')
shifts <- read.csv('guard shifts.csv', stringsAsFactors = FALSE)

# Part 1: determining the likeliest guard 
shifts <- shifts %>% 
  separate(timestamp, c('date', 'time'), sep = ' ') %>%
  separate(date, c('code', 'month', 'day'), sep = '-') %>% 
  separate(time, c('hour', 'minute'), sep = ':')

shifts$month <- as.numeric(shifts$month)
shifts$day <- as.numeric(shifts$day)
shifts$hour <- as.numeric(shifts$hour)
shifts$minute <- as.numeric(shifts$minute)

shifts <- shifts %>% arrange(month, day, hour, minute)
shifts$guard <- str_extract_all(shifts$action, '#[0-9]*')
