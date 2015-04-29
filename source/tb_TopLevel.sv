// $Id: $
// File name:   tb_AHBLiteSlaveController.sv
// Created:     4/27/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Testbench for the AHB-Lite Slave Controller.  This SystemVerilog file functions as the AHB-Lite Master Controller.

`timescale 1ns / 10ps

module tb_TopLevel();

  localparam CLK_PERIOD = 5; // 200 MHz clock
  localparam CHECK_DELAY = (CLK_PERIOD / 5.0);

  logic HCLK, HRESET, HMASTLOCK, HREADY, HRESP, HSEL, HWRITE;
  logic [1:0] HTRANS;
  logic [2:0] HBURST, HSIZE;
  logic [3:0] HPROT;
  logic [31:0] HADDR;
  logic [63:0] HRDATA, HWDATA;

  TopLevel DUT
  (
    .HCLK(HCLK),
    .HMASTLOCK(HMASTLOCK),
    .HREADY(HREADY),
    .HRESET(HRESET),
    .HSEL(HSEL),
    .HWRITE(HWRITE),
    .HTRANS(HTRANS),
    .HBURST(HBURST),
    .HSIZE(HSIZE),
    .HPROT(HPROT),
    .HADDR(HADDR),
    .HWDATA(HWDATA),
    .HRDATA(HRDATA),
    .HRESP(HRESP)
  );

  always
  begin
    HCLK = 1'b0;
    #(CLK_PERIOD / 2.0);
    HCLK = 1'b1;
    #(CLK_PERIOD / 2.0);
  end

  initial
  begin
    init();

    setup(1'b1, 64'h4444444444444444, 64'h4444444444444444, 64'h4444444444444444, 64'h6666666666666666);

    sendData(64'h4444444444444444);
    sendData(64'h5555555555555555);
    sendData(64'h6666666666666666);
    sendData(64'h7777777777777777);
    sendData(64'h8888888888888888);
    sendData(64'h9999999999999999);
    sendData(64'hAAAAAAAAAAAAAAAA);
    sendData(64'hBBBBBBBBBBBBBBBB);
    sendData(64'hCCCCCCCCCCCCCCCC);

    $finish;
  end


  // Set up the test bench with the initial values
  task init();
    @(posedge HCLK);
    #CHECK_DELAY;
    HRESET = 1'b0;

    @(posedge HCLK);
    #CHECK_DELAY;
    HMASTLOCK = 1'b0;
    HREADY = 1'b0;
    HSEL = 1'b0;
    HWRITE = 1'b0;
    HTRANS = 2'b00;
    HBURST = 3'b000;
    HSIZE = 3'b011;
    HPROT = 4'h3;
    HADDR = '0;
    HWDATA = '0;

    @(posedge HCLK);
    #CHECK_DELAY;
    HRESET = 1'b1;

    @(posedge HCLK);
    #CHECK_DELAY;
  endtask

  // Send the initial values (Encryption / Decryption bit, three 64-bit user
  // keys, and a 64-bit chunk of data
  task setup(logic encDec, logic [63:0] keyOne, logic [63:0] keyTwo, logic [63:0] keyThree, logic [63:0] inData);
    @(posedge HCLK);
    #CHECK_DELAY;
    HSEL = 1'b1;
    HREADY = 1'b1;
    HWRITE = 1'b1;

    @(posedge HCLK);
    #CHECK_DELAY;
    HADDR = 32'hAAAAAAA0;
    
    @(posedge HCLK);
    #CHECK_DELAY;
    HWDATA = encDec;
    HADDR = 32'hAAAAAAA1;

    @(posedge HCLK);
    #CHECK_DELAY;
    HWDATA = keyOne;
    HADDR = 32'hAAAAAAA2;

    @(posedge HCLK);
    #CHECK_DELAY;
    HWDATA = keyTwo;
    HADDR = 32'hAAAAAAA3;

    @(posedge HCLK);
    #CHECK_DELAY;
    HWDATA = keyThree;
    HADDR = 32'hAAAAAAA4;

    @(posedge HCLK);
    #CHECK_DELAY;
    HWDATA = inData;
    HADDR = '0;

    @(posedge HCLK);
    #(CLK_PERIOD * 6);
  endtask

  // After the initial data has been sent, send a 64-bit chunk of data
  task sendData(logic [63:0] newData);
    #CHECK_DELAY;
    HADDR = 32'hAAAAAAA4;

    @(posedge HCLK);
    #CHECK_DELAY;
    HWDATA = newData;
    HADDR = '0;

    @(posedge HCLK);
    #(CLK_PERIOD * 6);
  endtask

endmodule