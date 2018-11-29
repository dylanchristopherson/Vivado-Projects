`timescale 1ns / 1ps

module PmodKeypad_SS(
    input clk,
    input reset,
    inout wire [7:0] JA,
    output wire [4:1] ENABLE,
    output wire [6:0] SEGMENT,
    output off_or_on,
    output pointer,
    output LED,
    output wire [7:0] LEDS,  //For debugging purposes. Want to see what we're getting out
    output wire LEDM
   // input switch,
   // output reg trigger       
    );

wire [15:0] passcode;
wire [3:0] decode;
wire count_clk;
reg [24:1] divider;

//Remove the output wire LED on both the PmodKeypad and the SegDisplay to get it 
// back to normal
always @(posedge clk)
    begin
        if (reset) begin
            divider <= 24'h000000;
        end
        else
            divider <= divider + 1;
        end
assign count_clk = divider[15];
           
//Rows are inputs and columns are outputs
Decoder_OSU_SS U1 (.clk(count_clk), .reset(reset), .Row(JA[7:4]), .Col(JA[3:0]), .DecodeOut(decode), .passcode(passcode), .LEDM(LEDM));
SegDisplay_SS U2 (.DispVal(decode), .ENABLE(ENABLE), .SEGMENT(SEGMENT), .passcode(passcode), .count_clk(count_clk), .off_or_on(off_or_on), .LED(LED), .LEDS(LEDS));    
     
assign pointer = clk;
 
endmodule

