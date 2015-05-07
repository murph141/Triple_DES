// $Id: $
// File name:   expansion.sv
// Created:     3/26/2015
// Author:      Isaac Sheeley
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: Expansion step in DES
module expansion
(
	input wire [31:0] RE_32bit,
	output wire [47:0] RE_48bit
);
	/*
	* This block appends and prepends bits onto the 4 bit nibbles
	* as specified online for the expansion algorithm of DES
	*/
	assign RE_48bit = 
	{ 
		RE_32bit[0],  RE_32bit[31:28], RE_32bit[27],
		RE_32bit[28], RE_32bit[27:24], RE_32bit[23],
		RE_32bit[24], RE_32bit[23:20], RE_32bit[19],
		RE_32bit[20], RE_32bit[19:16], RE_32bit[15],
		RE_32bit[16], RE_32bit[15:12], RE_32bit[11],
		RE_32bit[12], RE_32bit[11:8],  RE_32bit[7],
		RE_32bit[8],  RE_32bit[7:4],   RE_32bit[3],
		RE_32bit[4],  RE_32bit[3:0],   RE_32bit[31]
	};
	

endmodule
