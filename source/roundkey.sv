// $Id: $
// File name:   roundkey.sv
// Created:     3/26/2015
// Author:      Seth Bontrager
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Round Key Generation



module roundkey 
(
	input wire [63:0] user_key,
	input wire encr_decr,
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
	wire [55:0] key_1;
	wire [55:0] key_2;
	wire [55:0] key_3;
	wire [55:0] key_4;
	wire [55:0] key_5;
	wire [55:0] key_6;
	wire [55:0] key_7;
	wire [55:0] key_8;
	wire [55:0] key_9;
	wire [55:0] key_10;
	wire [55:0] key_11;
	wire [55:0] key_12;
	wire [55:0] key_13;
	wire [55:0] key_14;
	wire [55:0] key_15;
	wire [55:0] key_16;

	// First key permutation, reduces key to 56 bits
	assign permute_key = {user_key[7],  user_key[15], user_key[23], user_key[31], user_key[39], user_key[47], user_key[55],
						  user_key[63], user_key[6],  user_key[14], user_key[22], user_key[30], user_key[38], user_key[46], 
						  user_key[54], user_key[62], user_key[5],  user_key[13], user_key[21], user_key[29], user_key[37], 
						  user_key[45], user_key[53], user_key[61], user_key[4],  user_key[12], user_key[20], user_key[28], 
						  user_key[1],  user_key[9],  user_key[17], user_key[25], user_key[33], user_key[41], user_key[49], 
						  user_key[57], user_key[2],  user_key[10], user_key[18], user_key[26], user_key[34], user_key[42],
						  user_key[50], user_key[58], user_key[3],  user_key[11],  user_key[19], user_key[27], user_key[35], 
						  user_key[43], user_key[51], user_key[59], user_key[36], user_key[44], user_key[52], user_key[60]};

	// Rotate left and right halves of keys
	assign rotated_key_1 =  {permute_key[54:28], permute_key[55],    permute_key[26:0], permute_key[27]};
	assign rotated_key_2 =  {permute_key[53:28], permute_key[55:54], permute_key[25:0], permute_key[27:26]};
	assign rotated_key_3 =  {permute_key[51:28], permute_key[55:52], permute_key[23:0], permute_key[27:24]};
	assign rotated_key_4 =  {permute_key[49:28], permute_key[55:50], permute_key[21:0], permute_key[27:22]};
	assign rotated_key_5 =  {permute_key[47:28], permute_key[55:48], permute_key[19:0], permute_key[27:20]};
	assign rotated_key_6 =  {permute_key[45:28], permute_key[55:46], permute_key[17:0], permute_key[27:18]};
	assign rotated_key_7 =  {permute_key[43:28], permute_key[55:44], permute_key[15:0], permute_key[27:16]};
	assign rotated_key_8 =  {permute_key[41:28], permute_key[55:42], permute_key[13:0], permute_key[27:14]};
	assign rotated_key_9 =  {permute_key[40:28], permute_key[55:41], permute_key[12:0], permute_key[27:13]};
	assign rotated_key_10 = {permute_key[38:28], permute_key[55:39], permute_key[10:0], permute_key[27:11]};
	assign rotated_key_11 = {permute_key[36:28], permute_key[55:37], permute_key[8:0],  permute_key[27:9]};
	assign rotated_key_12 = {permute_key[34:28], permute_key[55:35], permute_key[6:0],  permute_key[27:7]};
	assign rotated_key_13 = {permute_key[32:28], permute_key[55:33], permute_key[4:0],  permute_key[27:5]};
	assign rotated_key_14 = {permute_key[30:28], permute_key[55:31], permute_key[2:0],  permute_key[27:3]};
	assign rotated_key_15 = {permute_key[28],    permute_key[55:29], permute_key[0],    permute_key[27:1]};
	assign rotated_key_16 =  permute_key;

	// Permute rotated keys to create round keys, recduce to 48 bits
	assign key_1 = {rotated_key_1[42], rotated_key_1[39], rotated_key_1[45], rotated_key_1[32],
					rotated_key_1[55], rotated_key_1[51], rotated_key_1[53], rotated_key_1[28],
					rotated_key_1[41], rotated_key_1[50], rotated_key_1[35], rotated_key_1[46],
					rotated_key_1[33], rotated_key_1[37], rotated_key_1[44], rotated_key_1[52],
					rotated_key_1[30], rotated_key_1[48], rotated_key_1[40], rotated_key_1[49],
					rotated_key_1[29], rotated_key_1[36], rotated_key_1[43], rotated_key_1[54],
					rotated_key_1[15], rotated_key_1[4],  rotated_key_1[25], rotated_key_1[19],
					rotated_key_1[9],  rotated_key_1[1],  rotated_key_1[26], rotated_key_1[16],
					rotated_key_1[5],  rotated_key_1[11], rotated_key_1[23], rotated_key_1[8],
					rotated_key_1[12], rotated_key_1[7],  rotated_key_1[17], rotated_key_1[0],
					rotated_key_1[22], rotated_key_1[3],  rotated_key_1[10], rotated_key_1[14],
					rotated_key_1[6],  rotated_key_1[20], rotated_key_1[27], rotated_key_1[24]};
						
	assign key_2 = {rotated_key_2[42], rotated_key_2[39], rotated_key_2[45], rotated_key_2[32],
					rotated_key_2[55], rotated_key_2[51], rotated_key_2[53], rotated_key_2[28],
					rotated_key_2[41], rotated_key_2[50], rotated_key_2[35], rotated_key_2[46],
					rotated_key_2[33], rotated_key_2[37], rotated_key_2[44], rotated_key_2[52],
					rotated_key_2[30], rotated_key_2[48], rotated_key_2[40], rotated_key_2[49],
					rotated_key_2[29], rotated_key_2[36], rotated_key_2[43], rotated_key_2[54],
					rotated_key_2[15], rotated_key_2[4],  rotated_key_2[25], rotated_key_2[19],
					rotated_key_2[9],  rotated_key_2[1],  rotated_key_2[26], rotated_key_2[16],
					rotated_key_2[5],  rotated_key_2[11], rotated_key_2[23], rotated_key_2[8],
					rotated_key_2[12], rotated_key_2[7],  rotated_key_2[17], rotated_key_2[0],
					rotated_key_2[22], rotated_key_2[3],  rotated_key_2[10], rotated_key_2[14],
					rotated_key_2[6],  rotated_key_2[20], rotated_key_2[27], rotated_key_2[24]};

	assign key_3 = {rotated_key_3[42], rotated_key_3[39], rotated_key_3[45], rotated_key_3[32],
					rotated_key_3[55], rotated_key_3[51], rotated_key_3[53], rotated_key_3[28],
					rotated_key_3[41], rotated_key_3[50], rotated_key_3[35], rotated_key_3[46],
					rotated_key_3[33], rotated_key_3[37], rotated_key_3[44], rotated_key_3[52],
					rotated_key_3[30], rotated_key_3[48], rotated_key_3[40], rotated_key_3[49],
					rotated_key_3[29], rotated_key_3[36], rotated_key_3[43], rotated_key_3[54],
					rotated_key_3[15], rotated_key_3[4],  rotated_key_3[25], rotated_key_3[19],
					rotated_key_3[9],  rotated_key_3[1],  rotated_key_3[26], rotated_key_3[16],
					rotated_key_3[5],  rotated_key_3[11], rotated_key_3[23], rotated_key_3[8],
					rotated_key_3[12], rotated_key_3[7],  rotated_key_3[17], rotated_key_3[0],
					rotated_key_3[22], rotated_key_3[3],  rotated_key_3[10], rotated_key_3[14],
					rotated_key_3[6],  rotated_key_3[20], rotated_key_3[27], rotated_key_3[24]};

	assign key_4 = {rotated_key_4[42], rotated_key_4[39], rotated_key_4[45], rotated_key_4[32],
					rotated_key_4[55], rotated_key_4[51], rotated_key_4[53], rotated_key_4[28],
					rotated_key_4[41], rotated_key_4[50], rotated_key_4[35], rotated_key_4[46],
					rotated_key_4[33], rotated_key_4[37], rotated_key_4[44], rotated_key_4[52],
					rotated_key_4[30], rotated_key_4[48], rotated_key_4[40], rotated_key_4[49],
					rotated_key_4[29], rotated_key_4[36], rotated_key_4[43], rotated_key_4[54],
					rotated_key_4[15], rotated_key_4[4],  rotated_key_4[25], rotated_key_4[19],
					rotated_key_4[9],  rotated_key_4[1],  rotated_key_4[26], rotated_key_4[16],
					rotated_key_4[5],  rotated_key_4[11], rotated_key_4[23], rotated_key_4[8],
					rotated_key_4[12], rotated_key_4[7],  rotated_key_4[17], rotated_key_4[0],
					rotated_key_4[22], rotated_key_4[3],  rotated_key_4[10], rotated_key_4[14],
					rotated_key_4[6],  rotated_key_4[20], rotated_key_4[27], rotated_key_4[24]};

	assign key_5 = {rotated_key_5[42], rotated_key_5[39], rotated_key_5[45], rotated_key_5[32],
					rotated_key_5[55], rotated_key_5[51], rotated_key_5[53], rotated_key_5[28],
					rotated_key_5[41], rotated_key_5[50], rotated_key_5[35], rotated_key_5[46],
					rotated_key_5[33], rotated_key_5[37], rotated_key_5[44], rotated_key_5[52],
					rotated_key_5[30], rotated_key_5[48], rotated_key_5[40], rotated_key_5[49],
					rotated_key_5[29], rotated_key_5[36], rotated_key_5[43], rotated_key_5[54],
					rotated_key_5[15], rotated_key_5[4],  rotated_key_5[25], rotated_key_5[19],
					rotated_key_5[9],  rotated_key_5[1],  rotated_key_5[26], rotated_key_5[16],
					rotated_key_5[5],  rotated_key_5[11], rotated_key_5[23], rotated_key_5[8],
					rotated_key_5[12], rotated_key_5[7],  rotated_key_5[17], rotated_key_5[0],
					rotated_key_5[22], rotated_key_5[3],  rotated_key_5[10], rotated_key_5[14],
					rotated_key_5[6],  rotated_key_5[20], rotated_key_5[27], rotated_key_5[24]};

	assign key_6 = {rotated_key_6[42], rotated_key_6[39], rotated_key_6[45], rotated_key_6[32],
					rotated_key_6[55], rotated_key_6[51], rotated_key_6[53], rotated_key_6[28],
					rotated_key_6[41], rotated_key_6[50], rotated_key_6[35], rotated_key_6[46],
					rotated_key_6[33], rotated_key_6[37], rotated_key_6[44], rotated_key_6[52],
					rotated_key_6[30], rotated_key_6[48], rotated_key_6[40], rotated_key_6[49],
					rotated_key_6[29], rotated_key_6[36], rotated_key_6[43], rotated_key_6[54],
					rotated_key_6[15], rotated_key_6[4],  rotated_key_6[25], rotated_key_6[19],
					rotated_key_6[9],  rotated_key_6[1],  rotated_key_6[26], rotated_key_6[16],
					rotated_key_6[5],  rotated_key_6[11], rotated_key_6[23], rotated_key_6[8],
					rotated_key_6[12], rotated_key_6[7],  rotated_key_6[17], rotated_key_6[0],
					rotated_key_6[22], rotated_key_6[3],  rotated_key_6[10], rotated_key_6[14],
					rotated_key_6[6],  rotated_key_6[20], rotated_key_6[27], rotated_key_6[24]};

	assign key_7 = {rotated_key_7[42], rotated_key_7[39], rotated_key_7[45], rotated_key_7[32],
					rotated_key_7[55], rotated_key_7[51], rotated_key_7[53], rotated_key_7[28],
					rotated_key_7[41], rotated_key_7[50], rotated_key_7[35], rotated_key_7[46],
					rotated_key_7[33], rotated_key_7[37], rotated_key_7[44], rotated_key_7[52],
					rotated_key_7[30], rotated_key_7[48], rotated_key_7[40], rotated_key_7[49],
					rotated_key_7[29], rotated_key_7[36], rotated_key_7[43], rotated_key_7[54],
					rotated_key_7[15], rotated_key_7[4],  rotated_key_7[25], rotated_key_7[19],
					rotated_key_7[9],  rotated_key_7[1],  rotated_key_7[26], rotated_key_7[16],
					rotated_key_7[5],  rotated_key_7[11], rotated_key_7[23], rotated_key_7[8],
					rotated_key_7[12], rotated_key_7[7],  rotated_key_7[17], rotated_key_7[0],
					rotated_key_7[22], rotated_key_7[3],  rotated_key_7[10], rotated_key_7[14],
					rotated_key_7[6],  rotated_key_7[20], rotated_key_7[27], rotated_key_7[24]};

	assign key_8 = {rotated_key_8[42], rotated_key_8[39], rotated_key_8[45], rotated_key_8[32],
					rotated_key_8[55], rotated_key_8[51], rotated_key_8[53], rotated_key_8[28],
					rotated_key_8[41], rotated_key_8[50], rotated_key_8[35], rotated_key_8[46],
					rotated_key_8[33], rotated_key_8[37], rotated_key_8[44], rotated_key_8[52],
					rotated_key_8[30], rotated_key_8[48], rotated_key_8[40], rotated_key_8[49],
					rotated_key_8[29], rotated_key_8[36], rotated_key_8[43], rotated_key_8[54],
					rotated_key_8[15], rotated_key_8[4],  rotated_key_8[25], rotated_key_8[19],
					rotated_key_8[9],  rotated_key_8[1],  rotated_key_8[26], rotated_key_8[16],
					rotated_key_8[5],  rotated_key_8[11], rotated_key_8[23], rotated_key_8[8],
					rotated_key_8[12], rotated_key_8[7],  rotated_key_8[17], rotated_key_8[0],
					rotated_key_8[22], rotated_key_8[3],  rotated_key_8[10], rotated_key_8[14],
					rotated_key_8[6],  rotated_key_8[20], rotated_key_8[27], rotated_key_8[24]};

	assign key_9 = {rotated_key_9[42], rotated_key_9[39], rotated_key_9[45], rotated_key_9[32],
					rotated_key_9[55], rotated_key_9[51], rotated_key_9[53], rotated_key_9[28],
					rotated_key_9[41], rotated_key_9[50], rotated_key_9[35], rotated_key_9[46],
					rotated_key_9[33], rotated_key_9[37], rotated_key_9[44], rotated_key_9[52],
					rotated_key_9[30], rotated_key_9[48], rotated_key_9[40], rotated_key_9[49],
					rotated_key_9[29], rotated_key_9[36], rotated_key_9[43], rotated_key_9[54],
					rotated_key_9[15], rotated_key_9[4],  rotated_key_9[25], rotated_key_9[19],
					rotated_key_9[9],  rotated_key_9[1],  rotated_key_9[26], rotated_key_9[16],
					rotated_key_9[5],  rotated_key_9[11], rotated_key_9[23], rotated_key_9[8],
					rotated_key_9[12], rotated_key_9[7],  rotated_key_9[17], rotated_key_9[0],
					rotated_key_9[22], rotated_key_9[3],  rotated_key_9[10], rotated_key_9[14],
					rotated_key_9[6],  rotated_key_9[20], rotated_key_9[27], rotated_key_9[24]};

	assign key_10 = {rotated_key_10[42], rotated_key_10[39], rotated_key_10[45], rotated_key_10[32],
					 rotated_key_10[55], rotated_key_10[51], rotated_key_10[53], rotated_key_10[28],
					 rotated_key_10[41], rotated_key_10[50], rotated_key_10[35], rotated_key_10[46],
					 rotated_key_10[33], rotated_key_10[37], rotated_key_10[44], rotated_key_10[52],
					 rotated_key_10[30], rotated_key_10[48], rotated_key_10[40], rotated_key_10[49],
					 rotated_key_10[29], rotated_key_10[36], rotated_key_10[43], rotated_key_10[54],
					 rotated_key_10[15], rotated_key_10[4],  rotated_key_10[25], rotated_key_10[19],
					 rotated_key_10[9],  rotated_key_10[1],  rotated_key_10[26], rotated_key_10[16],
					 rotated_key_10[5],  rotated_key_10[11], rotated_key_10[23], rotated_key_10[8],
					 rotated_key_10[12], rotated_key_10[7],  rotated_key_10[17], rotated_key_10[0],
					 rotated_key_10[22], rotated_key_10[3],  rotated_key_10[10], rotated_key_10[14],
					 rotated_key_10[6],  rotated_key_10[20], rotated_key_10[27], rotated_key_10[24]};

	assign key_11 = {rotated_key_11[42], rotated_key_11[39], rotated_key_11[45], rotated_key_11[32],
					 rotated_key_11[55], rotated_key_11[51], rotated_key_11[53], rotated_key_11[28],
					 rotated_key_11[41], rotated_key_11[50], rotated_key_11[35], rotated_key_11[46],
					 rotated_key_11[33], rotated_key_11[37], rotated_key_11[44], rotated_key_11[52],
					 rotated_key_11[30], rotated_key_11[48], rotated_key_11[40], rotated_key_11[49],
					 rotated_key_11[29], rotated_key_11[36], rotated_key_11[43], rotated_key_11[54],
					 rotated_key_11[15], rotated_key_11[4],  rotated_key_11[25], rotated_key_11[19],
					 rotated_key_11[9],  rotated_key_11[1],  rotated_key_11[26], rotated_key_11[16],
					 rotated_key_11[5],  rotated_key_11[11], rotated_key_11[23], rotated_key_11[8],
					 rotated_key_11[12], rotated_key_11[7],  rotated_key_11[17], rotated_key_11[0],
					 rotated_key_11[22], rotated_key_11[3],  rotated_key_11[10], rotated_key_11[14],
					 rotated_key_11[6],  rotated_key_11[20], rotated_key_11[27], rotated_key_11[24]};

	assign key_12 = {rotated_key_12[42], rotated_key_12[39], rotated_key_12[45], rotated_key_12[32],
					 rotated_key_12[55], rotated_key_12[51], rotated_key_12[53], rotated_key_12[28],
					 rotated_key_12[41], rotated_key_12[50], rotated_key_12[35], rotated_key_12[46],
					 rotated_key_12[33], rotated_key_12[37], rotated_key_12[44], rotated_key_12[52],
					 rotated_key_12[30], rotated_key_12[48], rotated_key_12[40], rotated_key_12[49],
					 rotated_key_12[29], rotated_key_12[36], rotated_key_12[43], rotated_key_12[54],
					 rotated_key_12[15], rotated_key_12[4],  rotated_key_12[25], rotated_key_12[19],
					 rotated_key_12[9],  rotated_key_12[1],  rotated_key_12[26], rotated_key_12[16],
					 rotated_key_12[5],  rotated_key_12[11], rotated_key_12[23], rotated_key_12[8],
					 rotated_key_12[12], rotated_key_12[7],  rotated_key_12[17], rotated_key_12[0],
					 rotated_key_12[22], rotated_key_12[3],  rotated_key_12[10], rotated_key_12[14],
					 rotated_key_12[6],  rotated_key_12[20], rotated_key_12[27], rotated_key_12[24]};

	assign key_13 = {rotated_key_13[42], rotated_key_13[39], rotated_key_13[45], rotated_key_13[32],
					 rotated_key_13[55], rotated_key_13[51], rotated_key_13[53], rotated_key_13[28],
					 rotated_key_13[41], rotated_key_13[50], rotated_key_13[35], rotated_key_13[46],
					 rotated_key_13[33], rotated_key_13[37], rotated_key_13[44], rotated_key_13[52],
					 rotated_key_13[30], rotated_key_13[48], rotated_key_13[40], rotated_key_13[49],
					 rotated_key_13[29], rotated_key_13[36], rotated_key_13[43], rotated_key_13[54],
					 rotated_key_13[15], rotated_key_13[4],  rotated_key_13[25], rotated_key_13[19],
					 rotated_key_13[9],  rotated_key_13[1],  rotated_key_13[26], rotated_key_13[16],
					 rotated_key_13[5],  rotated_key_13[11], rotated_key_13[23], rotated_key_13[8],
					 rotated_key_13[12], rotated_key_13[7],  rotated_key_13[17], rotated_key_13[0],
					 rotated_key_13[22], rotated_key_13[3],  rotated_key_13[10], rotated_key_13[14],
					 rotated_key_13[6],  rotated_key_13[20], rotated_key_13[27], rotated_key_13[24]};

	assign key_14 = {rotated_key_14[42], rotated_key_14[39], rotated_key_14[45], rotated_key_14[32],
					 rotated_key_14[55], rotated_key_14[51], rotated_key_14[53], rotated_key_14[28],
					 rotated_key_14[41], rotated_key_14[50], rotated_key_14[35], rotated_key_14[46],
					 rotated_key_14[33], rotated_key_14[37], rotated_key_14[44], rotated_key_14[52],
					 rotated_key_14[30], rotated_key_14[48], rotated_key_14[40], rotated_key_14[49],
					 rotated_key_14[29], rotated_key_14[36], rotated_key_14[43], rotated_key_14[54],
					 rotated_key_14[15], rotated_key_14[4],  rotated_key_14[25], rotated_key_14[19],
					 rotated_key_14[9],  rotated_key_14[1],  rotated_key_14[26], rotated_key_14[16],
					 rotated_key_14[5],  rotated_key_14[11], rotated_key_14[23], rotated_key_14[8],
					 rotated_key_14[12], rotated_key_14[7],  rotated_key_14[17], rotated_key_14[0],
					 rotated_key_14[22], rotated_key_14[3],  rotated_key_14[10], rotated_key_14[14],
					 rotated_key_14[6],  rotated_key_14[20], rotated_key_14[27], rotated_key_14[24]};

	assign key_15 = {rotated_key_15[42], rotated_key_15[39], rotated_key_15[45], rotated_key_15[32],
					 rotated_key_15[55], rotated_key_15[51], rotated_key_15[53], rotated_key_15[28],
					 rotated_key_15[41], rotated_key_15[50], rotated_key_15[35], rotated_key_15[46],
					 rotated_key_15[33], rotated_key_15[37], rotated_key_15[44], rotated_key_15[52],
					 rotated_key_15[30], rotated_key_15[48], rotated_key_15[40], rotated_key_15[49],
					 rotated_key_15[29], rotated_key_15[36], rotated_key_15[43], rotated_key_15[54],
					 rotated_key_15[15], rotated_key_15[4],  rotated_key_15[25], rotated_key_15[19],
					 rotated_key_15[9],  rotated_key_15[1],  rotated_key_15[26], rotated_key_15[16],
					 rotated_key_15[5],  rotated_key_15[11], rotated_key_15[23], rotated_key_15[8],
					 rotated_key_15[12], rotated_key_15[7],  rotated_key_15[17], rotated_key_15[0],
					 rotated_key_15[22], rotated_key_15[3],  rotated_key_15[10], rotated_key_15[14],
					 rotated_key_15[6],  rotated_key_15[20], rotated_key_15[27], rotated_key_15[24]};

	assign key_16 = {rotated_key_16[42], rotated_key_16[39], rotated_key_16[45], rotated_key_16[32],
					 rotated_key_16[55], rotated_key_16[51], rotated_key_16[53], rotated_key_16[28],
					 rotated_key_16[41], rotated_key_16[50], rotated_key_16[35], rotated_key_16[46],
					 rotated_key_16[33], rotated_key_16[37], rotated_key_16[44], rotated_key_16[52],
					 rotated_key_16[30], rotated_key_16[48], rotated_key_16[40], rotated_key_16[49],
					 rotated_key_16[29], rotated_key_16[36], rotated_key_16[43], rotated_key_16[54],
					 rotated_key_16[15], rotated_key_16[4],  rotated_key_16[25], rotated_key_16[19],
					 rotated_key_16[9],  rotated_key_16[1],  rotated_key_16[26], rotated_key_16[16],
					 rotated_key_16[5],  rotated_key_16[11], rotated_key_16[23], rotated_key_16[8],
					 rotated_key_16[12], rotated_key_16[7],  rotated_key_16[17], rotated_key_16[0],
					 rotated_key_16[22], rotated_key_16[3],  rotated_key_16[10], rotated_key_16[14],
					 rotated_key_16[6],  rotated_key_16[20], rotated_key_16[27], rotated_key_16[24]};


	// Assign round keys based on encryption or decryption
	// Decryption round keys are reverse order of encryption round keys
	assign roundkey_1 = (encr_decr == 1) ? key_1 : key_16;
	assign roundkey_2 = (encr_decr == 1) ? key_2 : key_15;
	assign roundkey_3 = (encr_decr == 1) ? key_3 : key_14;
	assign roundkey_4 = (encr_decr == 1) ? key_4 : key_13;
	assign roundkey_5 = (encr_decr == 1) ? key_5 : key_12;
	assign roundkey_6 = (encr_decr == 1) ? key_6 : key_11;
	assign roundkey_7 = (encr_decr == 1) ? key_7 : key_10;
	assign roundkey_8 = (encr_decr == 1) ? key_8 : key_9;
	assign roundkey_9 = (encr_decr == 1) ? key_9 : key_8;
	assign roundkey_10 = (encr_decr == 1) ? key_10 : key_7;
	assign roundkey_11 = (encr_decr == 1) ? key_11 : key_6;
	assign roundkey_12 = (encr_decr == 1) ? key_12 : key_5;
	assign roundkey_13 = (encr_decr == 1) ? key_13 : key_4;
	assign roundkey_14 = (encr_decr == 1) ? key_14 : key_3;
	assign roundkey_15 = (encr_decr == 1) ? key_15 : key_2;
	assign roundkey_16 = (encr_decr == 1) ? key_16 : key_1;


endmodule