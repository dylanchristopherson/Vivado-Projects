`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2018 03:28:37 PM
// Design Name: 
// Module Name: Pixels
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Pixels(
    input clr,
    input clk,
    input up,
    input down,
    input left,
    input right,
    output [2:0] red,
    output [2:0] green,
    output [1:0] blue,
    output hsync,
    output vsync

    );
    
    // VGA display clock interconnect
    wire dclk;
    
    //generate 7-seg clock & display clock
    clockdiv U1(
        .clk(clk),
        .clr(clr),
        .segclk(segclk),
        .dclk(dclk)
    );
    
    //VGA controller
    vga640x480 U3(
        .dclk(dclk),
        .clr(clr),
        .up(up),
        .down(down),
        .left(left),
        .right(right),
        .hsync(hsync),
        .vsync(vsync),
        .red(red),
        .green(green),
        .blue(blue)
    );    
    
    
endmodule
