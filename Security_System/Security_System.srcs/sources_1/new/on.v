`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2018 05:11:48 PM
// Design Name: 
// Module Name: on
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


module on(
    input wire clk,
    input wire [3:0] ENABLE,
    output reg [3:0] bcd,
    output reg [3:0] enable
    );
  
reg [3:0] count;
//reg [3:0] bcd;  
    
always @(posedge clk)
begin
    if (count == 1'h1)
    begin
        count <= 4'h0;
        enable <= 4'b1101;
        bcd <= 4'h0;
    end
    else
    begin
        count <= 4'h1;
        enable <= 4'b1110;
        bcd <= 4'h9;
    end
end
    

endmodule
