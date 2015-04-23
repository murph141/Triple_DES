// $Id: $
// File name:   tb_DES_round_wrapper.sv
// Created:     4/23/2015
// Author:      Anthony Kang
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: test bench for des_round_wrapper

`timescale 1ns / 10ps

module tb_DES_round_wrapper();
  
  localparam CLK_PERIOD = 2.5;
  localparam CHECK_DELAY = 1;
  
  logic [31:0] tb_in_right;
  logic [31:0] tb_in_left;
  logic [47:0] tb_round_key;
  logic [31:0] tb_out_right;
  logic [31:0] tb_out_left;
  
  logic tb_clk;
  
  DES_round_wrapper DUT (.in_right(tb_in_right),
                         .in_left(tb_in_left),
                         .round_key(tb_round_key),
                         .out_right(tb_out_right),
                         .out_left(tb_out_left));
  
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
    tb_in_right = 'b00000000000000000000000000000000;
    tb_in_left = 'b00000000000000000000000000000000;
    tb_round_key = 'b000000000000000000000000000000000000000000000000;
    
    @(posedge tb_clk)
    tb_in_right = 'b00000000000000000000000000000000;
    tb_in_left = 'b00000000000000000000000000000000;
    tb_round_key = 'b111111111111111111111111111111111111111111111111;
    
    @(posedge tb_clk)
    tb_in_right = 'b11111111111111111111111111111111;
    tb_in_left = 'b11111111111111111111111111111111;
    tb_round_key = 'b000000000000000000000000000000000000000000000000;
    
    @(posedge tb_clk)
    tb_in_right = 'b11111111111111111111111111111111;
    tb_in_left = 'b11111111111111111111111111111111;
    tb_round_key = 'b111111111111111111111111111111111111111111111111;
         
    @(posedge tb_clk)
    tb_in_right = 'b11111111111111111111111111111111;
    tb_in_left = 'b00000000000000000000000000000000;
    tb_round_key ='b000000000000000000000000000000000000000000000000;
    
    @(posedge tb_clk)
    tb_in_right = 'b11111111111111111111111111111111;
    tb_in_left = 'b00000000000000000000000000000000;
    tb_round_key = 'b111111111111111111111111111111111111111111111111;
    
    @(posedge tb_clk)
    tb_in_right = 'b00000000000000000000000000000000;
    tb_in_left = 'b11111111111111111111111111111111;
    tb_round_key ='b000000000000000000000000000000000000000000000000;
    
    @(posedge tb_clk)
    tb_in_right = 'b00000000000000000000000000000000;
    tb_in_left = 'b11111111111111111111111111111111;
    tb_round_key = 'b111111111111111111111111111111111111111111111111;
                    
    
    
  end  
endmodule