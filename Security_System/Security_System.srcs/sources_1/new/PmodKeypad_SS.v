`timescale 1ns / 1ps

module PmodKeypad_SS(
    input clk,
    input reset,
    inout wire [7:0] JA,
    output wire [4:1] ENABLE,
    output wire [6:0] SEGMENT,
    output wire off_or_on,
    output pointer,
    output LED,
    output wire [7:0] LEDS,  //For debugging purposes. Want to see what we're getting out
    output wire LEDM,
    inout breakkk
   // input switch,
   // output reg trigger       
    );

//wire [15:0] passcode;
wire [3:0] decode;
wire count_clk;
reg [24:1] divider;

always @(posedge clk)
    begin
        if (reset) begin
            divider <= 24'h000000;
        end
        else
            divider <= divider + 1;
        end
assign count_clk = divider[10];
           
//Rows are inputs and columns are outputs

//Decoder_OSU_SS U0 (.clk(clk), .reset(reset), .Row(JA[7:4]), .Col(JA[3:0]), .DecodeOut(decode), .passcode(passcode), .LEDM(LEDM), .off_or_on(off_or_on));
Decoder_OSU_V2 V1 (.clk(clk), .reset(reset), .Row(JA[7:4]), .Col(JA[3:0]), .off_or_on(off_or_on));

//SegDisplay_SS U2 (.DispVal(decode), .ENABLE(ENABLE), .SEGMENT(SEGMENT), .passcode(passcode), .count_clk(count_clk), .off_or_on(off_or_on), .LED(LED), .LEDS(LEDS));    
SegDisplay_SS V2 (.clk(clk), .DispVal(decode), .ENABLE(ENABLE), .SEGMENT(SEGMENT), .count_clk(count_clk), .reset(reset), .off_or_on(off_or_on), .LED(LED), .breakkk(breakkk));//, .LEDS(LEDS));
     
assign pointer = clk;
 
endmodule

