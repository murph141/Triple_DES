#!/usr/bin/env/python

import sys

from BitVector import *
import os
from random import randint
###################################   S-boxes  ##################################

# Now create your s-boxes as an array of arrays by reading the contents
# of the file s-box-tables.txt:
with open('s-box-tables.txt') as f:
     array2d = [[digit for digit in line.split()] for line in f]

#extract just number rows from array2d
s1 = [array2d[2], array2d[3], array2d[4] , array2d[5]]
s2 = [array2d[10], array2d[11], array2d[12] , array2d[13]]
s3 = [array2d[17], array2d[18], array2d[19] , array2d[20]]
s4 = [array2d[24], array2d[25], array2d[26] , array2d[27]]
s5 = [array2d[31], array2d[32], array2d[33] , array2d[34]]
s6 = [array2d[38], array2d[39], array2d[40] , array2d[41]]
s7 = [array2d[45], array2d[46], array2d[47] , array2d[48]]
s8 = [array2d[52], array2d[53], array2d[54] , array2d[55]]

#Set s_boxes to array of all the s boxes
s_boxes = [s1, s2, s3, s4, s5, s6, s7, s8]

#Convert every element to an integer
for box in s_boxes:
    for j, list in enumerate(box):
        box[j] = [ int(x) for x in list ]

 # Expansion permutation (See Section 3.3.1):
expansion_permutation = [31, 0, 1, 2, 3, 4, 3, 4, 5, 6, 7, 8, 7, 8, 
9, 10, 11, 12, 11, 12, 13, 14, 15, 16, 15, 16, 17, 18, 19, 20, 19, 
20, 21, 22, 23, 24, 23, 24, 25, 26, 27, 28, 27, 28, 29, 30, 31, 0]

# P-Box permutation (the last step of the Feistel function in Figure 4):
p_box_permutation = [15,6,19,20,28,11,27,16,0,14,22,25,4,17,30,9,
1,7,23,13,31,26,2,8,18,12,29,5,21,10,3,24]

# Initial permutation of the key (See Section 3.3.6):
key_permutation_1 = [56,48,40,32,24,16,8,0,57,49,41,33,25,17,9,1,58,
50,42,34,26,18,10,2,59,51,43,35,62,54,46,38,30,22,14,6,61,53,45,37,
29,21,13,5,60,52,44,36,28,20,12,4,27,19,11,3]

# Contraction permutation of the key (See Section 3.3.7):
key_permutation_2 = [13,16,10,23,0,4,2,27,14,5,20,9,22,18,11,3,25,
7,15,6,26,19,12,1,40,51,30,36,46,54,29,39,50,44,32,47,43,48,38,55,
33,52,45,41,49,35,28,31]

# Each integer here is the how much left-circular shift is applied
# to each half of the 56-bit key in each round (See Section 3.3.5):
shifts_key_halvs = [1,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1] 


def oneRound(LE, RE, round_key) :

    #set the new left equal to the old right
    LE_new = RE

    #get the expanded output by permuting with the current list
    expanded_output = RE.permute( expansion_permutation )

    #get the key mixing output by xor-ing the expanded output with the round key
    key_mixing_output = expanded_output ^ round_key

    #get the 32 bit word from the substitution step
    word_32bit = s_box_substitution( key_mixing_output )

    #permute the 32 bit result with the P-box
    p_box_result = word_32bit.permute( p_box_permutation )

    #now xor that result with the original left half to get the new right half
    RE_new = p_box_result ^ LE

    return [LE_new, RE_new]



def s_box_substitution(word_48bit) :
        
    #split the 48 bit word into 8, 6 bit words
    words_6bit = [word_48bit[0:6], word_48bit[6:12], word_48bit[12:18], word_48bit[18:24],
                  word_48bit[24:30], word_48bit[30:36], word_48bit[36:42], word_48bit[42:48]]
    
    #32 bit result that will be returned
    result_32bit = BitVector(size = 0)

    for i, word in enumerate(words_6bit):

        #Get the appropriate s-box
        s_box = s_boxes[i]
       
        #get the bits that yield the the row index
        row_bits = BitVector(bitlist = [word[0], word[5]])

        #get the bits that yield the the column index
        col_bits = BitVector(bitlist = [word[1], word[2], word[3], word[4]])

        #get the actual integer row index. Offset by one because arrays
        row = int(row_bits)

        #get the actual integer column index. Offset by one because arrays
        col = int(col_bits)

        s_row = s_box[row]

        new_value = s_row[col]

        new_word_6bit = BitVector(intVal = new_value)

        #check if new word is 4 bits, padded the left side with zeroes if its not
        if ( len(new_word_6bit) < 4 ) :
            new_word_6bit.pad_from_left( 4 - len(new_word_6bit) )

        #Add the new word to the total 32bit result
        result_32bit = result_32bit + new_word_6bit


    return result_32bit



def main():
    tb_key = BitVector(bitstring="111111111111111111111111111111111111111111111111")
    tb_left = BitVector(bitstring="11110000111100001111000011110000")
    tb_right = BitVector(bitstring="00001111000011110000111100001111")

    tb_new_left, tb_new_right = oneRound(tb_left, tb_right, tb_key)

    print(tb_new_left)
    print(tb_new_right)

    


if __name__ == "__main__":
    main()



