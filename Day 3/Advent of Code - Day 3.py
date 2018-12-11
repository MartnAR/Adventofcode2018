# Advent of Code - Day 3 
import os 
import re
from collections import defaultdict

os.chdir('C:/Users/malon/Documents/Data Science/Advent of Code/2018/Adventofcode2018/Day 3')
claims = pd.read_csv('fabric claims.csv')

# Part 1
def day3_1(input: str):
    def getClaim(claimStr):
        _, x, y, width, height = map(int, re.findall(r'\d+', claimStr))
        return x, y, width, height
    
    def claimedInches(x, y, width, height):
        for i in range(width):
            for j in range(height):
                yield(x + i, y + j)

    overlaps = defaultdict(int)
    for claim in input:
        x, y, width, height = getClaim(claim)
        for inch in claimedInches(x, y, width, height):
            overlaps[inch] += 1

    totalOverlaps = len(
        [times for inch, times in overlaps.items() if times > 1])
    return totalOverlaps

day3_1(claims['claims'])

# Part 2
