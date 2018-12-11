# Advent of Code 2018 - Day 2
import os 
import pandas as pd
import itertools
import collections

# Load the dataset
os.chdir('C:/Users/malon/Documents/Data Science/Advent of Code/2018/Adventofcode2018/Day 2')
boxes = pd.read_csv('boxId.csv')

# Part 1
def day2_1(input: str):
    ntimes = {2:0, 3:0}
    for i in input:
        letterNtimes = {}
        collections._count_elements(letterNtimes, i)
        nTimesSet = set(list(letterNtimes.values()))
        nTimesSet.discard(1)
        collections._count_elements(ntimes, nTimesSet)
    checksum = ntimes[2] * ntimes[3]
    return checksum

day2_1(boxes['id'])

# Part 2
def day2_2(input: str):

    def differentByOneLetter(s1, s2):
        alreadyDifferent = False
        for c1, c2 in zip(s1, s2):
            if c1 != c2:
                if alreadyDifferent:
                    return False
                else:
                    alreadyDifferent = True

        return True

    def commonLetters(s1, s2):
        for index, (c1, c2) in enumerate(zip(s1, s2)):
            if c1 != c2:
                return s1[:index] + s1[index+1:]

    for s1, s2 in itertools.combinations(input, 2):
        areDifferent = differentByOneLetter(s1, s2)
        if areDifferent:
            commonLetters = commonLetters(s1, s2)
            return commonLetters

day2_2(boxes['id'])