`timescale 1ns / 1ps

module PmodKeypad(
    input clk,
    input reset,
    inout wire [7:0] JA,
    output wire [3:0] an,
    output wire [6:0] seg,
    output reg LED
    );

wire [3:0] decode;

//Remove the output wire LED on both the PmodKeypad and the SegDisplay to get it 
// back to normal


//Rows are inputs and columns are outputs
Decoder_OSU U1 (.clk(clk), .reset(reset), .Row(JA[7:4]), .Col(JA[3:0]), .DecodeOut(decode));
SegDisplay U2 (.DispVal(decode), .anode(an), .segOut(seg));    
    
always @(posedge clk)
begin
if (seg == 7'b0010000)
    LED <= 1'b1;
else
    LED <= 1'b0;
end
 
endmodule
