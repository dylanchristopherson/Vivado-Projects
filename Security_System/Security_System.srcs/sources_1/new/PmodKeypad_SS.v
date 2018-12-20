`timescale 1ns / 1ps

module PmodKeypad_SS(
    input clk,
    input reset,
    inout wire [7:0] JA,
    output wire [4:1] ENABLE,   // ENABLE 
    output wire [6:0] SEGMENT,
    output wire off_or_on,
    output pointer,
    output LED,
    inout break
    
    );
            
// Takes in keypad input and decides if the correct passcode was recieved. Then turns the machine either on or off
Decoder_OSU_V2 V1 (.clk(clk), .reset(reset), .Row(JA[7:4]), .Col(JA[3:0]), .off_or_on(off_or_on));

// Sets display values for the FPGA. An inner module is used to debounce break beam signal
SegDisplay_SS V2 (.clk(clk), .ENABLE(ENABLE), .SEGMENT(SEGMENT),  .reset(reset), .off_or_on(off_or_on), .LED(LED), .break(break));
     
assign pointer = clk;
 
endmodule

