`timescale 1ns / 1ps

module PmodKeypad(
    input clk,
    input reset,
    inout wire [7:0] JA,
    output wire [3:0] an,
    output wire [6:0] seg
    );

wire [3:0] decode;

//Rows are inputs and columns are outputs
Decoder_OSU U1 (.clk(clk), .reset(reset), .Row(JA[7:4]), .Col(JA[3:0]), .DecodeOut(decode));
SegDisplay U2 (.DispVal(decode), .anode(an), .segOut(seg));    
    
endmodule
