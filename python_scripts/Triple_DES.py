#!/usr/bin/env/python

### hw2_starter.py

import sys
from BitVector import *

#######################################################################
#
# Homework Number:    2
# Name:               Seth Bontrager
# ECN Login:          sbontrag
# Due Date:           1/29/15
#
# This scripts peforms DES encryption and decryption on a message
# in 'message.txt' using the key in 'key.txt'. The encrypted message
# is saved in 'encrypted.txt' and the decrypted message is saved in 
# 'decrypted.txt'.
#
#######################################################################


################################   Initial setup  ################################

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




###################################   S-boxes  ##################################

# Now create your s-boxes as an array of arrays by reading the contents
# of the file s-box-tables.txt:
with open('s-box-tables.txt') as f:
    arrays = []
    # Create array of every row of the s boxes
    for line in f:
        if len(line) > 5:
            arrays.append([int(x) for x in line.split()])
s_box = []
# Group 4 rows as one s box
for i in range(0,32, 4):
   s_box.append([arrays[k] for k in range(i, i+4)]) # S_BOX


#######################  Get encryptin key from user  ###########################

def get_encryption_key(key_file): # key                                                              
    
    f = open(key_file, 'r')
    user_supplied_key = f.read()
    
    # Print message if key is not 8 characters
    if len(user_supplied_key) != 8:
        print "Error: Encryption key must be 8 characters"
        return '0'
            
    ## next, construct a BitVector from the key    
    user_key_bv = BitVector(textstring = user_supplied_key) 
    #print(user_key_bv.get_hex_string_from_bitvector())  
    key_bv = user_key_bv.permute(key_permutation_1)        ## permute() is a BitVector function
    return key_bv, user_key_bv


################################# Generatubg round keys  ########################
def extract_round_key( nkey ): # round key  
    round_key = []                                                 
    for i in range(16):
        [left,right] = nkey.divide_into_two()   ## divide_into_two() is a BitVector function
        
        # Shift keys according to table
        left << shifts_key_halvs[i]
        right << shifts_key_halvs[i]       
        # Join left and right halves    
        nkey = left + right
        # Create array of round keys
        round_key.append(nkey.permute(key_permutation_2))
         
        #print(round_key[i].get_hex_string_from_bitvector())

    return round_key


########################## encryption and decryption #############################

def des(encrypt_or_decrypt, input_file, output_file, key ): 
    bv = BitVector(filename = input_file) 
    FILEOUT = open( output_file, 'wb' ) 
    encr = []
    
    while 1:
        bitvec = bv.read_bits_from_file( 64 )   ## assumes that your file has an integral
                                                ## multiple of 8 bytes. If not, you must pad it.
        if len(bitvec) == 0:
            break                # Break if reached end of file
        elif len(bitvec) < 64:
            bitvec.pad_from_right(64 - len(bitvec))  # Pad right with zeros if bitvec less than 64 bits

        [LE, RE] = bitvec.divide_into_two()      
        round_key = extract_round_key(key)   # Get round keys

        #print("original block: " + bitvec.get_hex_string_from_bitvector())
        #print('')

        if encrypt_or_decrypt == 'decrypt':
            round_key.reverse()             # Reverse round keys for decryption
        
        for i in range(16):        
            ## write code to carry out 16 rounds of processing
            exp_perm = RE.permute(expansion_permutation)    # Expansion permutation
            key_mix = exp_perm ^ round_key[i]               # Key mixing
            
            s_box_subst = BitVector(size=0)
            
            # S box substitution
            for s_box_ind in range(8):
                bit6_ind = s_box_ind*6
                bit6_word = key_mix[bit6_ind:bit6_ind+6]              
                s_box_row = bit6_word[0:1] + bit6_word[5:6]                
                s_box_col = bit6_word[1:5]
                bit4_word = s_box[s_box_ind][int(s_box_row)][int(s_box_col)]
                bit4_word = BitVector(intVal=bit4_word, size=4)
                s_box_subst = s_box_subst + bit4_word
                       
            # P box permutation        
            p_box_perm = s_box_subst.permute(p_box_permutation)
                
            # XOR with left and swap    
            temp = RE
            RE = p_box_perm ^ LE
            LE = temp
            bitvec = LE + RE
            
            #print("round " + str(i))
            #print("key: " + round_key[i].get_hex_string_from_bitvector())
            #print("data: " + bitvec.get_hex_string_from_bitvector())
            #print('')


        bitvec = RE + LE                # Final swap

        encr.append(bitvec.get_hex_string_from_bitvector())
        #print('encrypted block: ' + bitvec.get_hex_string_from_bitvector())
        #print('')
        #print('')

        bitvec.write_to_file(FILEOUT)    # Write cipherblock to file
    
    return encr


def getBlocks(file):
    bv = BitVector(filename = file)
    blocks = []

    while 1:
        bitvec = bv.read_bits_from_file( 64 )   ## assumes that your file has an integral
                                                ## multiple of 8 bytes. If not, you must pad it.
        if len(bitvec) == 0:
            break                # Break if reached end of file
        elif len(bitvec) < 64:
            bitvec.pad_from_right(64 - len(bitvec))  # Pad right with zeros if bitvec less than 64 bits


        blocks.append(bitvec.get_hex_string_from_bitvector())


    return blocks


#################################### main #######################################

def main():
    ## write code that prompts the user for the key
    ## and then invokes the functionality of your implementation
    
    key1, key1hex = get_encryption_key('key1.txt')
    key2, key2hex = get_encryption_key('key2.txt')
    key3, key3hex = get_encryption_key('key3.txt')

    if len(key1) == 56:
        blocks = getBlocks('message2.txt')
        encr1 = des('encrypt','message2.txt','encrypted1.txt',key1)
        encr2 = des('encrypt','encrypted1.txt','encrypted2.txt',key2)
        encr3 = des('encrypt','encrypted2.txt','encrypted3.txt',key3)
        
        decr1 = des('decrypt','encrypted3.txt', 'decrypted3.txt', key3)
        decr2 = des('decrypt','decrypted3.txt', 'decrypted2.txt', key2)
        decr3 = des('decrypt','decrypted2.txt', 'decrypted.txt', key1)
        
    




    print("Key 1: " + key1hex.get_hex_string_from_bitvector())
    print("Key 2: " + key2hex.get_hex_string_from_bitvector())
    print("Key 3: " + key3hex.get_hex_string_from_bitvector())

    print("Original Block   -> DES1 Encryption  -> DES2 Encryption  -> DES3 Encryption")
    for i in range(len(blocks)):
        print(blocks[i] + " -> " + encr1[i] + " -> " + encr2[i] + " -> " + encr3[i])

    print('\n')

    print("Encrypted Block  -> DES3 Decryption  -> DES2 Decryption  -> DES1 Decryption")
    for i in range(len(blocks)):
        print(encr3[i] + " -> " + decr1[i] + " -> " + decr2[i] + " -> " + decr3[i])


if __name__ == "__main__":
    main()

