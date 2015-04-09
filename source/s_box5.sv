// $Id: $
// File name:   s_box5.sv
// Created:     3/26/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Performs substitution via the s-boxes for DES
module s_box5 (
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
				0 : temp_out = 2;
				1 : temp_out = 12;
				2 : temp_out = 4;
				3 : temp_out = 1;
				4 : temp_out = 7;
				5 : temp_out = 10;
				6 : temp_out = 11;
				7 : temp_out = 6;
				8 : temp_out = 8;
				9 : temp_out = 5;
				10: temp_out = 3;
				11: temp_out = 15;
				12: temp_out = 13;
				13: temp_out = 0;
				14: temp_out = 14;
				15: temp_out = 9;
			endcase
		end

		if(row == 1)
		begin
			case(col)
				0 : temp_out = 14;
				1 : temp_out = 11;
				2 : temp_out = 2;
				3 : temp_out = 12;
				4 : temp_out = 4;
				5 : temp_out = 7;
				6 : temp_out = 13;
				7 : temp_out = 1;
				8 : temp_out = 5;
				9 : temp_out = 0;
				10: temp_out = 15;
				11: temp_out = 10;
				12: temp_out = 3;
				13: temp_out = 9;
				14: temp_out = 8;
				15: temp_out = 6;
			endcase
		end

		if(row == 2)
		begin
			case(col)
				0 : temp_out = 4;
				1 : temp_out = 2;
				2 : temp_out = 1;
				3 : temp_out = 11;
				4 : temp_out = 10;
				5 : temp_out = 13;
				6 : temp_out = 7;
				7 : temp_out = 8;
				8 : temp_out = 15;
				9 : temp_out = 9;
				10: temp_out = 12;
				11: temp_out = 5;
				12: temp_out = 6;
				13: temp_out = 3;
				14: temp_out = 0;
				15: temp_out = 14;
			endcase
		end

		if(row == 3)
		begin
			case(col)
				0 : temp_out = 11;
				1 : temp_out = 8;
				2 : temp_out = 12;
				3 : temp_out = 7;
				4 : temp_out = 1;
				5 : temp_out = 14;
				6 : temp_out = 2;
				7 : temp_out = 13;
				8 : temp_out = 6;
				9 : temp_out = 15;
				10: temp_out = 0;
				11: temp_out = 9;
				12: temp_out = 10;
				13: temp_out = 4;
				14: temp_out = 5;
				15: temp_out = 3;
			endcase
		end
	end 	

	


endmodule