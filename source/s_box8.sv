// $Id: $
// File name:   s_box8.sv
// Created:     3/26/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Performs substitution via the s-boxes for DES
module s_box8 (
	input wire [5:0] in_6bit,
	output wire [3:0] out_4bit
);

	logic [1:0]row;
	logic [3:0]col;
	assign col = in_6bit[4:1];
	assign row = {in_6bit[5], in_6bit[0]};

	logic [3:0]temp_out;

	assign out_4bit = temp_out;

	always_comb
	begin
		if(row == 0)
		begin
			case(col)
				0 : temp_out = 13;
				1 : temp_out = 2;
				2 : temp_out = 8;
				3 : temp_out = 4;
				4 : temp_out = 6;
				5 : temp_out = 15;
				6 : temp_out = 11;
				7 : temp_out = 1;
				8 : temp_out = 10;
				9 : temp_out = 9;
				10: temp_out = 3;
				11: temp_out = 14;
				12: temp_out = 5;
				13: temp_out = 0;
				14: temp_out = 12;
				15: temp_out = 7;
			endcase
		end

		if(row == 1)
		begin
			case(col)
				0 : temp_out = 1;
				1 : temp_out = 15;
				2 : temp_out = 13;
				3 : temp_out = 8;
				4 : temp_out = 10;
				5 : temp_out = 3;
				6 : temp_out = 7;
				7 : temp_out = 4;
				8 : temp_out = 12;
				9 : temp_out = 5;
				10: temp_out = 6;
				11: temp_out = 11;
				12: temp_out = 0;
				13: temp_out = 14;
				14: temp_out = 9;
				15: temp_out = 2;
			endcase
		end

		if(row == 2)
		begin
			case(col)
				0 : temp_out = 7;
				1 : temp_out = 11;
				2 : temp_out = 4;
				3 : temp_out = 1;
				4 : temp_out = 9;
				5 : temp_out = 12;
				6 : temp_out = 14;
				7 : temp_out = 2;
				8 : temp_out = 0;
				9 : temp_out = 6;
				10: temp_out = 10;
				11: temp_out = 13;
				12: temp_out = 15;
				13: temp_out = 3;
				14: temp_out = 5;
				15: temp_out = 8;
			endcase
		end

		if(row == 3)
		begin
			case(col)
				0 : temp_out = 2;
				1 : temp_out = 1;
				2 : temp_out = 14;
				3 : temp_out = 7;
				4 : temp_out = 4;
				5 : temp_out = 10;
				6 : temp_out = 8;
				7 : temp_out = 13;
				8 : temp_out = 15;
				9 : temp_out = 12;
				10: temp_out = 9;
				11: temp_out = 0;
				12: temp_out = 3;
				13: temp_out = 5;
				14: temp_out = 6;
				15: temp_out = 11;
			endcase
		end
	end 	

	


endmodule