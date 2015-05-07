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
  
  // Instantiate the round wrapper file
  DES_round_wrapper DUT (.in_right(tb_in_right),
                         .in_left(tb_in_left),
                         .round_key(tb_round_key),
                         .out_right(tb_out_right),
                         .out_left(tb_out_left));
  
  // Generate the clock
  always
  begin
    tb_clk = 1'b0;
    #(CLK_PERIOD/2.0);
    tb_clk = 1'b1;
    #(CLK_PERIOD/2.0);
  end
  
  initial
  begin
    
    // Send values and check assertions
    @(posedge tb_clk)
    tb_in_right = 'b00000000000000000000000000000000;
    tb_in_left = 'b00000000000000000000000000000000;
    tb_round_key = 'b000000000000000000000000000000000000000000000000;

    #(CHECK_DELAY)   
    assert(tb_out_left == 'b00000000000000000000000000000000);
    assert(tb_out_right == 'b11011000110110001101101110111100);

    
    // Send values and check assertions
    @(posedge tb_clk)
    tb_in_right = 'b00000000000000000000000000000000;
    tb_in_left = 'b00000000000000000000000000000000;
    tb_round_key = 'b111111111111111111111111111111111111111111111111;
    
    #(CHECK_DELAY)   
    assert(tb_out_left == 'b00000000000000000000000000000000);
    assert(tb_out_right == 'b00111000110110111111100111001011);
    

    // Send values and check assertions
    @(posedge tb_clk)
    tb_in_right = 'b11111111111111111111111111111111;
    tb_in_left = 'b11111111111111111111111111111111;
    tb_round_key = 'b000000000000000000000000000000000000000000000000;
    
    #(CHECK_DELAY)   
    assert(tb_out_left == 'b11111111111111111111111111111111);
    assert(tb_out_right == 'b11000111001001000000011000110100);
    
    
    // Send values and check assertions
    @(posedge tb_clk)
    tb_in_right = 'b11111111111111111111111111111111;
    tb_in_left = 'b11111111111111111111111111111111;
    tb_round_key = 'b111111111111111111111111111111111111111111111111;

    #(CHECK_DELAY)   
    assert(tb_out_left == 'b11111111111111111111111111111111);
    assert(tb_out_right == 'b00100111001001110010010001000011);
             

    // Send values and check assertions
    @(posedge tb_clk)
    tb_in_right = 'b11111111111111111111111111111111;
    tb_in_left = 'b00000000000000000000000000000000;
    tb_round_key ='b000000000000000000000000000000000000000000000000;

    #(CHECK_DELAY)   
    assert(tb_out_left == 'b11111111111111111111111111111111);
    assert(tb_out_right == 'b00111000110110111111100111001011);
    

    // Send values and check assertions
    @(posedge tb_clk)
    tb_in_right = 'b11111111111111111111111111111111;
    tb_in_left = 'b00000000000000000000000000000000;
    tb_round_key = 'b111111111111111111111111111111111111111111111111;

    #(CHECK_DELAY)   
    assert(tb_out_left == 'b11111111111111111111111111111111);
    assert(tb_out_right == 'b11011000110110001101101110111100);
    

    // Send values and check assertions
    @(posedge tb_clk)
    tb_in_right = 'b00000000000000000000000000000000;
    tb_in_left = 'b11111111111111111111111111111111;
    tb_round_key ='b000000000000000000000000000000000000000000000000;
  
    #(CHECK_DELAY)   
    assert(tb_out_left == 'b00000000000000000000000000000000);
    assert(tb_out_right == 'b00100111001001110010010001000011);
    

    // Send values and check assertions
    @(posedge tb_clk)
    tb_in_right = 'b00000000000000000000000000000000;
    tb_in_left = 'b11111111111111111111111111111111;
    tb_round_key = 'b111111111111111111111111111111111111111111111111;
  
    #(CHECK_DELAY)   
    assert(tb_out_left == 'b00000000000000000000000000000000);
    assert(tb_out_right == 'b11000111001001000000011000110100);
    

    // Send values and check assertions
    @(posedge tb_clk)
    tb_in_right = 'b00001111000011110000111100001111;
    tb_in_left = 'b11110000111100001111000011110000;
    tb_round_key = 'b111111111111111111111111111111111111111111111111;
    
    #(CHECK_DELAY)   
    assert(tb_out_left == 'b00001111000011110000111100001111);
    assert(tb_out_right == 'b01010011101110100011001111101010);
    

    // Send values and check assertions
    @(posedge tb_clk)
    tb_in_right = 'b10100101111100001100001111100010;
    tb_in_left = 'b10100101111100001100001111100010;  
    tb_round_key = 'b111100001110000111000011100001111010010111000101;
    
    #(CHECK_DELAY)
    assert(tb_out_left == 'b10100101111100001100001111100010);
    assert(tb_out_right == 'b10111000001000000101101001010100);
  end  
endmodule
