// $Id: $
// File name:   DefaultSlave.sv
// Created:     5/2/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Default slave used to take care of requests that originate from addresses that were not assigned to the slave connected to our design.
//              According to specifications, this slave needs to be present if the system design does not contain a completely filled memory map.


// This save will repond to events in the address range of 0x00001400 to 0xFFFFFFFF
module DefaultSlave
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

  output logic HREADYOUT,
  output logic HRESP,
  output logic [63:0] HRDATA
);

  logic pastSelect, pastTrans, pastWrite;
  logic [31:0] pastAddress;
  logic [63:0] tempData;

  always_ff @ (posedge HCLK, negedge HRESET)
  begin
    if(HRESET == 1'b0)
    begin
      // Reset all of the temp values
      pastTrans <= 2'b00;
      pastSelect <= 1'b0;
      pastAddress <= '0;
      pastWrite <= 1'b1;
      HRESP <= 1'b0;

      // Slaves must assert HREADYOUT during reset as per specification
      HREADYOUT <= 1'b1;
    end
    else
    begin
      // Set all of the temp values to their previous values
      pastTrans <= HTRANS;
      pastSelect <= HSEL;
      pastAddress <= HADDR;
      pastWrite <= HWRITE;

      // Take care of all the error checks and responses
      if(HRESP == 1'b1 && HREADY == 1'b0)
      begin
        HRESP <= 1'b1;
        HREADYOUT <= 1'b1;
      end
      else if(pastAddress < 32'h00001400 && pastSelect == 1'b1)
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
      else if(HPROT != 4'h1 || HMASTLOCK != 1'b0 || HBURST != 3'b000 || HSIZE != 3'b011 || pastTrans != 2'b01)
      begin
        HRESP <= 1'b1;
        HREADYOUT <= 1'b0;
      end

      // Read or write data, depending on the situation
      else if(pastSelect == 1'b1)
      begin
        if(pastWrite == 1'b1)
        begin
          tempData <= HWDATA;
        end
        else
        begin
          HRDATA <= 64'hABCDEF1234567890;
        end
      end
    end
  end

endmodule
