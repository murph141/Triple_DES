// $Id: $
// File name:   PBox.sv
// Created:     4/1/2015
// Author:      Anthony Kang
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Permutation Box
module PBox(
  input wire [31:0] data,
  output wire [31:0] p_data
);

assign p_data = {data[16], data[5], data[12], data[11], data[3], data[20], data[4], data[15],
                 data[31], data[17], data[9], data[6], data[27], data[14], data[1], data[22],
                 data[30], data[24], data[8], data[18], data[0], data[5], data[29], data[23],
                 data[13], data[19], data[2], data[26], data[10], data[21], data[28], data[7]}