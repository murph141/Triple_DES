// $Id: $
// File name:   DES_block.sv
// Created:     4/26/2015
// Author:      Isaac Sheeley
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: wrapper for 1 DES Block
module DES_block (
	input wire clk,
	input wire nrst,
	input wire enable,
	input wire encr_decr,
	input wire[63:0] input_data_block,
	input wire[63:0] user_key,
	output wire[63:0] output_data_block,
	output reg enable_next_block
);

	//Output of KSA
	wire[47:0] roundkey_1;
	wire[47:0] roundkey_2;
	wire[47:0] roundkey_3;
	wire[47:0] roundkey_4;
	wire[47:0] roundkey_5;
	wire[47:0] roundkey_6;
	wire[47:0] roundkey_7;
	wire[47:0] roundkey_8;
	wire[47:0] roundkey_9;
	wire[47:0] roundkey_10;
	wire[47:0] roundkey_11;
	wire[47:0] roundkey_12;
	wire[47:0] roundkey_13;
	wire[47:0] roundkey_14;
	wire[47:0] roundkey_15;
	wire[47:0] roundkey_16;


	reg[31:0] left_reg_1_8;
	reg[31:0] right_reg_1_8;

	reg[31:0] left_reg_9_16;
	reg[31:0] right_reg_9_16;

	wire[31:0] next_left_reg_1_8;
	wire[31:0] next_right_reg_1_8;

	wire[31:0] next_left_reg_9_16;
	wire[31:0] next_right_reg_9_16;


	wire[31:0] left_out_round_1_8;
	wire[31:0] right_out_round_1_8;
	
	wire[31:0] left_out_round_9_16;
	wire[31:0] right_out_round_9_16;

	wire[47:0] curr_key_1_8;
	wire[47:0] curr_key_9_16;


	reg enable_rounds_1_8;
	reg enable_rounds_9_16;

	reg [2:0]count_1_8;
	reg [2:0]count_9_16;

	reg rollover_1_8;
	reg rollover_9_16;

	reg clear_1_8;
	reg clear_9_16;





	//First 8 rounds counter
	flex_counter DUT_counter_1_8(
		.clk          (clk),
		.n_rst        (nrst),
		.clear        (clear_1_8),
		.count_enable (enable_rounds_1_8),
		.rollover_val (3'd8),
		.count_out    (count_1_8),
		.rollover_flag(rollover_1_8)
	);

	//Counter for rounds 9 through 16
	flex_counter DUT_counter_9_16(
		.clk          (clk),
		.n_rst        (nrst),
		.clear        (clear_9_16),
		.count_enable (enable_rounds_9_16),
		.rollover_val (3'd8),
		.count_out    (count_9_16),
		.rollover_flag(rollover_9_16)
	);

	//Round registers
	always_ff @(posedge clk, negedge nrst) 
	begin
		if(rst_n == 0) 
		begin
			left_reg_1_8   <= 0;
			right_reg_1_8  <= 0;
			left_reg_9_16  <= 0;
			right_reg_9_16 <= 0;
		end 
		else 
		begin
			left_reg_1_8   <= next_left_reg_1_8;
			right_reg_1_8  <= next_right_reg_1_8;
			left_reg_9_16  <= next_left_reg_9_16;
			right_reg_9_16 <= next_right_reg_9_16;
		end
	end

	//enable registers
	always_ff @(posedge clk, negedge nrst)
	begin
		if(nrst == 0)
		begin
			enable_rounds_1_8  <= 0;
			enable_rounds_9_16 <= 0;
			enable_next_block  <= 0;
		end

		else if(rollover_1_8 == 1)
		begin
			enable_rounds_9_16 <= enable_rounds_1_8;
		end

		else if(rollover_9_16)
		begin
			enable_next_block <= enable_rounds_9_16;
		end

		else
		begin
			enable_rounds_1_8  <= enable;
			enable_rounds_9_16 <= enable_rounds_9_16;
			enable_next_block  <= enable_next_block;
		end
	end

	//Left and right registers
	always_ff @(posedge clk, negedge nrst)
	begin
		if(nrst == 0)
		begin

		end


	end


	//KSA
	roundkey DUT_roundkey(
		.user_key   (user_key),
		.encr_decr  (encr_decr),
		.roundkey_1 (roundkey_1),
		.roundkey_2 (roundkey_2),
		.roundkey_3 (roundkey_3),
		.roundkey_4 (roundkey_4),
		.roundkey_5 (roundkey_5),
		.roundkey_6 (roundkey_6),
		.roundkey_7 (roundkey_7),
		.roundkey_8 (roundkey_8),
		.roundkey_9 (roundkey_9),
		.roundkey_10(roundkey_10),
		.roundkey_11(roundkey_11),
		.roundkey_12(roundkey_12),
		.roundkey_13(roundkey_13),
		.roundkey_14(roundkey_14),
		.roundkey_15(roundkey_15),
		.roundkey_16(roundkey_16)
	);


	//Rounds 1 through 8
	DES_round_wrapper DUT_DES_rounds_1_8(
		.in_right (right_reg_1_8),
		.in_left  (left_reg_1_8),
		.round_key(curr_key_1_8),
		.out_right(right_out_round_1_8),
		.out_left (left_out_round_1_8)
	);


	//Rounds 9 through 16
	DES_round_wrapper DUT_DES_rounds_9_16(
		.in_right (right_reg_9_16),
		.in_left  (left_reg_9_16),
		.round_key(curr_key_9_16),
		.out_right(right_out_round_9_16),
		.out_left (left_out_round_9_16)
	);

	//current round key (rounds 1 through 8) logic
	always_comb
	begin
		case(count_1_8)
			0: curr_key_1_8 = 48'd0;
			1: curr_key_1_8 = roundkey_1;
			2: curr_key_1_8 = roundkey_2;
			3: curr_key_1_8 = roundkey_3;
			4: curr_key_1_8 = roundkey_4;
			5: curr_key_1_8 = roundkey_5;
			6: curr_key_1_8 = roundkey_6;
			7: curr_key_1_8 = roundkey_7;
			8: curr_key_1_8 = roundkey_8;
		endcase
	end
	//current round key (rounds 9 through 16) logic
	always_comb
	begin
		case(count_9_16)
			0: curr_key_9_16 = 48'd0;
			1: curr_key_9_16 = roundkey_9;
			2: curr_key_9_16 = roundkey_10;
			3: curr_key_9_16 = roundkey_11;
			4: curr_key_9_16 = roundkey_12;
			5: curr_key_9_16 = roundkey_13;
			6: curr_key_9_16 = roundkey_14;
			7: curr_key_9_16 = roundkey_15;
			8: curr_key_9_16 = roundkey_16;
		endcase
	end

	//Logic for left and right registers
	always_comb
	begin
		if(count_1_8 == 0 && enable_rounds_1_8 == 1)
		begin
			next_left_reg_1_8 = input_data_block[63:32];
			next_right_reg_1_8 = input_data_block[31:0]; 
		end

		else if(rollover_1_8 == 1)
		begin
			next_left_reg_1_8 = input_data_block[63:32];
			next_right_reg_1_8 = input_data_block[31:0];
			next_left_reg_9_16 = left_out_round_1_8;
			next_right_reg_9_16 = right_out_round_1_8; 
		end

		else if(rollover_9_16 == 1)
		begin
			output_data_block = {left_out_round_9_16, right_out_round_9_16};
		end

		else
		begin
			next_left_reg_1_8 = left_out_round_1_8;
			next_right_reg_1_8 = right_out_round_1_8;
			next_left_reg_9_16 = left_out_round_9_16;
			next_right_reg_9_16 = right_out_round_9_16;  
		end
	end




endmodule