// $Id: $
// File name:   tb_s_box1.sv
// Created:     4/8/2015
// Author:      Isaac Sheeley
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: test bench for sbox1
`timescale 1ns / 10ps

module tb_s_box1();
  // Define parameters
    localparam    CHECK_DELAY = 2; // Check 2ns after the rising edge to allow for propagation delay

    logic [5:0]tb_in_6bit;
    logic [3:0]tb_out_4bit;
  
  
    s_box1 s_box1_DUT (
        .in_6bit (tb_in_6bit),
        .out_4bit(tb_out_4bit)
    );
  
 
    
    // Test bench procedures
    initial
    begin
        tb_in_6bit = 6'd0;
        #CHECK_DELAY
        if(tb_out_4bit == 4'd14)
        	$info("GOOD");
        else
        	$error("BAD");
     
    	
    	tb_in_6bit = 6'b110010;
        #CHECK_DELAY
        if(tb_out_4bit == 4'd12)
        	$info("GOOD");
        else
        	$error("BAD");
     
    	
    end

endmodule