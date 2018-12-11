# Advent of Code: Day 1
import os 
import numpy as np 
import pandas as pd
import itertools

# Load the dataset
os.chdir('C:/Users/malon/Documents/Data Science/Advent of Code/2018/Adventofcode2018/Day 1')
frequencyAdjustment = pd.read_csv('frequency adjustment.csv')

def day1_1(input: str):
    return sum(input)

day1_1(frequencyAdjustment['frequency'])

def day1_2(input: str):
    frequencies = set()
    currentFrequency = 0
    
    for i in itertools.cycle(input):
        currentFrequency += i

        oldLen = len(frequencies)
        frequencies.add(currentFrequency)
        newLen = len(frequencies)

        if oldLen == newLen:
            return currentFrequency

day1_2(frequencyAdjustment['frequency'])

