// $Id: $
// File name:   Decoder.sv
// Created:     5/2/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Used to decode HADDR, and select the appropriate slave.

module Decoder
(
  input logic [31:0] HADDR,
  output logic muxSelect
);

  always_comb
  begin
    if(HADDR >= 32'h00000000 && HADDR < 32'h00001400)
      muxSelect = 1'b0;
    else
      muxSelect = 1'b1;
  end

endmodule
