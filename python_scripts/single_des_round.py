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



