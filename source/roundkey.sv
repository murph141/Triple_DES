// $Id: $
// File name:   roundkey.sv
// Created:     3/26/2015
// Author:      Seth Bontrager
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Round Key Generation



module roundkey 
(
	input wire clk,
	input wire n_rst,
	input wire [63:0] user_key,
	output wire [47:0] roundkey_1,
	output wire [47:0] roundkey_2,
	output wire [47:0] roundkey_3,
	output wire [47:0] roundkey_4,
	output wire [47:0] roundkey_5,
	output wire [47:0] roundkey_6,
	output wire [47:0] roundkey_7,
	output wire [47:0] roundkey_8,
	output wire [47:0] roundkey_9,
	output wire [47:0] roundkey_10,
	output wire [47:0] roundkey_11,
	output wire [47:0] roundkey_12,
	output wire [47:0] roundkey_13,
	output wire [47:0] roundkey_14,
	output wire [47:0] roundkey_15,
	output wire [47:0] roundkey_16
);


	
	wire [55:0] permute_key;
	wire [55:0] rotated_key_1;
	wire [55:0] rotated_key_2;
	wire [55:0] rotated_key_3;
	wire [55:0] rotated_key_4;
	wire [55:0] rotated_key_5;
	wire [55:0] rotated_key_6;
	wire [55:0] rotated_key_7;
	wire [55:0] rotated_key_8;
	wire [55:0] rotated_key_9;
	wire [55:0] rotated_key_10;
	wire [55:0] rotated_key_11;
	wire [55:0] rotated_key_12;
	wire [55:0] rotated_key_13;
	wire [55:0] rotated_key_14;
	wire [55:0] rotated_key_15;
	wire [55:0] rotated_key_16;

	assign permute_key[0] = user_key[56]
	assign permute_key[1] = user_key[48]
	assign permute_key[2] = user_key[40]
	assign permute_key[3] = user_key[32]
	assign permute_key[4] = user_key[24]
	assign permute_key[5] = user_key[16]
	assign permute_key[6] = user_key[8]
	assign permute_key[7] = user_key[0]
	assign permute_key[8] = user_key[57]
	assign permute_key[9] = user_key[49]
	assign permute_key[10] = user_key[41]
	assign permute_key[11] = user_key[33]
	assign permute_key[12] = user_key[25]
	assign permute_key[13] = user_key[17]
	assign permute_key[14] = user_key[9]
	assign permute_key[15] = user_key[1]
	assign permute_key[16] = user_key[58]
	assign permute_key[17] = user_key[50]
	assign permute_key[18] = user_key[42]
	assign permute_key[19] = user_key[34]
	assign permute_key[20] = user_key[26]
	assign permute_key[21] = user_key[18]
	assign permute_key[22] = user_key[10]
	assign permute_key[23] = user_key[2]
	assign permute_key[24] = user_key[59]
	assign permute_key[25] = user_key[51]
	assign permute_key[26] = user_key[43]
	assign permute_key[27] = user_key[35]
	assign permute_key[28] = user_key[62]
	assign permute_key[29] = user_key[54]
	assign permute_key[30] = user_key[46]
	assign permute_key[31] = user_key[38]
	assign permute_key[32] = user_key[30]
	assign permute_key[33] = user_key[22]
	assign permute_key[34] = user_key[14]
	assign permute_key[35] = user_key[6]
	assign permute_key[36] = user_key[61]
	assign permute_key[37] = user_key[53]
	assign permute_key[38] = user_key[45]
	assign permute_key[39] = user_key[37]
	assign permute_key[40] = user_key[29]
	assign permute_key[41] = user_key[21]
	assign permute_key[42] = user_key[13]
	assign permute_key[43] = user_key[5]
	assign permute_key[44] = user_key[60]
	assign permute_key[45] = user_key[52]
	assign permute_key[46] = user_key[44]
	assign permute_key[47] = user_key[36]
	assign permute_key[48] = user_key[28]
	assign permute_key[49] = user_key[20]
	assign permute_key[50] = user_key[12]
	assign permute_key[51] = user_key[4]
	assign permute_key[52] = user_key[27]
	assign permute_key[53] = user_key[19]
	assign permute_key[54] = user_key[11]
	assign permute_key[55] = user_key[3]



	assign rotated_key_1 = {permute_key[1:27], permute_key[0], permute_key[29:55], permute_key[28]}
	assign rotated_key_2 = {permute_key[2:27], permute_key[0:1], permute_key[30:55], permute_key[28:29]}
	assign rotated_key_3 = {permute_key[4:27], permute_key[0:3], permute_key[32:55], permute_key[28:31]}








