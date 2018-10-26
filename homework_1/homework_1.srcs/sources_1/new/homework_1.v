`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2018 01:51:09 PM
// Design Name: 
// Module Name: homework_1
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


module homework_1(
    input a,
    input b,
    input c,
    input d,
    output y
    );
    
wire w1, w2, w3, w4, w5;    

or (w1, a, d);
not (w2, w1);

//Can you do a 3 input and gate?
not (w3, d);
and (w4, b, c);
and (w5, w4, w3);

and (y, w5, w2); 
    
endmodule
