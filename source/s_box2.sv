// $Id: $
// File name:   s_box2.sv
// Created:     3/26/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Performs substitution via the s-boxes for DES
module s_box2 (
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
				0 : temp_out = 15;
				1 : temp_out = 1;
				2 : temp_out = 8;
				3 : temp_out = 14;
				4 : temp_out = 6;
				5 : temp_out = 11;
				6 : temp_out = 3;
				7 : temp_out = 4;
				8 : temp_out = 9;
				9 : temp_out = 7;
				10: temp_out = 2;
				11: temp_out = 13;
				12: temp_out = 12;
				13: temp_out = 0;
				14: temp_out = 5;
				15: temp_out = 10;
			endcase
		end

		else if(row == 1)
		begin
			case(col)
				0 : temp_out = 3;
				1 : temp_out = 13;
				2 : temp_out = 4;
				3 : temp_out = 7;
				4 : temp_out = 15;
				5 : temp_out = 2;
				6 : temp_out = 8;
				7 : temp_out = 14;
				8 : temp_out = 12;
				9 : temp_out = 0;
				10: temp_out = 1;
				11: temp_out = 10;
				12: temp_out = 6;
				13: temp_out = 9;
				14: temp_out = 11;
				15: temp_out = 5;
			endcase
		end

		else if(row == 2)
		begin
			case(col)
				0 : temp_out = 0;
				1 : temp_out = 14;
				2 : temp_out = 7;
				3 : temp_out = 11;
				4 : temp_out = 10;
				5 : temp_out = 4;
				6 : temp_out = 13;
				7 : temp_out = 1;
				8 : temp_out = 5;
				9 : temp_out = 8;
				10: temp_out = 12;
				11: temp_out = 6;
				12: temp_out = 9;
				13: temp_out = 3;
				14: temp_out = 2;
				15: temp_out = 15;
			endcase
		end

		else if(row == 3)
		begin
			case(col)
				0 : temp_out = 13;
				1 : temp_out = 8;
				2 : temp_out = 10;
				3 : temp_out = 1;
				4 : temp_out = 3;
				5 : temp_out = 15;
				6 : temp_out = 4;
				7 : temp_out = 2;
				8 : temp_out = 11;
				9 : temp_out = 6;
				10: temp_out = 7;
				11: temp_out = 12;
				12: temp_out = 0;
				13: temp_out = 5;
				14: temp_out = 14;
				15: temp_out = 9;
			endcase
		end

		else
		begin
			temp_out = 0;
		end
	end 	

	


endmodule