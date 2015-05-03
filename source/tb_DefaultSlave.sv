// $Id: $
// File name:   tb_DefaultSlave.sv
// Created:     5/2/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Tests the functionality of the default slave.

module tb_DefaultSlave();

  localparam CLK_PERIOD = 5;
  localparam CHECK_DELAY = (CLK_PERIOD / 5.0);

  logic HCLK, HRESET, HMASTLOCK, HREADY, HSEL, HWRITE, HREADYOUT;
  logic [1:0] HTRANS;
  logic [2:0] HBURST, HSIZE;
  logic [3:0] HPROT;
  logic [31:0] HADDR;
  logic [63:0] HRDATA, HWDATA;

  assign HREADY = HREADYOUT;

  DefaultSlave DUT
  (
    .HCLK(HCLK),
    .HMASTLOCK(HMASTLOCK),
    .HREADY(HREADY),
    .HRESET(HRESET),
    .HSEL(HSEL),
    .HWRITE(HWRITE),
    .HTRANS(HTRANS),
    .HBURST(HBURST),
    .HSIZE(HSIZE),
    .HPROT(HPROT),
    .HADDR(HADDR),
    .HWDATA(HWDATA),
    .HREADYOUT(HREADYOUT),
    .HRESP(HRESP),
    .HRDATA(HRDATA)
  );

  always
  begin
    HCLK = 1'b0;
    #(CLK_PERIOD / 2.0);
    HCLK = 1'b1;
    #(CLK_PERIOD / 2.0);
  end

  initial
  begin
    init();

    #(CLK_PERIOD * 8.0);
    $finish;
  end

  task init();
    @(posedge HCLK);
    #CHECK_DELAY;
    HRESET = 1'b0;

    @(posedge HCLK);
    #CHECK_DELAY;
    HRESET = 1'b1;
    HMASTLOCK = 1'b0;
    HSEL = 1'b1;
    HWRITE = 1'b1;
    HTRANS = 2'b01;
    HBURST = '0;
    HSIZE = 3'b011;
    HPROT = 4'h0;
    HADDR = '0;
    HWDATA = '0;

    @(posedge HCLK);
  endtask

endmodule
