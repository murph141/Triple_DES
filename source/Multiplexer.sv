// $Id: $
// File name:   Multiplexer.sv
// Created:     5/2/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Multiplexer that helps divert the correct signals to the AHB-Lite bus.

module Multiplexer
(
  input logic muxSelect,
  input logic HREADYOUT_1,
  input logic HREADYOUT_2,
  input logic HRESP_1,
  input logic HRESP_2,
  input logic [63:0] HRDATA_1,
  input logic [63:0] HRDATA_2,

  output logic HREADY,
  output logic HRESP,
  output logic [63:0] HRDATA
);

  always_comb
  begin
    if(muxSelect == 1'b0)
    begin
      HREADY = HREADYOUT_1;
      HRESP = HRESP_1;
      HRDATA = HRDATA_1;
    end
    else
    begin
      HREADY = HREADYOUT_2;
      HRESP = HRESP_2;
      HRDATA = HRDATA_2;
    end
  end

endmodule
