// $Id: $
// File name:   3DES.sv
// Created:     4/28/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Overall block of our Triple DES implementation.

module TopLevel
(
  input logic HREADY,

  input logic HCLK,
  input logic HMASTLOCK,
  input logic HRESET,
  input logic HSEL,
  input logic HWRITE,
  input logic [1:0] HTRANS,
  input logic [2:0] HBURST,
  input logic [2:0] HSIZE,
  input logic [3:0] HPROT,
  input logic [31:0] HADDR,
  input logic [63:0] HWDATA,

  output logic HRESP,
  output logic [63:0] HRDATA
);

  logic outputEnable, enable, encryptionType;
  logic [63:0] outputData, data, key1, key2, key3;

  AHBLiteSlaveController A0
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
    .outputEnable(outputEnable),
    .outputData(outputData),

    .HRESP(HRESP),
    .HRDATA(HRDATA),
    .enable(enable),
    .encryptionType(encryptionType),
    .data(data),
    .key1(key1),
    .key2(key2),
    .key3(key3)
  );

  triple_DES_block T0
  (
    .clk(HCLK),
    .enable(enable),
    .nrst(HRESET),
    .encr_decr(encryptionType),
    .input_data_block(data),
    .user_key1(key1),
    .user_key2(key2),
    .user_key3(key3),
    .output_data_block(outputData),
    .done(outputEnable)
  );

endmodule
