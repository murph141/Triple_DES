// $Id: $
// File name:   s_box_wrapper.sv
// Created:     4/16/2015
// Author:      Anthony Kang
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: sbox wrapper file.
module s_box_wrapper (
    input wire [47:0] in_48bit,
    output wire [31:0] out_32bit
  );
  
 
  
  logic [3:0] s_box1_out4bit;
  logic [3:0] s_box2_out4bit;
  logic [3:0] s_box3_out4bit;
  logic [3:0] s_box4_out4bit;
  logic [3:0] s_box5_out4bit;
  logic [3:0] s_box6_out4bit;
  logic [3:0] s_box7_out4bit;
  logic [3:0] s_box8_out4bit;
  
  s_box1 SUB1 (.in_6bit(in_48bit[47:42]), .out_4bit(s_box1_out4bit));
  s_box2 SUB2 (.in_6bit(in_48bit[41:36]), .out_4bit(s_box2_out4bit));
  s_box3 SUB3 (.in_6bit(in_48bit[35:30]), .out_4bit(s_box3_out4bit));
  s_box4 SUB4 (.in_6bit(in_48bit[29:24]), .out_4bit(s_box4_out4bit));
  s_box5 SUB5 (.in_6bit(in_48bit[23:18]), .out_4bit(s_box5_out4bit));
  s_box6 SUB6 (.in_6bit(in_48bit[17:12]), .out_4bit(s_box6_out4bit));
  s_box7 SUB7 (.in_6bit(in_48bit[11:6]), .out_4bit(s_box7_out4bit));
  s_box8 SUB8 (.in_6bit(in_48bit[5:0]), .out_4bit(s_box8_out4bit));
  
  assign out_32bit = {s_box1_out4bit, s_box2_out4bit, s_box3_out4bit, s_box4_out4bit, s_box5_out4bit, s_box6_out4bit, s_box7_out4bit, s_box8_out4bit};
  
  
endmodule
  
  
  