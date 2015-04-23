// $Id: $
// File name:   tb_Pbox.sv
// Created:     4/8/2015
// Author:      Anthony Kang
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: test bench for pbox.

`timescale 1ns / 10ps
 
 module tb_PBox();
   
   localparam CLK_PERIOD = 2.5;
   localparam CHECK_DELAY = 1;
   
   logic [31:0] tb_data;
   logic [31:0] tbp_data;
   logic tb_clk;
   
   PBox DUT (.data(tb_data), .p_data(tbp_data));
   
   always
   begin
     tb_clk = 1'b0;
     #(CLK_PERIOD/2.0);
     tb_clk = 1'b1;
     #(CLK_PERIOD/2.0);
   end
   
   initial
   begin
     
     @(posedge tb_clk)
     tb_data = 2147483647;
     
     @(posedge tb_clk)
     tb_data = 0;
     
     @(posedge tb_clk)
     tb_data = 'b1010101010101010101010101010101010;
     
   end
   
endmodule 
   