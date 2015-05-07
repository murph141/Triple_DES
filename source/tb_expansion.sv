// $Id: $
// File name:   tb_expansion.sv
// Created:     4/8/2015
// Author:      Isaac Sheeley
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: test bench for expansion
`timescale 1ns / 10ps

module tb_expansion();
  // Define parameters
    localparam    CHECK_DELAY = 2; // Check 2ns after the rising edge to allow for propagation delay

    logic [31:0]tb_RE_32bit;
    logic [47:0]tb_RE_48bit;
  
  
    expansion expansion_DUT (
        .RE_32bit(tb_RE_32bit),
        .RE_48bit(tb_RE_48bit)
    );
  
    // Test bench procedures
    initial
    begin
        // Initialize input signals
        tb_RE_32bit = 32'b11111111111111110000000000000000;
        #(CHECK_DELAY)

        if(tb_RE_48bit == 48'b011111111111111111111110100000000000000000000001)
            $info("Test Case 1: PASSED");
        else
            $error("Test Case 1: FAILED");

        // Initialize input signals
        tb_RE_32bit = 32'b10101010101010101010101010101010;
        #(CHECK_DELAY)

        if(tb_RE_48bit == 48'b010101010101010101010101010101010101010101010101)
            $info("Test Case 2: PASSED");
        else
            $error("Test Case 2: FAILED");

        // Initialize input signals
        tb_RE_32bit = 32'b01111100010101011001010101001011;
        #(CHECK_DELAY)

        if(tb_RE_48bit == 48'b101111111000001010101011110010101010101001010110)
            $info("Test Case 3: PASSED");
        else
            $error("Test Case 3: FAILED");

     
    
    end

endmodule
