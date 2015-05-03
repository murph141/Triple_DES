// $Id: $
// File name:   DefaultSlave.sv
// Created:     5/2/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Default slave used to take care of requests that originate from addresses that were not assigned to the slave connected to our design.
//              According to specifications, this slave needs to be present if the system design does not contain a completely filled memory map.


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

  logic pastTrans, pastSel, pastWrite;
  logic [31:0] pastAddress;
  logic [63:0] tempData;

  always_ff @ (posedge HCLK, negedge HRESET)
  begin
    if(HRESET == 1'b0)
    begin
      pastTrans <= 2'b00;
      pastSel <= 1'b0;
      pastAddress <= '0;
      pastWrite <= 1'b1;

      // Slaves must assert HREADYOUT during reset as per specification
      HREADYOUT <= 1'b1;
    end
    else
    begin
      pastTrans <= HTRANS;
      pastSel <= HSEL;
      pastAddress <= HADDR;
      pastWrite <= HWRITE;

      if(HRESP == 1'b1 && HREADY == 1'b0)
      begin
        HRESP <= 1'b1;
        HREADYOUT <= 1'b1;
      end
      else if(pastTrans == 2'b00)
      begin
        HRESP <= 1'b0;
        HREADYOUT <= 1'b1;
      end
      else if(HPROT != 4'h1 || HMASTLOCK != 1'b0 || HBURST != 3'b000 || HSIZE != 3'b011 || pastTrans != 2'b01)
      begin
        HRESP <= 1'b1;
        HREADYOUT <= 1'b0;
      end
      else if(pastSel == 1'b1)
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

  /* TODO
  always_ff @ (posedge HCLK)
  begin
  end
  */

endmodule
