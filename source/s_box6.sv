// $Id: $
// File name:   s_box6.sv
// Created:     3/26/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Performs substitution via the s-boxes for DES
module s_box6 (
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
				0 : temp_out = 12;
				1 : temp_out = 1;
				2 : temp_out = 10;
				3 : temp_out = 15;
				4 : temp_out = 9;
				5 : temp_out = 2;
				6 : temp_out = 6;
				7 : temp_out = 8;
				8 : temp_out = 0;
				9 : temp_out = 13;
				10: temp_out = 3;
				11: temp_out = 4;
				12: temp_out = 14;
				13: temp_out = 7;
				14: temp_out = 5;
				15: temp_out = 11;
			endcase
		end

		else if(row == 1)
		begin
			case(col)
				0 : temp_out = 10;
				1 : temp_out = 15;
				2 : temp_out = 4;
				3 : temp_out = 2;
				4 : temp_out = 7;
				5 : temp_out = 12;
				6 : temp_out = 9;
				7 : temp_out = 5;
				8 : temp_out = 6;
				9 : temp_out = 1;
				10: temp_out = 13;
				11: temp_out = 14;
				12: temp_out = 0;
				13: temp_out = 11;
				14: temp_out = 3;
				15: temp_out = 8;
			endcase
		end

		else if(row == 2)
		begin
			case(col)
				0 : temp_out = 9;
				1 : temp_out = 14;
				2 : temp_out = 15;
				3 : temp_out = 5;
				4 : temp_out = 2;
				5 : temp_out = 8;
				6 : temp_out = 12;
				7 : temp_out = 3;
				8 : temp_out = 7;
				9 : temp_out = 0;
				10: temp_out = 4;
				11: temp_out = 10;
				12: temp_out = 1;
				13: temp_out = 13;
				14: temp_out = 11;
				15: temp_out = 6;
			endcase
		end

		else if(row == 3)
		begin
			case(col)
				0 : temp_out = 4;
				1 : temp_out = 3;
				2 : temp_out = 2;
				3 : temp_out = 12;
				4 : temp_out = 9;
				5 : temp_out = 5;
				6 : temp_out = 15;
				7 : temp_out = 10;
				8 : temp_out = 11;
				9 : temp_out = 14;
				10: temp_out = 1;
				11: temp_out = 7;
				12: temp_out = 6;
				13: temp_out = 0;
				14: temp_out = 8;
				15: temp_out = 13;
			endcase
		end

		else
		begin
			temp_out = 0;
		end
	end 	

	


endmodule