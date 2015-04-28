// $Id: $
// File name:   AHB-LiteSlaveController.sv
// Created:     4/27/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: The AHB-Lite Slave Controller for our Triple DES design.

module AHBLiteSlaveController
(
  input logic [63:0] output_data,

  input logic HCLK,
  input logic HMASTLOCK,
  input logic HREADY,
  input logic HRESET,
  input logic HSEL,
  input logic HWRITE,
  input logic [1:0] HTRANS,
  input logic [2:0] HBURST,
  input logic [2:0] HSIZE,
  input logic [3:0] HPROT,
  input logic [31:0] HADDR,
  input logic [63:0] HWDATA,

  output logic encryption_type,
  output logic [63:0] data,
  output logic [63:0] key1,
  output logic [63:0] key2,
  output logic [63:0] key3,

  output logic HREADYOUT,
  output logic HRESP,
  output logic [63:0] HRDATA
);

  typedef enum logic [4:0] {ERROR, IDLE, SELECTED, START1, START2, SETENCDEC, SETKEY1, SETKEY2, SETKEY3, SETDATA, GETDATA, SETREAD, MASTERGRAB, DUMMY1, DUMMY2, DUMMY3, DUMMY4} state_type;

  state_type state, next_state;

  // Next State Logic
  always_comb
  begin
    next_state = state;
  end

  // State Register
  always_ff @ (posedge HCLK, negedge HRESET)
  begin
    if(HRESET == 1'b0)
      state <= IDLE;
    else
      state <= next_state;
  end

  // Output Logic
  always_comb
  begin
  end

endmodule
