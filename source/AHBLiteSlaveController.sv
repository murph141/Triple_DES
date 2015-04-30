// $Id: $
// File name:   AHB-LiteSlaveController.sv
// Created:     4/27/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: The AHB-Lite Slave Controller for our Triple DES design.

module AHBLiteSlaveController
(
  input logic HREADY,

  input logic outputEnable,
  input logic [63:0] outputData,

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

  output logic enable,
  output logic encryptionType,
  output logic [63:0] data,
  output logic [63:0] key1,
  output logic [63:0] key2,
  output logic [63:0] key3,

  output logic HRESP,
  output logic [63:0] HRDATA
);

  logic [31:0] pastAddress;
  logic pastWrite, nextEnable;

  logic [63:0] oldKey1, oldKey2, oldKey3, oldData;
  logic oldEncryptionType;

  always_ff @ (posedge HCLK, negedge HRESET)
  begin
    if(HRESET == 1'b0)
    begin
      pastAddress <= '0;
      pastWrite <= 1'b0;
      HRESP <= 1'b0;
      enable <= 1'b0;
    end

    else
    begin
      pastAddress <= HADDR;
      pastWrite <= HWRITE;
      enable <= nextEnable;

      if(HRESP == 1'b1)
      begin
        HRESP <= 1'b1;
      end
      else
        HRESP <= (HPROT != 4'h3 || HMASTLOCK != 1'b0 || HBURST != 3'b000 || HSIZE != 3'b011 || (HTRANS != 2'b00 && HTRANS != 2'b10) || (HSEL == 1'b0 && HREADY == 1'b1));

    end
  end

  always_ff @ (posedge HCLK)
  begin
    if(HREADY == 1'b1 && pastWrite == 1'b1 && HSEL == 1'b1)
    begin
      case(pastAddress)
        32'hAAAAAAA0:
        begin
          encryptionType <= HWDATA[0];
          key1 <= oldKey1;
          key2 <= oldKey2;
          key3 <= oldKey3;
          data <= oldData;
        end

        32'hAAAAAAA1:
        begin
          encryptionType <= oldEncryptionType;
          key1 <= HWDATA;
          key2 <= oldKey2;
          key3 <= oldKey3;
          data <= oldData;
        end

        32'hAAAAAAA2:
        begin
          encryptionType <= oldEncryptionType;
          key1 <= oldKey1;
          key2 <= HWDATA;
          key3 <= oldKey3;
          data <= oldData;
        end

        32'hAAAAAAA3:
        begin
          encryptionType <= oldEncryptionType;
          key1 <= oldKey1;
          key2 <= oldKey2;
          key3 <= HWDATA;
          data <= oldData;
        end

        32'hAAAAAAA4:
        begin
          encryptionType <= oldEncryptionType;
          key1 <= oldKey1;
          key2 <= oldKey2;
          key3 <= oldKey3;
          data <= HWDATA;
        end
      endcase
    end

    else if(HREADY == 1'b1 && pastWrite == 1'b0 && outputEnable == 1'b1 && HSEL == 1'b1)
    begin
      HRDATA <= outputData;
    end
    else if(HREADY == 1'b1 && pastWrite == 1'b0 && outputEnable == 1'b0 && HSEL == 1'b1)
    begin
      HRDATA <= '0;
    end
  end

  assign nextEnable = (pastAddress == 32'hAAAAAAA4) && (HRESP == 1'b0);
  assign oldEncryptionType = encryptionType;
  assign oldKey1 = key1;
  assign oldKey2 = key2;
  assign oldKey3 = key3;
  assign oldData = data;

endmodule
