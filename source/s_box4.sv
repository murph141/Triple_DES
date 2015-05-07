// $Id: $
// File name:   s_box4.sv
// Created:     3/26/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Performs substitution via the s-boxes for DES
module s_box4 (
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
				0 : temp_out = 7;
				1 : temp_out = 13;
				2 : temp_out = 14;
				3 : temp_out = 3;
				4 : temp_out = 0;
				5 : temp_out = 6;
				6 : temp_out = 9;
				7 : temp_out = 10;
				8 : temp_out = 1;
				9 : temp_out = 2;
				10: temp_out = 8;
				11: temp_out = 5;
				12: temp_out = 11;
				13: temp_out = 12;
				14: temp_out = 4;
				15: temp_out = 15;
			endcase
		end

		else if(row == 1)
		begin
			case(col)
				0 : temp_out = 13;
				1 : temp_out = 8;
				2 : temp_out = 11;
				3 : temp_out = 5;
				4 : temp_out = 6;
				5 : temp_out = 15;
				6 : temp_out = 0;
				7 : temp_out = 3;
				8 : temp_out = 4;
				9 : temp_out = 7;
				10: temp_out = 2;
				11: temp_out = 12;
				12: temp_out = 1;
				13: temp_out = 10;
				14: temp_out = 14;
				15: temp_out = 9;
			endcase
		end

		else if(row == 2)
		begin
			case(col)
				0 : temp_out = 10;
				1 : temp_out = 6;
				2 : temp_out = 9;
				3 : temp_out = 0;
				4 : temp_out = 12;
				5 : temp_out = 11;
				6 : temp_out = 7;
				7 : temp_out = 13;
				8 : temp_out = 15;
				9 : temp_out = 1;
				10: temp_out = 3;
				11: temp_out = 14;
				12: temp_out = 5;
				13: temp_out = 2;
				14: temp_out = 8;
				15: temp_out = 4;
			endcase
		end

		else if(row == 3)
		begin
			case(col)
				0 : temp_out = 3;
				1 : temp_out = 15;
				2 : temp_out = 0;
				3 : temp_out = 6;
				4 : temp_out = 10;
				5 : temp_out = 1;
				6 : temp_out = 13;
				7 : temp_out = 8;
				8 : temp_out = 9;
				9 : temp_out = 4;
				10: temp_out = 5;
				11: temp_out = 11;
				12: temp_out = 12;
				13: temp_out = 7;
				14: temp_out = 2;
				15: temp_out = 14;
			endcase
		end

		else
		begin
			temp_out = 0;
		end
	end 	

	


endmodule