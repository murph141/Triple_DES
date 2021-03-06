// $Id: $
// File name:   tb_Decoder.sv
// Created:     5/2/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Testing the decoder.

// Tests the AHB-Lite Interface's Decoder functionality
module tb_Decoder();

  localparam WAIT = 5;

  logic muxSelect;
  logic [31:0] tb_HADDR;

  // Instantiate the Decoder
  Decoder DUT
  (
    .HADDR(tb_HADDR),
    .muxSelect(muxSelect)
  );

  initial
  begin
    setValues('0);
    setValues('1);
    setValues(32'h00001400);
    setValues(32'h000013FF);

    #WAIT;
    $finish;
  end

  // Set the address values
  task setValues(logic [31:0] addr);
    #WAIT;
    tb_HADDR = addr;
  endtask

endmodule
