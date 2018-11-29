`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2018 12:57:48 PM
// Design Name: 
// Module Name: passcode_shift
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


module passcode_shift(
    output reg [15:0] passcode,
    input wire [3:0] DecodeOut
    );
    
    wire [3:0] decode_temp;
    
    always @(DecodeOut)
    begin
        passcode[15:12] <= passcode[11:7];
        passcode[11:8] <= passcode[7:4];
        passcode[7:4] <= passcode[3:0];
        passcode[3:0] <= DecodeOut;
    end
    
endmodule
