`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2018 02:36:57 PM
// Design Name: 
// Module Name: clkdiv
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

//100MHz clock source

module clkdiv(
    input wire clk,
    input wire clr,
    output wire clk3
    );
    
reg [25:0] q;

//25 bit counter
always @(posedge clk or posedge clr)
  begin
    if(clr == 1)
      q <= 0;
      else
      q <= q + 1'b1;
    end

assign clk3 = q[25]; //3Hz clock output to the traffic lights

endmodule
