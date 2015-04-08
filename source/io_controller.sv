// $Id: $
// File name:   io_controller.sv
// Created:     4/1/2015
// Author:      Isaac Sheeley
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: io controller
module io_controller (
	input wire sclk,
	input wire n_rst,
	input wire data_in,
	output reg [63:0]data_out
);
	logic count_out;
	logic count_enable;
	logic count_hit_64;
	logic clear_counter;

	flex_counter #(6) DUT_FLEX_COUNTER
  	(
  		.clk          (sclk),
  		.n_rst        (n_rst),
  		.clear        (clear_counter),
  		.count_enable (count_enable),
  		.rollover_val (6'd64),
  		.count_out    (count_out),
  		.rollover_flag(count_hit_64)
  	);

endmodule