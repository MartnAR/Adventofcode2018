# Load required packages
require(stringr)
require(dplyr)

# Load data set
setwd('Day 5')
sample <- 'dabAcCaCBAcCcaDA'
polymer <- read.delim('polymer.txt', header = FALSE)
polymer <- as.vector(polymer[['V1']])

# Part 1
# Create a data frame with all the patterns that should be dropped from the polymer. 
lowcap <- c('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 
            'u', 'v', 'w', 'x', 'y', 'z')
upcap <- c('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 
           'U', 'V', 'W', 'X', 'Y', 'Z')

mixcap1 <- data.frame('caps' = paste0(lowcap, upcap))
mixcap2 <- data.frame('caps' = paste0(upcap, lowcap))
mixcap <- mixcap1 %>% bind_rows(mixcap2)

# Create a new vector with the polymer which will be used in a loop to find the lowest possible polymer.
newPol <- polymer
polymerLen <- str_length(newPol)
polymerLen <- rep(polymerLen, each = 59)
polymerLen <- append(polymerLen, 49999)

# Loop over the polymer, breaking down the patterns until it cannot go any lower. 
while(min(polymerLen) != nth(polymerLen, -60)){
  for(i in 1:nrow(mixcap)){
    pattern <- mixcap[i, 1]
    newPol <- str_remove_all(newPol, pattern = pattern)
    polLen <- str_length(newPol)
    polymerLen <- append(polymerLen, polLen)
  }
}

# Part 2
# Create a new vector and a data frame with the list of characters to be removed over each iteration. 
enhancedPol <- polymer
patterns <- data.frame('pattern' = c('[aA]', '[bB]', '[cC]', '[dD]', '[eE]', '[fF]', '[gG]', '[hH]', '[iI]',
                                     '[jJ]', '[kK]', '[lL]', '[mM]', '[nN]', '[oO]', '[pP]', '[qQ]', '[rR]',
                                     '[sS]', '[tT]', '[uU]', '[vV]', '[wW]', '[xX]', '[yY]', '[zZ]'))
patterns$pattern <- as.character(patterns$pattern)

# Loop that will start at the original polymer, drop the pattern, and find the lowest possible breakdown. 
polymerLen <- list()
for(i in 1:nrow(patterns)){
  enhPol <- str_remove_all(enhancedPol, pattern = patterns[i, 1])
  enhPolLen <- str_length(enhPol)
  for(j in 1:500){
    for(x in 1:nrow(mixcap)){
        pattern <- mixcap[x, 1]
        enhPol <- str_remove_all(enhPol, pattern = pattern)
        polLen <- str_length(enhPol)
        polymerLen <- append(polymerLen, polLen)
    }
  }
  finalPolymer <- data.frame(matrix(unlist(polymerLen), ncol = 1))
  print(min(finalPolymer))
}

    
