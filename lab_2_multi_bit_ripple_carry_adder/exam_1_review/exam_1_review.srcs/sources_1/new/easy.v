`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2018 02:02:04 PM
// Design Name: 
// Module Name: easy
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


module easy(
    output y,
    input a,
    input b,
    input c    
    );
    
    wire w1, w2;
    
    and (w1,a,b);
    and (w2,w1,c);
    or (y,w1,w2);
     
endmodule
