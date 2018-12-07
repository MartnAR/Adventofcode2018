# Load required packages
require(stringr)
require(dplyr)
require(tidyr)

sample <- data.frame(claim = c('#1', '#2', '#3'), 
                     left = c(1, 3, 5), 
                     top = c(3, 1, 5), 
                     x = c(4, 4, 2), 
                     y = c(4, 4, 2))

# Load dataset
setwd('~/Documents/Martin/Programming/Advent of Code/Day 3')
claims <- read.csv('fabric claims.csv')

# Split the dataset and clean it up 
claims2 <- data.frame(matrix(unlist(str_split(claims$claims, ' ')), ncol = 4, byrow = TRUE)) 
claimsClean <- claims2 %>% 
  separate(X3, c('left', 'top'), ',') %>% 
  separate(X4, c('x', 'y'), 'x') %>% 
  mutate(X1 = as.numeric(str_replace(X1, '#', '')),
         top = str_replace(top, ':', ''))

claimsClean <- claimsClean[-2]
colnames(claimsClean)[1] <- 'claim'
claimsClean$claim <- as.character(claimsClean$claim)
for(i in 2:ncol(claimsClean)){
  claimsClean[[i]] <- as.numeric(claimsClean[[i]])
}

# Create the matrix
cloth <- data.frame(matrix(nrow = 1000, ncol = 1000))
sampleCloth <- data.frame(matrix(nrow = 8, ncol = 8))
# Iterate over the cloth, NA means cloth was unclaimed, A means cloth was claimed once, X means clothed was claimed
# more than once
for(i in 1:nrow(claimsClean)){
  colLeft <- claimsClean$top[i] + 1
  rowTop <- claimsClean$left[i] + 1
  colRight <- colLeft + claimsClean$y[i] - 1
  rowBot <- rowTop + claimsClean$x[i] - 1
  for(x in colLeft:colRight){
    for(y in rowTop:rowBot){
        cloth[x, y] <- ifelse(is.na(cloth[x, y]), 1, 
                              ifelse(!is.na(cloth[x, y]), cloth[x, y] + 1, 0))
    }
  }
}

# Count number of Xs per column and add them up to get the result.
finalClaims <- data.frame()
for(i in 1:ncol(cloth)){
  repeatClaims <- data.frame(table(cloth[i]))
  finalClaims <- finalClaims %>% bind_rows(repeatClaims)
}

finalClaims %>% filter(Var1 >= 2) %>% summarise(sum(Freq))

# Part 2
# Find the square inches of each claim
claimsClean <- claimsClean %>% mutate(realValue = x * y)

# Find each claim on the cloth and add the values of the matrix.
for(i in 1:nrow(claimsClean)){
  colLeft <- claimsClean$top[i] + 1
  rowTop <- claimsClean$left[i] + 1
  colRight <- colLeft + claimsClean$y[i] - 1
  rowBot <- rowTop + claimsClean$x[i] - 1
  claimed <- cloth[colLeft:colRight, rowTop:rowBot]
  claimsClean$maxValue[i] <- sum(claimed)
}

# Find the matrix value that matches the claim. 
claimsClean %>% mutate(comp = ifelse(realValue == maxValue, 1, 0)) %>% filter(comp == 1)
