// $Id: $
// File name:   System.sv
// Created:     4/28/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Overall block of our Triple DES implementation.

module System
(
  input logic HCLK,
  input logic HMASTLOCK,
  input logic HRESET,
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

  // Instantiate the TopLevel Block
  TopLevel T0
  (
    .HCLK(HCLK),
    .HMASTLOCK(HMASTLOCK),
    .HREADY(HREADY),
    .HRESET(HRESET),
    .HWRITE(HWRITE),
    .HTRANS(HTRANS),
    .HBURST(HBURST),
    .HSIZE(HSIZE),
    .HPROT(HPROT),
    .HADDR(HADDR),
    .HWDATA(HWDATA),

    .HRESP(HRESP),
    .HRDATA(HRDATA)
  );

endmodule
