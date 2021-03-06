// $Id: $
// File name:   tb_roundkey.sv
// Created:     4/8/2015
// Author:      Seth Bontrager
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Testbench for round key generation



`timescale 1ns / 100ps

module tb_roundkey();

	// Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 2.5;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay
	
	// Declare Design Under Test (DUT) portmap signals
	reg [63:0] tb_user_key;
	reg tb_encr_decr;
  	wire [47:0] tb_roundkey_1;
  	wire [47:0] tb_roundkey_2;
  	wire [47:0] tb_roundkey_3;
  	wire [47:0] tb_roundkey_4;
  	wire [47:0] tb_roundkey_5;
  	wire [47:0] tb_roundkey_6;
  	wire [47:0] tb_roundkey_7;
  	wire [47:0] tb_roundkey_8;
  	wire [47:0] tb_roundkey_9;
  	wire [47:0] tb_roundkey_10;
  	wire [47:0] tb_roundkey_11;
  	wire [47:0] tb_roundkey_12;
  	wire [47:0] tb_roundkey_13;
  	wire [47:0] tb_roundkey_14;
  	wire [47:0] tb_roundkey_15;
  	wire [47:0] tb_roundkey_16;
  
  	// DUT port map
  	roundkey M1
	(
		.user_key   (tb_user_key),
		.encr_decr  (tb_encr_decr),
		.roundkey_1 (tb_roundkey_1),
		.roundkey_2 (tb_roundkey_2),
		.roundkey_3 (tb_roundkey_3),
		.roundkey_4 (tb_roundkey_4),
		.roundkey_5 (tb_roundkey_5),
		.roundkey_6 (tb_roundkey_6),
		.roundkey_7 (tb_roundkey_7),
		.roundkey_8 (tb_roundkey_8),
		.roundkey_9 (tb_roundkey_9),
		.roundkey_10(tb_roundkey_10),
		.roundkey_11(tb_roundkey_11),
		.roundkey_12(tb_roundkey_12),
		.roundkey_13(tb_roundkey_13),
		.roundkey_14(tb_roundkey_14),
		.roundkey_15(tb_roundkey_15),
		.roundkey_16(tb_roundkey_16)
	);
	
	
	// Test bench process
	initial
	begin
		
		tb_user_key = 64'h736865726c6f636b;
		tb_encr_decr = 1;      
		#(CHECK_DELAY)

    	// Test Case 1  Check Round Key 1 Encryption
    	if (tb_roundkey_1 == 48'he0be66ce0b2b)
			$info("Test Case 1: PASSED");
		else
			$error("Test Case 1: FAILED");
			
		// Test Case 2  Check Round Key 2 Encryption
		if (tb_roundkey_2 == 48'he0b67635c5a2)
			$info("Test Case 2: PASSED");
		else
			$error("Test Case 2: FAILED");

		// Test Case 3  Check Round Key 3 Encryption
		if (tb_roundkey_3 == 48'he4d676cc0c47)
			$info("Test Case 3: PASSED");
		else
			$error("Test Case 3: FAILED");

		// Test Case 4  Check Round Key 4 Encryption
		if (tb_roundkey_4 == 48'he6d372cee2dc)
			$info("Test Case 4: PASSED");
		else
			$error("Test Case 4: FAILED");

		// Test Case 5  Check Round Key 5 Encryption
		if (tb_roundkey_5 == 48'haed37331d7c9)
			$info("Test Case 5: PASSED");
		else
			$error("Test Case 5: FAILED");

		// Test Case 6  Check Round Key 6 Encryption
		if (tb_roundkey_6 == 48'haf535b9a9423)
			$info("Test Case 6: PASSED");
		else
			$error("Test Case 6: FAILED");

		// Test Case 7  Check Round Key 7 Encryption
		if (tb_roundkey_7 == 48'h2f53d9ce6f24)
			$info("Test Case 7: PASSED");
		else
			$error("Test Case 7: FAILED");

		// Test Case 8  Check Round Key 8 Encryption
		if (tb_roundkey_8 == 48'h1f59d9386bd8)
			$info("Test Case 8: PASSED");
		else
			$error("Test Case 8: FAILED");

		// Test Case 9  Check Round Key 9 Encryption
		if (tb_roundkey_9 == 48'h1f49d9c62c75)
			$info("Test Case 9: PASSED");
		else
			$error("Test Case 9: FAILED");

		// Test Case 10  Check Round Key 10 Encryption
		if (tb_roundkey_10 == 48'h1f699dab8bdc)
			$info("Test Case 10: PASSED");
		else
			$error("Test Case 10: FAILED");

		// Test Case 11  Check Round Key 11 Encryption
		if (tb_roundkey_11 == 48'h1f2d8d11d793)
			$info("Test Case 11: PASSED");
		else
			$error("Test Case 11: FAILED");

		// Test Case 12  Check Round Key 12 Encryption
		if (tb_roundkey_12 == 48'h5b2cad5f0425)
			$info("Test Case 12: PASSED");
		else
			$error("Test Case 12: FAILED");

		// Test Case 13  Check Round Key 13 Encryption
		if (tb_roundkey_13 == 48'hd9acacca69cc)
			$info("Test Case 13: PASSED");
		else
			$error("Test Case 13: FAILED");

		// Test Case 14  Check Round Key 14 Encryption
		if (tb_roundkey_14 == 48'hd0aeae20f39d)
			$info("Test Case 14: PASSED");
		else
			$error("Test Case 14: FAILED");

		// Test Case 15  Check Round Key 15 Encryption
		if (tb_roundkey_15 == 48'hf0be26f314a3)
			$info("Test Case 15: PASSED");
		else
			$error("Test Case 15: FAILED");

		// Test Case 16  Check Round Key 16 Encryption
		if (tb_roundkey_16 == 48'hf0be262bf356)
			$info("Test Case 16: PASSED");
		else
			$error("Test Case 16: FAILED");



		tb_encr_decr = 0;
		#(CHECK_DELAY)

		// Test Case 17  Check Round Key 1 Decryption
		if (tb_roundkey_1 == 48'hf0be262bf356)
			$info("Test Case 17: PASSED");
		else
			$error("Test Case 17: FAILED");

		// Test Case 18  Check Round Key 2 Decryption
		if (tb_roundkey_2 == 48'hf0be26f314a3)
			$info("Test Case 18: PASSED");
		else
			$error("Test Case 18: FAILED");

		// Test Case 19  Check Round Key 3 Decryption
		if (tb_roundkey_3 == 48'hd0aeae20f39d)
			$info("Test Case 19: PASSED");
		else
			$error("Test Case 19: FAILED");

		// Test Case 20  Check Round Key 4 Decryption
		if (tb_roundkey_4 == 48'hd9acacca69cc)
			$info("Test Case 20: PASSED");
		else
			$error("Test Case 20: FAILED");

		// Test Case 21  Check Round Key 5 Decryption
		if (tb_roundkey_5 == 48'h5b2cad5f0425)
			$info("Test Case 21: PASSED");
		else
			$error("Test Case 21: FAILED");

		// Test Case 22  Check Round Key 6 Decryption
		if (tb_roundkey_6 == 48'h1f2d8d11d793)
			$info("Test Case 22: PASSED");
		else
			$error("Test Case 22: FAILED");

		// Test Case 23  Check Round Key 7 Decryption
		if (tb_roundkey_7 == 48'h1f699dab8bdc)
			$info("Test Case 23: PASSED");
		else
			$error("Test Case 23: FAILED");

		// Test Case 24  Check Round Key 8 Decryption
		if (tb_roundkey_8 == 48'h1f49d9c62c75)
			$info("Test Case 24: PASSED");
		else
			$error("Test Case 24: FAILED");

		// Test Case 25  Check Round Key 9 Decryption
		if (tb_roundkey_9 == 48'h1f59d9386bd8)
			$info("Test Case 25: PASSED");
		else
			$error("Test Case 25: FAILED");

		// Test Case 26  Check Round Key 10 Decryption
		if (tb_roundkey_10 == 48'h2f53d9ce6f24)
			$info("Test Case 26: PASSED");
		else
			$error("Test Case 26: FAILED");

		// Test Case 27  Check Round Key 11 Decryption
		if (tb_roundkey_11 == 48'haf535b9a9423)
			$info("Test Case 27: PASSED");
		else
			$error("Test Case 27: FAILED");

		// Test Case 28  Check Round Key 12 Decryption
		if (tb_roundkey_12 == 48'haed37331d7c9)
			$info("Test Case 28: PASSED");
		else
			$error("Test Case 28: FAILED");

		// Test Case 29  Check Round Key 13 Decryption
		if (tb_roundkey_13 == 48'he6d372cee2dc)
			$info("Test Case 29: PASSED");
		else
			$error("Test Case 29: FAILED");

		// Test Case 30  Check Round Key 14 Decryption
		if (tb_roundkey_14 == 48'he4d676cc0c47)
			$info("Test Case 30: PASSED");
		else
			$error("Test Case 30: FAILED");

		// Test Case 31  Check Round Key 15 Decryption
		if (tb_roundkey_15 == 48'he0b67635c5a2)
			$info("Test Case 31: PASSED");
		else
			$error("Test Case 31: FAILED");

    	// Test Case 32  Check Round Key 16 Decryption
    	if (tb_roundkey_16 == 48'he0be66ce0b2b)
			$info("Test Case 32: PASSED");
		else
			$error("Test Case 32: FAILED");

	end
	
endmodule