// $Id: $
// File name:   tb_AHBLiteSlaveController.sv
// Created:     4/27/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Testbench for the AHB-Lite Slave Controller.  This SystemVerilog file functions as the AHB-Lite Master Controller.

`timescale 1ns / 10ps

module tb_AHBLiteSlaveController();

  localparam CLK_PERIOD = 5; // 200 MHz clock
  localparam CHECK_DELAY = 1;

  logic HCLK, HRESET, HMASTLOCK, HREADY, HRESP, HSEL, HWRITE;
  logic [1:0] HTRANS;
  logic [2:0] HBURST, HSIZE;
  logic [3:0] HPROT;
  logic [31:0] HADDR;
  logic [63:0] HRDATA, HWDATA;
  logic [63:0] data, key1, key2, key3, outputData;
  logic enable, encryptionType;

  AHBLiteSlaveController DUT
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
    .HRESP(HRESP),
    .outputEnable(1'b1),
    .outputData(outputData),
    .enable(enable),
    .encryptionType(encryptionType),
    .data(data),
    .key1(key1),
    .key2(key2),
    .key3(key3)
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
  end

endmodule
