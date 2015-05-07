// $Id: $
// File name:   s_box7.sv
// Created:     3/26/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Performs substitution via the s-boxes for DES
module s_box7 (
	input wire [5:0] in_6bit,
	output wire [3:0] out_4bit
);

	logic [1:0]row;
	logic [3:0]col;
	assign col = in_6bit[4:1];
	assign row = {in_6bit[5], in_6bit[0]};

	logic [3:0]temp_out;

	assign out_4bit = temp_out;
	/*
	* This rather large case statement simple takes the first and last bit index into
	* the rows, and the inner 4 bits to index the culumns. This is indexing into tables
	* as specified by s-boxes online for the DES algorithm
	*/

	always_comb
	begin
		if(row == 0)
		begin
			case(col)
				0 : temp_out = 4;
				1 : temp_out = 11;
				2 : temp_out = 2;
				3 : temp_out = 14;
				4 : temp_out = 15;
				5 : temp_out = 0;
				6 : temp_out = 8;
				7 : temp_out = 13;
				8 : temp_out = 3;
				9 : temp_out = 12;
				10: temp_out = 9;
				11: temp_out = 7;
				12: temp_out = 5;
				13: temp_out = 10;
				14: temp_out = 6;
				15: temp_out = 1;
			endcase
		end

		else if(row == 1)
		begin
			case(col)
				0 : temp_out = 13;
				1 : temp_out = 0;
				2 : temp_out = 11;
				3 : temp_out = 7;
				4 : temp_out = 4;
				5 : temp_out = 9;
				6 : temp_out = 1;
				7 : temp_out = 10;
				8 : temp_out = 14;
				9 : temp_out = 3;
				10: temp_out = 5;
				11: temp_out = 12;
				12: temp_out = 2;
				13: temp_out = 15;
				14: temp_out = 8;
				15: temp_out = 6;
			endcase
		end

		else if(row == 2)
		begin
			case(col)
				0 : temp_out = 1;
				1 : temp_out = 4;
				2 : temp_out = 11;
				3 : temp_out = 13;
				4 : temp_out = 12;
				5 : temp_out = 3;
				6 : temp_out = 7;
				7 : temp_out = 14;
				8 : temp_out = 10;
				9 : temp_out = 15;
				10: temp_out = 6;
				11: temp_out = 8;
				12: temp_out = 0;
				13: temp_out = 5;
				14: temp_out = 9;
				15: temp_out = 2;
			endcase
		end

		else if(row == 3)
		begin
			case(col)
				0 : temp_out = 6;
				1 : temp_out = 11;
				2 : temp_out = 13;
				3 : temp_out = 8;
				4 : temp_out = 1;
				5 : temp_out = 4;
				6 : temp_out = 10;
				7 : temp_out = 7;
				8 : temp_out = 9;
				9 : temp_out = 5;
				10: temp_out = 0;
				11: temp_out = 15;
				12: temp_out = 14;
				13: temp_out = 2;
				14: temp_out = 3;
				15: temp_out = 12;
			endcase
		end

		else
		begin
			temp_out = 0;
		end
	end 	

	


endmodule