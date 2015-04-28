// $Id: $
// File name:   AHB-LiteSlaveController.sv
// Created:     4/27/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: The AHB-Lite Slave Controller for our Triple DES design.

module AHBLiteSlaveController
(
  input logic outputEnable,
  input logic [63:0] outputData,

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

  output logic enable,
  output logic encryptionType,
  output logic [63:0] data,
  output logic [63:0] key1,
  output logic [63:0] key2,
  output logic [63:0] key3,

  output logic HRESP,
  output logic [63:0] HRDATA
);

  logic [31:0] currentAddress;
  logic nextEnable;

  typedef enum logic [2:0] {ERROR, IDLE, STARTED, READING, READ, WRITING, WRITE} state_type;

  state_type state, next_state;

  // Next State Logic
  always_comb
  begin
    next_state = state;

    case(state)
      IDLE:
      begin
        if(HSEL == 1'b1)
          next_state = STARTED;
      end

      STARTED:
      begin
        if(HSEL == 1'b0)
          next_state = IDLE;
        else if(HREADY == 1'b1 && HWRITE == 1'b1)
          next_state = READING;
        else if(HREADY == 1'b1 && HWRITE == 1'b0)
          next_state = WRITING;
      end

      READING:
      begin
        if((currentAddress[31:3] == {28'hAAAAAAA, 1'b0}) && HSEL == 1'b1)
          next_state = READ;
        else if(HSEL == 1'b0)
          next_state = ERROR;
      end

      READ:
      begin
        if(HSEL == 1'b0)
          next_state = IDLE;
        else if(HREADY == 1'b1 && HWRITE == 1'b0)
          next_state = WRITING;
        else if(HREADY == 1'b1 && HWRITE == 1'b1)
          next_state = READING;
        else
          next_state = STARTED;
      end

      WRITING:
      begin
        if((currentAddress[31:0] == 32'hAAAAAAA8) && HSEL == 1'b1)
          next_state = WRITE;
        else if(HSEL == 1'b0)
          next_state = ERROR;
      end

      WRITE:
      begin
        if(HSEL == 1'b0)
          next_state = IDLE;
        else if(HREADY == 1'b1 && HWRITE == 1'b0)
          next_state = WRITING;
        else if(HREADY == 1'b1 && HWRITE == 1'b1)
          next_state = READING;
        else
          next_state = STARTED;
      end
    endcase

    if(HPROT != 4'h3 || HMASTLOCK != 1'b0 || HBURST != 3'b000 || HSIZE != 3'b011 || (HTRANS != 2'b00 && HTRANS != 2'b10))
      next_state = ERROR;

  end

  // State Register
  always_ff @ (posedge HCLK, negedge HRESET)
  begin
    if(HRESET == 1'b0)
    begin
      state <= IDLE;
      currentAddress = '0;
      enable = 1'b0;
    end
    else
    begin
      state <= next_state;
      enable <= nextEnable;
      currentAddress <= HADDR;
    end
  end

  // Output Logic
  always_comb
  begin
    HRESP = 1'b0;
    encryptionType = 1'b0;
    data = '0;
    key1 = '0;
    key2 = '0;
    key3 = '0;
    HRDATA = '0;
    nextEnable = 1'b0;

    case(state)
      READ:
      begin
        if(currentAddress[2] == 1'b1)
        begin
          data = HWDATA;
          nextEnable = 1'b1;
        end
        else if(currentAddress[1:0] == 2'b00)
          encryptionType = HWDATA[0];
        else if(currentAddress[1:0] == 2'b01)
          key1 = HWDATA;
        else if(currentAddress[1:0] == 2'b10)
          key2 = HWDATA;
        else
          key3 = HWDATA;
      end

      WRITE:
      begin
        HRDATA = outputData;
      end

      ERROR:
      begin
        HRESP = 1'b1;
      end

    endcase

    if(enable == 1'b1 && (state != IDLE) && (state != ERROR))
      nextEnable = 1'b1;

  end

endmodule
