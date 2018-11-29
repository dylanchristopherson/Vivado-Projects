`timescale 1ns / 1ps


module Pmod_testbench;
    // Inputs
    reg clk;
    reg reset;
    reg [7:0] JA;
    
    // Outputs
    wire [4:1] ENABLE;
    wire [6:0] SEGMENT;
    wire off_or_on;
    wire pointer;
    wire LED;
    wire [15:0] passcode;
    
    
    PmodKeypad_SS uut(
        .clk(.clk),
        .reset(.reset),
        .JA(),
        .SEGMENT
        .off_or_on,
        .pointer,
        .LED
    
    
    );
    
    initial
    
    $timeformat(-9,1,"ns",12);
   
   // Initalize Inputs
   #0
   #1000
   #2000
   #3000
   #4000
   #5000
   
   
   
endmodule
