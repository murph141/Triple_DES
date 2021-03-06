// $Id: $
// File name:   AHB-LiteSlaveController.sv
// Created:     4/27/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: The AHB-Lite Slave Controller for our Triple DES design.

// This slave controller will respond to requests with HADDR ranging from 0x00000000 to 0x000013FF
module AHBLiteSlaveController
(
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

  input logic outputEnable,
  input logic [63:0] outputData,

  output logic HREADYOUT,
  output logic HRESP,
  output logic [63:0] HRDATA,

  output logic enable,
  output logic encryptionType,
  output logic [63:0] data,
  output logic [63:0] key1,
  output logic [63:0] key2,
  output logic [63:0] key3

);

  logic nextEnable, oldEncryptionType, pastSelect, pastWrite;
  logic [1:0] pastTrans;
  logic [31:0] pastAddress;
  logic [63:0] oldData, oldKey1, oldKey2, oldKey3;

  always_ff @ (posedge HCLK, negedge HRESET)
  begin
    if(HRESET == 1'b0)
    begin
      // Reset all of the temp values
      pastAddress <= '0;
      pastWrite <= 1'b1;
      pastSelect <= 1'b0;
      pastTrans <= 2'b00;
      HRESP <= 1'b0;
      enable <= 1'b0;

      // Slaves must assert HREADYOUT during reset as per specification
      HREADYOUT <= 1'b1;
    end

    else
    begin
      // Sample the values
      pastAddress <= HADDR;
      pastWrite <= HWRITE;
      pastSelect <= HSEL;
      pastTrans <= HTRANS;
      enable <= nextEnable;

      // Take care of error responses (Checks all of the conditions)
      if(HRESP == 1'b1 && HREADY == 1'b0)
      begin
        HRESP <= 1'b1;
        HREADYOUT <= 1'b1;
      end
      else if(pastAddress >= 32'h00001400 && pastSelect == 1'b1)
      begin
        HRESP <= 1'b1;
        HREADYOUT <= 1'b0;
      end
      else if(pastTrans == 2'b00)
      begin
        HRESP <= 1'b0;
        HREADYOUT <= 1'b1;
      end
      else if(pastTrans == 2'b10 && pastSelect == 1'b0)
      begin
        HRESP <= 1'b1;
        HREADYOUT <= 1'b0;
      end
      else if(HPROT != 4'h1 || HMASTLOCK != 1'b0 || HBURST != 3'b000 || HSIZE != 3'b011 || pastTrans != 2'b10)
      begin
        HRESP <= 1'b1;
        HREADYOUT <= 1'b0;
      end
    end
  end

  always_ff @ (posedge HCLK)
  begin
    if(HREADY == 1'b1 && pastWrite == 1'b1 && pastSelect == 1'b1 && pastTrans != 2'b00)
    begin
      // Check the current address, and address the appropriate value
      if(pastAddress < 32'h00000400)
        begin
          encryptionType <= HWDATA[0];
          key1 <= oldKey1;
          key2 <= oldKey2;
          key3 <= oldKey3;
          data <= oldData;
        end

      else if(pastAddress < 32'h00000800)
        begin
          encryptionType <= oldEncryptionType;
          key1 <= HWDATA;
          key2 <= oldKey2;
          key3 <= oldKey3;
          data <= oldData;
        end

      else if(pastAddress < 32'h00000C00)
        begin
          encryptionType <= oldEncryptionType;
          key1 <= oldKey1;
          key2 <= HWDATA;
          key3 <= oldKey3;
          data <= oldData;
        end

      else if(pastAddress < 32'h00001000)
        begin
          encryptionType <= oldEncryptionType;
          key1 <= oldKey1;
          key2 <= oldKey2;
          key3 <= HWDATA;
          data <= oldData;
        end

      else if(pastAddress < 32'h00001400)
        begin
          encryptionType <= oldEncryptionType;
          key1 <= oldKey1;
          key2 <= oldKey2;
          key3 <= oldKey3;
          data <= HWDATA;
        end
      end

    // Determine whether to send data, or zero it out
    else if(HREADY == 1'b1 && pastWrite == 1'b0 && outputEnable == 1'b1 && pastSelect == 1'b1 && pastTrans != 2'b00)
    begin
      HRDATA <= outputData;
    end
    else if(HREADY == 1'b1 && pastWrite == 1'b0 && outputEnable == 1'b0 && pastSelect == 1'b1 && pastTrans != 2'b00)
    begin
      HRDATA <= '0;
    end
  end

  // Assign the next variables
  assign nextEnable = (pastAddress >= 32'h00001000 && pastAddress < 32'h00001400) && (HRESP == 1'b0);
  assign oldEncryptionType = encryptionType;
  assign oldKey1 = key1;
  assign oldKey2 = key2;
  assign oldKey3 = key3;
  assign oldData = data;

endmodule
