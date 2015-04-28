// $Id: $
// File name:   tb_triple_DES_block.sv
// Created:     4/28/2015
// Author:      Isaac Sheeley
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: triple DES test bench
`timescale 1ns / 10ps

module tb_triple_DES_block ();

	// Define parameters
    localparam  CLK_PERIOD  = 5; // 200MHz clock
    localparam  CHECK_DELAY = 1; // Check 2ns after the rising edge to allow for propagation delay

    logic tb_clk;
    logic tb_nrst;
    logic tb_enable;
    logic tb_encr_decr;
    logic tb_done;
  
    logic[63:0] tb_input_data_block;
    logic[63:0] tb_output_data_block;
    logic[63:0] tb_user_key1;
    logic[63:0] tb_user_key2;
    logic[63:0] tb_user_key3;
    
    //variable for showing when the code is checking the output
    logic im_checking_now;


    triple_DES_block DUT_3DES(
    	.clk      (clk),
    	.enable   (enable),
    	.nrst     (nrst),
    	.encr_decr(encr_decr),
    	.done     (done),
    	.input_data_block(tb_input_data_block),
    	.output_data_block(tb_output_data_block),
    	.user_key1(tb_user_key1),
    	.user_key2(tb_user_key2),
    	.user_key3(tb_user_key3)

    );



    // Generate clock signal
    always begin
        tb_clk = 1'b0;
        #(CLK_PERIOD/2.0);
        tb_clk = 1'b1;
        #(CLK_PERIOD/2.0);
    end


    // Test bench procedures
    initial
    begin
        //Reset everything
        tb_nrst = 0;
        #(CHECK_DELAY)
        tb_nrst = 1;
        #(CHECK_DELAY)

        //Assign the keys
        tb_user_key1 = 64'h736865726c6f636b;
        tb_user_key2 = 64'h736865726c6f636b;
        tb_user_key3 = 64'h736865726c6f636b;

        //enable it to run
        tb_enable = 1;
        im_checking_now = 0;

        //Set for encryption
        tb_encr_decr = 1;

        //Set data block
        tb_input_data_block = 64'h5368656C6C73686F;

        //Setting values
        @(posedge tb_clk)


        //16 rounds of processing
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)

        tb_enable = 0;
   		
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)


        //16 rounds of processing
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)


        //16 rounds of processing
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)	
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)

        //Basically CHECK_DELAY
        @(posedge tb_clk)

        im_checking_now = 1;
        if(tb_output_data_block == 64'h81C28058B7764C21)
            $info("1 PASSSED");
        else
            $error("1 BAD!");



        

    end







endmodule