`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2018 02:12:13 PM
// Design Name: 
// Module Name: audio_volume_meter
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

module audio_volume_meter(
    input clk,
    input reset,
    input switch,
//    input [15:0] sdata,        //Comes in as a 16-bit vector?
    input sdata,
    output [11:0] LED, //Gets serially shifted
    output sclk,  //Clocks the  PmodMIC at 12.5 GHz
    output CS     //Chip select signal
    );
    
    wire done;
    wire [11:0] digital;
    
    //I believe is correct
    clkDiv a1(.CLK(clk), .RST(reset), .sclk(sclk));
    state_machine a2(.clk(sclk), .reset(reset),  .sdata(sdata), .digital(digital), .CS(CS), .done(done), .switch(switch));
    LED_Outputs a3(.CLK(sclk), .SWITCH(switch), .digital(digital), .led(LED));
    
endmodule
