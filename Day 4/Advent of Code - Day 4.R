# Load required packages 
require(dplyr)
require(tidyr)
require(lubridate)
require(stringr)
require(zoo)

# Load the dataset
setwd('Day 4')
shifts <- read.csv('guard shifts.csv', stringsAsFactors = FALSE)

# Part 1: determining the likeliest guard 
# Clean the data: timestamp separated into date, time, and then broken down into code, month, day, hour, and
# minute. 
shifts <- shifts %>% 
  separate(timestamp, c('date', 'time'), sep = ' ') %>%
  separate(date, c('code', 'month', 'day'), sep = '-') %>% 
  separate(time, c('hour', 'minute'), sep = ':')

# Changes values to numeric
shifts$month <- as.numeric(shifts$month)
shifts$day <- as.numeric(shifts$day)
shifts$hour <- as.numeric(shifts$hour)
shifts$minute <- as.numeric(shifts$minute)

# Arranges data by date-time, cleans up guard code and event, updates day and hour to make sure each shift
# starts at midnight, and drops code, hour, and action variables.
shifts <- shifts %>% arrange(month, day, hour, minute)
shifts <- shifts %>% mutate(guard = as.factor(str_extract(shifts$action, '#[0-9]*')),
                            event = str_remove_all(action, 'Guard #[0-9]*'),
                            minute = ifelse(hour == 23, 0, minute), 
                            day = ifelse(hour == 23, day + 1, day)) %>% 
  select(-code, -hour, -action)

# Populates the guard variable with the previous observation.
shifts <- shifts %>% mutate(guard = na.locf(guard))

# Creates new data frame that creates one observation per shift per 60 minutes (0 to 59)
allShift <- shifts %>% select(month, day, guard) %>% distinct() 
allShift <- allShift[rep(seq_len(nrow(allShift)), each = 60),]
allShift <- allShift %>%
  group_by(month, day, guard) %>% 
  mutate(minute = 0:59) %>% 
  ungroup()

# Joins allShift with the shift events data frame to have every event for each guard's shift. 
shiftsExp <- allShift %>% left_join(shifts) %>%
  mutate(month = na.locf(month),
         day = na.locf(day), 
         event = na.locf(event)) %>% 
  select(month, day, minute, guard, event) %>% 
  distinct()

# Selects the top guard and the most minutes he's been asleep. Guard is manually filtered. 
shiftsExp %>% filter(event == 'falls asleep') %>% group_by(guard) %>% 
  summarise(sleep = n()) %>% arrange(desc(sleep)) %>% head()
shiftsExp %>% filter(guard == '#761' & event == 'falls asleep') %>% group_by(guard, minute) %>% 
  summarise(tot = n()) %>% 
  arrange(desc(tot))

# Answer
761 * 25

# Part 2: 1st result should be the answer
shiftsExp %>% filter(event == 'falls asleep') %>% group_by(guard, minute) %>% 
  summarise(tot = n()) %>% 
  arrange(desc(tot)) %>%
  head()

# Answer
743 * 32