# Advent of Code: Day 1
import os 
import numpy as np 
import pandas as pd

# Load the dataset
os.chdir('C:/Users/malon/Documents/Data Science/Advent of Code/2018/Adventofcode2018/Day 1')
frequencyAdjustment = pd.read_csv('frequency adjustment.csv')

# Part 1 - sum the frequency numbers
sum(frequencyAdjustment['frequency'])
# Answer is 406

# Part 2 - find the first number that repeats itself

# Answer is 