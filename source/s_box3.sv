// $Id: $
// File name:   s_box3.sv
// Created:     3/26/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Performs substitution via the s-boxes for DES
module s_box3 (
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
				0 : temp_out = 10;
				1 : temp_out = 0;
				2 : temp_out = 9;
				3 : temp_out = 14;
				4 : temp_out = 6;
				5 : temp_out = 3;
				6 : temp_out = 15;
				7 : temp_out = 5;
				8 : temp_out = 1;
				9 : temp_out = 13;
				10: temp_out = 12;
				11: temp_out = 7;
				12: temp_out = 11;
				13: temp_out = 4;
				14: temp_out = 2;
				15: temp_out = 8;
			endcase
		end

		if(row == 1)
		begin
			case(col)
				0 : temp_out = 13;
				1 : temp_out = 7;
				2 : temp_out = 0;
				3 : temp_out = 9;
				4 : temp_out = 3;
				5 : temp_out = 4;
				6 : temp_out = 6;
				7 : temp_out = 10;
				8 : temp_out = 2;
				9 : temp_out = 8;
				10: temp_out = 5;
				11: temp_out = 14;
				12: temp_out = 12;
				13: temp_out = 11;
				14: temp_out = 15;
				15: temp_out = 1;
			endcase
		end

		if(row == 2)
		begin
			case(col)
				0 : temp_out = 13;
				1 : temp_out = 6;
				2 : temp_out = 4;
				3 : temp_out = 9;
				4 : temp_out = 8;
				5 : temp_out = 15;
				6 : temp_out = 3;
				7 : temp_out = 0;
				8 : temp_out = 11;
				9 : temp_out = 1;
				10: temp_out = 2;
				11: temp_out = 12;
				12: temp_out = 5;
				13: temp_out = 10;
				14: temp_out = 14;
				15: temp_out = 7;
			endcase
		end

		if(row == 3)
		begin
			case(col)
				0 : temp_out = 1;
				1 : temp_out = 10;
				2 : temp_out = 13;
				3 : temp_out = 0;
				4 : temp_out = 6;
				5 : temp_out = 9;
				6 : temp_out = 8;
				7 : temp_out = 7;
				8 : temp_out = 4;
				9 : temp_out = 15;
				10: temp_out = 14;
				11: temp_out = 3;
				12: temp_out = 11;
				13: temp_out = 5;
				14: temp_out = 2;
				15: temp_out = 12;
			endcase
		end
	end 	

	


endmodule