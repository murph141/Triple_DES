// $Id: $
// File name:   tb_AHBLiteSlaveController.sv
// Created:     4/27/2015
// Author:      Eric Murphy
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Testbench for the AHB-Lite Slave Controller.  This SystemVerilog file functions as the AHB-Lite Master Controller.

`timescale 1ns / 10ps

module tb_TopLevel();

  localparam CLK_PERIOD = 5; // 200 MHz clock
  localparam CHECK_DELAY = (CLK_PERIOD / 5.0);

  logic HCLK, HRESET, HMASTLOCK, HREADY, HRESP, HSEL, HWRITE;
  logic [1:0] HTRANS;
  logic [2:0] HBURST, HSIZE;
  logic [3:0] HPROT;
  logic [31:0] HADDR;
  logic [63:0] HRDATA, HWDATA;
  logic [63:0] encryptedChunk;

  TopLevel DUT
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
    .HRDATA(HRDATA),
    .HRESP(HRESP)
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

    /*setup(1'b1, 64'h736865726C6F636B, 64'h64736B65776A7272, 64'h6B776C6F70617772, 64'h5368656C6C73686F);

    sendData(64'h636B2C20616C736F);
    sendData(64'h206B6E6F776E2061);
    sendData(64'h732042617368646F);
    sendData(64'h6F722C2069732061);
    sendData(64'h2066616D696C7920);

    sendReceiveData(64'h6F66207365637572);
    sendReceiveData(64'h6974792062756773);
    sendReceiveData(64'h20696E2074686520);
    sendReceiveData(64'h776964656C792075);
    */

    setup(1'b0, 64'h6b776c6f70617772, 64'h64736B65776A7272, 64'h736865726c6f636b, 64'h14fead4c23fe9280);

    sendData(64'h8fe0d9c6b3674857);
    sendData(64'h0ec42b5c22a87f17);
    sendData(64'hc3e14ed7548b68d1);
    sendData(64'h95516e4a94baf816);
    sendData(64'hfa6f5f3315be4600);

    sendReceiveData(64'h40a1e8d9e4732dd5);
    sendReceiveData(64'h0c77f2cbfcd6c161);
    sendReceiveData(64'h194d293b3cd139fc);
    sendReceiveData(64'ha53f7186869a58d9);

    receiveData();
    receiveData();
    receiveData();
    receiveData();
    receiveData();
    receiveData();
    receiveData();

    wait8();

    $finish;
  end

  task wait8();
    #(CLK_PERIOD * 8);
  endtask

  // Set up the test bench with the initial values
  task init();
    @(posedge HCLK);
    #CHECK_DELAY;
    HRESET = 1'b0;

    @(posedge HCLK);
    #CHECK_DELAY;
    HMASTLOCK = 1'b0;
    HREADY = 1'b0;
    HSEL = 1'b0;
    HWRITE = 1'b0;
    HTRANS = 2'b00;
    HBURST = 3'b000;
    HSIZE = 3'b011;
    HPROT = 4'h3;
    HADDR = '0;
    HWDATA = '0;
    encryptedChunk = '0;

    @(posedge HCLK);
    #CHECK_DELAY;
    HRESET = 1'b1;

    @(posedge HCLK);
    #CHECK_DELAY;
  endtask

  // Send the initial values (Encryption / Decryption bit, three 64-bit user
  // keys, and a 64-bit chunk of data
  task setup(logic encDec, logic [63:0] keyOne, logic [63:0] keyTwo, logic [63:0] keyThree, logic [63:0] inData);
    @(posedge HCLK);
    #CHECK_DELAY;
    HSEL = 1'b1;
    HREADY = 1'b1;
    HWRITE = 1'b1;

    @(posedge HCLK);
    #CHECK_DELAY;
    HADDR = 32'hAAAAAAA0;
    
    @(posedge HCLK);
    #CHECK_DELAY;
    HWDATA = encDec;
    HADDR = 32'hAAAAAAA1;

    @(posedge HCLK);
    #CHECK_DELAY;
    HWDATA = keyOne;
    HADDR = 32'hAAAAAAA2;

    @(posedge HCLK);
    #CHECK_DELAY;
    HWDATA = keyTwo;
    HADDR = 32'hAAAAAAA3;

    @(posedge HCLK);
    #CHECK_DELAY;
    HWDATA = keyThree;
    HADDR = 32'hAAAAAAA4;

    @(posedge HCLK);
    #CHECK_DELAY;
    HWDATA = inData;
    HADDR = '0;

    @(posedge HCLK);
    HWDATA = '0;
    #(CLK_PERIOD * 6);
  endtask

  // After the initial data has been sent, send a 64-bit chunk of data
  task sendData(logic [63:0] newData);
    #CHECK_DELAY;
    HADDR = 32'hAAAAAAA4;

    @(posedge HCLK);
    #CHECK_DELAY;
    HWDATA = newData;
    HADDR = '0;

    @(posedge HCLK);
    #CHECK_DELAY;
    HWDATA = '0;

    @(posedge HCLK);
    #(CLK_PERIOD * 5);
  endtask

  // After the initial data has been sent, send a 64-bit chunk of data and
  // receive the 64-bit chunk of completed data
  // Values will be send on the second cycle, and values will be grabbed on
  // the seventh clock cycle
  task sendReceiveData(logic [63:0] newData);
    #CHECK_DELAY;
    HADDR = 32'hAAAAAAA4;

    @(posedge HCLK);
    #CHECK_DELAY;
    HWDATA = newData;
    HADDR = '0;

    @(posedge HCLK);
    #CHECK_DELAY;
    HWDATA = '0;

    @(posedge HCLK);
    #(CLK_PERIOD * 2);
    #CHECK_DELAY;
    HADDR = 32'hAAAAAAA8;
    HWRITE = 1'b0;

    @(posedge HCLK);
    #CHECK_DELAY;
    HADDR = '0;
    encryptedChunk = HRDATA;
    HWRITE = 1'b1;

    @(posedge HCLK);
    #CLK_PERIOD;
  endtask

  task receiveData();
    #CHECK_DELAY;
    HADDR = '0;
    HWDATA = '0;

    @(posedge HCLK);
    #(CLK_PERIOD * 4);
    #CHECK_DELAY;
    HADDR = 32'hAAAAAAA8;
    HWRITE = 1'b0;

    @(posedge HCLK);
    #CHECK_DELAY;
    encryptedChunk = HRDATA;
    HWRITE = 1'b1;

    @(posedge HCLK);
    #CLK_PERIOD;
  endtask

endmodule
