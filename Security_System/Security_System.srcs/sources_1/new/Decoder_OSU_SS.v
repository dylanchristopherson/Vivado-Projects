`timescale 1ns / 1ps


module Decoder_OSU_SS(
    input clk,
    input reset,
    input [3:0] Row,
    output reg [3:0] Col,
    output reg [3:0] DecodeOut,  
    output reg [15:0] passcode,
    output reg LEDM,
    output reg off_or_on
    
    );
    
    initial LEDM = 1'b0;
    initial passcode = 16'b0000000000000000;
    reg [5:0] pass =  16'b0001000100010001;
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
            //LEDM <= 1'b1;
            DecodeOut <= 4'b0001;  //1
            passcode <= {passcode[11:0], 4'b0001};
          end 
          else if (Row == 4'b1011)
          begin 
            DecodeOut <= 4'b0100;  //4
            passcode <= {passcode[11:0], 4'b0100};
          end
          else if (Row == 4'b1101)
          begin 
            DecodeOut <= 4'b0111;  //7
            passcode <= {passcode[11:0], 4'b0111};
          end
          else if (Row <= 4'b1110)
          begin
            DecodeOut <= 4'b0000;   //0
            passcode <= {passcode[11:0], 4'b0000};
          end
            
          end
//////////////////////////////////////////////////////////////         
      else if(divider == 20'b00110000110101000000)
        //Scanning Column 2
      Col <= 4'b1011;       
      else if (divider == 20'b00110000110101001000)
        begin
        
        if (Row == 4'b0111)
        begin
          DecodeOut <= 4'b0010; //2
          passcode <= {passcode[11:0], 4'b0010};
        end
        else if (Row == 4'b1011)
        begin
          DecodeOut <= 4'b0101; //5
          passcode <= {passcode[11:0], 4'b1011};
        end
        else if (Row == 4'b1101)
        begin
          DecodeOut <= 4'b1000;  //8
          passcode <= {passcode[11:0], 4'b1000};
        end
        else if(Row == 4'b1110)
        begin
          DecodeOut <= 4'b1111;  //F
          passcode <= {passcode[11:0], 4'b1111};
        end
        end
///////////////////////////////////////////////////////////////
      else if (divider == 20'b01001001001111100000)
        //Scanning Column 3
      Col <= 4'b1101;       
      else if (divider == 20'b01001001001111101000)
        begin
        
        if (Row == 4'b0111)
        begin  
          DecodeOut <= 4'b0011; //3
          passcode <= {passcode[11:0], 4'b0011};
        end 
        else if (Row == 4'b1011)
        begin
          DecodeOut <= 4'b0110; //6
          passcode <= {passcode[11:0], 4'b0110};
        end
        else if (Row == 4'b1101)
        begin  
          DecodeOut <= 4'b1001; //9
          passcode <= {passcode[11:0], 4'b1001};
        end
        else if (Row == 4'b1110)
        begin
          DecodeOut <= 4'b1110;  //E
          passcode <= {passcode[11:0], 4'b1110};
        end
        end
////////////////////////////////////////////////////////////////      
      else if (divider == 20'b01100001101010000000)
        //Scanning Column 4
      Col <= 4'b1110;       
      else if (divider == 20'b01100001101010001000)
        begin
        
        if (Row == 4'b0111)
        begin
          DecodeOut <= 4'b1010;  //A
          passcode <= {passcode[11:0], 4'b1000};
        end
        else if (Row == 4'b1011)
        begin
          DecodeOut <= 4'b1011;  //B
          passcode <= {passcode[11:0], 4'b1011};
        end
        else if (Row == 4'b1101)
        begin
          DecodeOut <= 4'b1100;  //C
          passcode <= {passcode[11:0], 4'b1100};
        end
        else if (Row == 4'b1110)
        begin
          DecodeOut <= 4'b1101;   //D 
          passcode <= {passcode[11:0], 4'b1101};
        end
      end
      
    end
////////////////////////////////////////////////////////    
    always @(DecodeOut)
    begin
        //LEDM <= 1'b1;
//        passcode[15:12] <= passcode[11:8];
//        passcode[11:8] <= passcode[7:4];
//        passcode[7:4] <= passcode[3:0];
//        passcode[3:0] <= DecodeOut[3:0];
        
//        //ENABLE <= {ENABLE[3:1], ENABLE[4]};
//        passcode <= {passcode[11:8], passcode[7:4], passcode[3:0], DecodeOut[3:0]};
//        passcode <= {passcode, 4'b0000};
                
        if(passcode == pass)
        begin
            if (off_or_on == 1'b0)
                off_or_on <= 1'b1;
            else
                off_or_on <= 1'b0;
        end
        
    end
    
endmodule
