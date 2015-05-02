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

  assign HREADYOUT = 1'b1;

  // TODO
  assign HRDATA = '0;

  always_ff @ (posedge HCLK, negedge HRESET)
  begin
    if(HRESET == 1'b0)
    begin
      HRESP <= 1'b0;
    end
    else
    begin
      if(HRESP == 1'b1)
        HRESP <= 1'b1;
      else
        HRESP <= (HTRANS == 2'b10 || HTRANS == 2'b11);
    end
  end

  /* TODO
  always_ff @ (posedge HCLK)
  begin
  end
  */

endmodule
