// $Id: $
// File name:   s_box1.sv
// Created:     3/26/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Performs substitution via the s-boxes for DES
module s_box1 (
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
				0 : temp_out = 14;
				1 : temp_out = 4;
				2 : temp_out = 13;
				3 : temp_out = 1;
				4 : temp_out = 2;
				5 : temp_out = 15;
				6 : temp_out = 11;
				7 : temp_out = 8;
				8 : temp_out = 3;
				9 : temp_out = 10;
				10: temp_out = 6;
				11: temp_out = 12;
				12: temp_out = 5;
				13: temp_out = 9;
				14: temp_out = 0;
				15: temp_out = 7;
			endcase
		end

		else if(row == 1)
		begin
			case(col)
				0 : temp_out = 0;
				1 : temp_out = 15;
				2 : temp_out = 7;
				3 : temp_out = 4;
				4 : temp_out = 14;
				5 : temp_out = 2;
				6 : temp_out = 13;
				7 : temp_out = 1;
				8 : temp_out = 10;
				9 : temp_out = 6;
				10: temp_out = 12;
				11: temp_out = 11;
				12: temp_out = 9;
				13: temp_out = 5;
				14: temp_out = 3;
				15: temp_out = 8;
			endcase
		end

		else if(row == 2)
		begin
			case(col)
				0 : temp_out = 4;
				1 : temp_out = 1;
				2 : temp_out = 14;
				3 : temp_out = 8;
				4 : temp_out = 13;
				5 : temp_out = 6;
				6 : temp_out = 2;
				7 : temp_out = 11;
				8 : temp_out = 15;
				9 : temp_out = 12;
				10: temp_out = 9;
				11: temp_out = 7;
				12: temp_out = 3;
				13: temp_out = 10;
				14: temp_out = 5;
				15: temp_out = 0;
			endcase
		end

		else if(row == 3)
		begin
			case(col)
				0 : temp_out = 15;
				1 : temp_out = 12;
				2 : temp_out = 8;
				3 : temp_out = 2;
				4 : temp_out = 4;
				5 : temp_out = 9;
				6 : temp_out = 1;
				7 : temp_out = 7;
				8 : temp_out = 5;
				9 : temp_out = 11;
				10: temp_out = 3;
				11: temp_out = 14;
				12: temp_out = 10;
				13: temp_out = 0;
				14: temp_out = 6;
				15: temp_out = 13;
			endcase		
		end

		else
		begin
			temp_out = 0;
		end
	end 	

	


endmodule