// $Id: $
// File name:   DES_round_wrapper.sv
// Created:     4/16/2015
// Author:      Anthony Kang
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: wrapper file for one round of DES
module DES_round_wrapper (
    input wire [31:0] in_right,
    input wire [31:0] in_left,
    input wire [47:0] round_key,
    output wire [31:0] out_right,
    output wire [31:0] out_left
);
  
  assign out_left = in_right;
  
  logic [47:0] ex_perm_out;
  logic [47:0] xorblock1;
  logic [31:0] sbox_out;
  logic [31:0] pbox_out;

  
  expansion EX_PERM (.RE_32bit(in_right), .RE_48bit(ex_perm_out));
  
  assign xorblock1 = ex_perm_out ^ round_key;
  
  s_box_wrapper SUB (.in_48bit(xorblock1), .out_32bit(sbox_out));
  
  PBox PBOX (.data(sbox_out), .p_data(pbox_out));
  
  assign out_right = pbox_out ^ in_left;
  
  
  

endmodule