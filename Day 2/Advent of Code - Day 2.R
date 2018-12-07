# Load require packages
require(stringr)

# Load the dataset
setwd("~/Data Science/Advent of Code/2018/Day 2")
boxes <- read.csv('boxId.csv', stringsAsFactors = FALSE)

# Part 1: Scan the boxes
alphabet <- c('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 
              'w', 'x', 'y', 'z')

# Calculate nunmber of boxes that have two or three letters
for(i in alphabet){
  boxes[[i]] <- str_count(boxes$id, i)
}

boxesFlag <- boxes %>% 
  mutate(twoLetter = Reduce('|', lapply(boxes[2:27], '==', 2)),
         threeLetter = Reduce('|', lapply(boxes[2:27], '==', 3)))

# Checksum
boxesFlag %>% filter(twoLetter == TRUE) %>% summarise(n()) * boxesFlag %>% filter(threeLetter == TRUE) %>% summarise(n())

# Part 2: finding the right letters
# Iterate over the rows and each character in the string to find the duplicate password
pass <- data.frame()
for(j in 1:nrow(boxes)){
  for(i in 1:26){
    front <- substr(boxes[j, 1], 1, i-1)
    mid <- str_replace(substr(boxes[j, 1], i, i), '[a-z]', '_')
    back <- substr(boxes[j, 1], i+1, 26)
    newStr <- paste0(front, mid, back)
    newStr <- data.frame('result' = newStr)
    pass <- pass %>% bind_rows(newStr)
  }
}

# Print the result
pass$result[duplicated(pass$result)]

