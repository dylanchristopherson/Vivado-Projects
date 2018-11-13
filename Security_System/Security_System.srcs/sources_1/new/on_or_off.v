`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2018 04:11:02 PM
// Design Name: 
// Module Name: on_or_off
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


module on_or_off(
    input clk,
    input switch,
    inout test,
    output reg led
    );
    

always @(posedge clk)
begin
    if(switch == 1'b0)   
        led <= 1'b0;
    else
        led <= 1'b1;
end
       

endmodule
