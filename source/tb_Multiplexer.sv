// $Id: $
// File name:   tb_Multiplexer.sv
// Created:     5/2/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Used to test the bus multiplexer.

// Tests the AHB-Lite Interface's Multiplexer's functionality
module tb_Multiplexer();

  localparam WAIT = 5;

  logic HREADY, HREADY1, HREADY2, HRESP, HRESP1, HRESP2, muxSelect;
  logic [63:0] HRDATA, HRDATA1, HRDATA2;

  // Instantiate the Multiplexer
  Multiplexer DUT
  (
    .muxSelect(muxSelect),
    .HREADYOUT_1(HREADY1),
    .HREADYOUT_2(HREADY2),
    .HRESP_1(HRESP1),
    .HRESP_2(HRESP2),
    .HRDATA_1(HRDATA1),
    .HRDATA_2(HRDATA2),
    .HREADY(HREADY),
    .HRESP(HRESP),
    .HRDATA(HRDATA)
  );

  initial
  begin
    setupValues(1'b0, 1'b1, 1'b1, 1'b1, 1'b0, '0, '1);

    setupValues(1'b1, 1'b1, 1'b1, 1'b1, 1'b0, '0, '1);

    setupValues(1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 64'hABCDEF1234567890, 64'h1234567890ABCDEF);

    #WAIT;

    $finish;
  end

  // Set the values coming in to the Multiplexer and the select line
  task setupValues(logic select, logic HREADY_1, logic HREADY_2, logic HRESP_1, logic HRESP_2, logic [63:0] HRDATA_1, logic [63:0] HRDATA_2);
    #WAIT;

    muxSelect = select;
    HREADY1 = HREADY_1;
    HREADY2 = HREADY_2;
    HRESP1 = HRESP_1;
    HRESP2 = HRESP_2;
    HRDATA1 = HRDATA_1;
    HRDATA2 = HRDATA_2;
    
  endtask

endmodule
