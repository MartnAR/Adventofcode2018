# Load required packages
require(dplyr)

# Load the dataset
setwd('~/Data Science/Advent of Code/2018/Day 1')
freq <- read.csv('frequency adjustment.csv')

# Part 1: Cumulative sum frequency
cumFreq <- cumsum(freq$frequency)
firstStar <- tail(cumFreq, n = 1)

# Turn to data frame
cumFreq <- data.frame('frequency' = cumFreq)

# Find all the numbers that repeat themselves
final <- data.frame()
while(nrow(final) == 0){
  lastOne <- tail(cumFreq, n = 1)
  freq2 <- lastOne %>% bind_rows(freq)
  cumFreq2 <- cumsum(freq2$frequency)
  cumFreq <- cumFreq %>% bind_rows(data.frame('frequency' = cumFreq2[-1])) %>% mutate(order = 1:n())
  final <- cumFreq %>% arrange(frequency, order) %>% group_by(frequency) %>% mutate(dedup = 1:n()) %>% filter(dedup == 2)
}

# Order the repeated numbers; first one is the answer
final %>% arrange(order) %>% head()
