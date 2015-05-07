// $Id: $
// File name:   triple_DES_block.sv
// Created:     4/28/2015
// Author:      Isaac Sheeley
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: triple DES wrapper file
module triple_DES_block (
	input wire clk,    // Clock
	input wire enable,
	input wire nrst,  // Asynchronous reset active low
	input wire encr_decr,
	input wire[63:0] input_data_block,
	input wire[63:0] user_key1,
	input wire[63:0] user_key2,
	input wire[63:0] user_key3,
	output wire[63:0] output_data_block,
	output reg done	
);

	
	logic enable_DES2;
	logic enable_DES3;
	logic early_done;
	

	logic[63:0] output_data_block1;
	logic[63:0] output_data_block2;


	//First DES block
	DES_block DUT_DES1(
		.clk              (clk),
		.nrst             (nrst),
		.enable           (enable),
		.encr_decr        (encr_decr),
		.enable_next_block(enable_DES2),
		.input_data_block(input_data_block),
		.user_key(user_key1),
		.output_data_block(output_data_block1)

	);

	//Second DES block
	DES_block DUT_DES2(
		.clk              (clk),
		.nrst             (nrst),
		.enable           (enable_DES2),
		.encr_decr        (encr_decr),
		.enable_next_block(enable_DES3),
		.input_data_block(output_data_block1),
		.user_key(user_key2),
		.output_data_block(output_data_block2)

	);

	//Third DES block
	DES_block DUT_DES3(
		.clk              (clk),
		.nrst             (nrst),
		.enable           (enable_DES3),
		.encr_decr        (encr_decr),
		.enable_next_block(early_done),
		.user_key(user_key3),
		.input_data_block(output_data_block2),
		.output_data_block(output_data_block)

	);


	//Flip flop for delaying the done signal till its proper time
	always_ff @(posedge clk, negedge nrst)
	begin
		if(nrst == 1'b0) 
		begin
			done <= 0;
		end 
		else 
		begin
			done <= early_done;
		end
	end



endmodule
