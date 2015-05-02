// $Id: $
// File name:   TopLevel.sv
// Created:     4/28/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Overall block of our Triple DES implementation.

module TopLevel
(
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

  output logic HREADY,
  output logic HRESP,
  output logic [63:0] HRDATA
);

  logic outputEnable, enable, encryptionType, muxSelect, muxSelect_ff;
  logic HREADYOUT_1, HREADYOUT_2, HRESP_1, HRESP_2;
  logic [63:0] HRDATA_1, HRDATA_2;
  logic [63:0] outputData, data, key1, key2, key3;

  AHBLiteSlaveController A0
  (
    .HCLK(HCLK),
    .HMASTLOCK(HMASTLOCK),
    .HREADY(HREADY),
    .HRESET(HRESET),
    .HSEL(~muxSelect),
    .HWRITE(HWRITE),
    .HTRANS(HTRANS),
    .HBURST(HBURST),
    .HSIZE(HSIZE),
    .HPROT(HPROT),
    .HADDR(HADDR),
    .HWDATA(HWDATA),
    .outputEnable(outputEnable),
    .outputData(outputData),

    .HRESP(HRESP_1),
    .HRDATA(HRDATA_1),
    .enable(enable),
    .encryptionType(encryptionType),
    .data(data),
    .key1(key1),
    .key2(key2),
    .key3(key3),
    .HREADYOUT(HREADYOUT_1)
  );

  DefaultSlave D0
  (
    .HCLK(HCLK),
    .HMASTLOCK(HMASTLOCK),
    .HREADY(HREADY),
    .HRESET(HRESET),
    .HSEL(muxSelect),
    .HWRITE(HWRITE),
    .HTRANS(HTRANS),
    .HBURST(HBURST),
    .HSIZE(HSIZE),
    .HPROT(HPROT),
    .HADDR(HADDR),
    .HWDATA(HWDATA),
    .HRESP(HRESP_2),
    .HRDATA(HRDATA_2),
    .HREADYOUT(HREADYOUT_2)
  );

  Decoder Dec0
  (
    .HADDR(HADDR),
    .muxSelect(muxSelect)
  );

  Multiplexer M0
  (
    .muxSelect(muxSelect_ff),
    .HREADYOUT_1(HREADYOUT_1),
    .HREADYOUT_2(HREADYOUT_2),
    .HRESP_1(HRESP_1),
    .HRESP_2(HRESP_2),
    .HRDATA_1(HRDATA_1),
    .HRDATA_2(HRDATA_2),
    .HREADY(HREADY),
    .HRESP(HRESP),
    .HRDATA(HRDATA)
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

  always_ff @ (posedge HREADY, negedge HRESET)
  begin
    if(HRESET == 1'b0)
      muxSelect_ff <= 1'b0;
    else
      muxSelect_ff <= muxSelect;
  end

endmodule
