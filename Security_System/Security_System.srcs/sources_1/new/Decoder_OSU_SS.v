`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2018 03:02:21 PM
// Design Name: 
// Module Name: Decoder_OSU
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


module Decoder_OSU_SS(
    input clk,
    input reset,
    input [3:0] Row,
    output reg [3:0] Col,
    output reg [3:0] DecodeOut,  
    output reg [15:0] passcode,
    output reg LEDM
    );
    
    initial LEDM = 1'b0;
//    passcode_shift v1(.passcode(passcode), .DecodeOut(DecodeOut));
    
    reg [19:0] divider;        
       
       
    
    always @(posedge clk or posedge reset)
      begin
        if (reset)
        divider <= 20'b00000000000000000000;
        else
        divider <= divider + 1;
      end
    
    always @(posedge clk)
      begin
      
      // 1ms delay for switch debounces
      //
//////////////////////////////////////////////////////////////////  
      if (divider == 20'b00011000011010100000)
        
        //Scanning Column 1
        Col <= 4'b0111;       
        else if (divider == 20'b00011000011010101000)
          begin
          
          if (Row == 4'b0111)
          begin
            LEDM <= 1'b1;
            DecodeOut <= 4'b0001;  //1
          end 
          else if (Row == 4'b1011) 
            DecodeOut <= 4'b0100;  //4
          else if (Row == 4'b1101) 
            DecodeOut <= 4'b0111;  //7
          else if (Row <= 4'b1110)
            DecodeOut <= 4'b0000;   //0
            
          end
//////////////////////////////////////////////////////////////         
      else if(divider == 20'b00110000110101000000)
        //Scanning Column 2
      Col <= 4'b1011;       
      else if (divider == 20'b00110000110101001000)
        begin
        
        if (Row == 4'b0111)
          DecodeOut <= 4'b0010; //2
         
        else if (Row == 4'b1011)
          DecodeOut <= 4'b0101; //5
        else if (Row == 4'b1101)
          DecodeOut <= 4'b1000;  //8
        else if(Row == 4'b1110)
          DecodeOut <= 4'b1111;  //F
        end
///////////////////////////////////////////////////////////////
      else if (divider == 20'b01001001001111100000)
        //Scanning Column 3
      Col <= 4'b1101;       
      else if (divider == 20'b01001001001111101000)
        begin
        
        if (Row == 4'b0111)
          DecodeOut <= 4'b0011; //3
         
        else if (Row == 4'b1011)
          DecodeOut <= 4'b0110; //6
        else if (Row == 4'b1101)
          DecodeOut <= 4'b1001; //9
        else if (Row == 4'b1110)
          DecodeOut <= 4'b1110;  //E
        end
////////////////////////////////////////////////////////////////      
      else if (divider == 20'b01100001101010000000)
        //Scanning Column 4
      Col <= 4'b1110;       
      else if (divider == 20'b01100001101010001000)
        begin
        
        if (Row == 4'b0111)
          DecodeOut <= 4'b1010;  //A
         
        else if (Row == 4'b1011)
          DecodeOut <= 4'b1011;  //B
        else if (Row == 4'b1101)
          DecodeOut <= 4'b1100;  //C
        else if (Row == 4'b1110)
          DecodeOut <= 4'b1101;   //D 
      end
      
    end
    
    always @(DecodeOut)
    begin
        //LEDM <= 1'b1;
        passcode[15:12] <= passcode[11:8];
        passcode[11:8] <= passcode[7:4];
        passcode[7:4] <= passcode[3:0];
        passcode[3:0] <= DecodeOut[3:0];
        
        //ENABLE <= {ENABLE[3:1], ENABLE[4]};
        //passcode <= {passcode[11:8], passcode[7:4], passcode[3:0], DecodeOut[3:0]}
        
        if(DecodeOut[3:0] == 4'b0001)
        begin
         //   LEDM <= 1'b1;
        end
    end
    
endmodule
