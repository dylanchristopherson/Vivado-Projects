`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2018 03:24:13 PM
// Design Name: 
// Module Name: UpCounter99
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


module UpCounter99(
    input clk,
    input reset,
    input BUTTON,
    output reg [4:1] ENABLE,
    output reg [7:0] SEGMENT
    );
    
    reg [12:1] DIVIDER;
    reg [7:0] BCD;
    reg [3:0] DECODE_BCD;
    reg [3:0] DEBOUNCE_count;
    
    wire SCAN_clk;
    wire BUTTON_clk;
    
    //Time generator
    always @(negedge clk or posedge reset)
      begin
        if(reset)
          DIVIDER <= 12'h000;
            else
            DIVIDER <= DIVIDER + 1;
      end
    assign SCAN_clk = DIVIDER[12];
    
    //A push button control for the counter
    always @(posedge SCAN_clk or posedge reset)
      begin
        if(reset)
          DEBOUNCE_count <= 4'h0;
            else
              
              if(BUTTON)
                DEBOUNCE_count <= DEBOUNCE_count + 1; 
      end
      
    assign BUTTON_clk = DEBOUNCE_count;
    
    // 00 to 99 up counter
    always @(negedge BUTTON_clk or posedge reset)
      
      begin
        if(reset)
          BCD <= 8'h00;
        else
        begin
        //BCD <= 8'h00
        if(BCD[3:0] == 4'h9)
          begin
            BCD[3:0] <= 4'h0;
            BCD[7:4] <= BCD[7:4] + 1;
          end
        else
          BCD[3:0] <= BCD[3:0] + 1;
          if(BCD == 8'h99)
            BCD <= 8'h00;
          end
        end
    
    
    //ENABLE LED Display
    always @(negedge SCAN_clk or posedge reset)
    begin
      if(reset)
        ENABLE <= 4'b1110;
      else
        ENABLE <= {4'b11,ENABLE[1],ENABLE[2]};
    end
    
    //Data display multiplexer
    
    always @(ENABLE or BCD)
      begin
        case (ENABLE)
          4'b1110 : DECODE_BCD <= BCD[3:0];
          default : DECODE_BCD <= BCD[7:4];
          endcase
      end
      
    // BCD to Seven Segment Decoder
    always @(DECODE_BCD)
    begin
      case(DECODE_BCD)
        4'h0 : SEGMENT = {1'b1,7'b1000000}; //0
        4'h1 : SEGMENT = {1'b1,7'b1111001}; //1
        4'h2 : SEGMENT = {1'b1,7'b0100100}; //2
        4'h3 : SEGMENT = {1'b1,7'b0110000}; //3
        4'h4 : SEGMENT = {1'b1,7'b0011001}; //4
        4'h5 : SEGMENT = {1'b1,7'b0010010}; //5
        4'h6 : SEGMENT = {1'b1,7'b0000010}; //6
        4'h7 : SEGMENT = {1'b1,7'b1111000}; //7
        4'h8 : SEGMENT = {1'b1,7'b0000000}; //8
        4'h9 : SEGMENT = {1'b1,7'b0010000}; //9
        default : SEGMENT = {1'b1,7'b1111111}; //0 
      endcase
    end
    
    //assign pointer = clk;
endmodule
