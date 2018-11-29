`timescale 1ns / 1ps

module SegDisplay_SS(
    input count_clk,
    input [3:0] DispVal,
    output reg [4:1] ENABLE,
    output reg [6:0] SEGMENT,
    output [15:0] passcode,
    output reg off_or_on,
    output reg LED,
    output reg [8:0] LEDS
    );
    
    initial ENABLE <= 4'b1110;
    initial off_or_on <= 1'b0;
    initial LED <= 1'b0;
    
    reg [15:0] bcd;
    reg [3:0] DECODE_BCD;
    
    //The passcode sets whether everything is off or on
    always @(passcode)
    begin
        LED <= 1'b1;
//        LEDS[8] <= passcode[7];
        LEDS[7] <= passcode[8];
        LEDS[6] <= passcode[9];
        LEDS[5] <= passcode[10];
        LEDS[4] <= passcode[11];
        LEDS[3] <= passcode[12];
        LEDS[2] <= passcode[13];
        LEDS[1] <= passcode[14];
        LEDS[0] <= passcode[15];

        
//        if (passcode == 16'b00010001000100010001 )      //1111
        if (passcode[15:12] == 4'b0001)                //If there is a one, this one thing should turn on. Perhaps my check is n't working right. 
            off_or_on <= 1'b1;    
    end
    
    
    //Sets ENABLE
    always @(posedge count_clk)
    begin
     
        ENABLE <= {ENABLE[3:1], ENABLE[4]};
               
        if (off_or_on == 1'b1) begin
            //bcd <= 16'b0011001100000001;
            //--on
            bcd[3:0] <= 4'h1;
            bcd[7:4] <= 4'h0;
            bcd[11:8] <= 4'h3;
            bcd[15:12] <= 4'h3;
        end
        else begin
            //bcd <= 16'b001100000100010;
            //-off
            bcd[3:0] <= 4'h2;
            bcd[7:4] <= 4'h2;
            bcd[11:8] <= 4'h0;
            bcd[15:12] <= 4'h3;
        end
    end


//Based on enable, chooses correct value from bcd
always @(ENABLE or bcd)
begin
    case (ENABLE)
        4'b1110 : DECODE_BCD = bcd[3:0];
        4'b1101 : DECODE_BCD = bcd[7:4];
        4'b1011 : DECODE_BCD = bcd[11:8];
        4'b0111 : DECODE_BCD = bcd[15:12];
        //default : DECOD
    endcase
end
    
//Evaluates decode_bcd and assigns ssd values
always @(DECODE_BCD)
begin
  case(DECODE_BCD)
    4'h0    :  SEGMENT = 7'b1000000; //0
    4'h1    :  SEGMENT = 7'b1001000; //n
    4'h2    :  SEGMENT = 7'b0001110; //f
    4'h3    :  SEGMENT = 7'b0111111; //-
    default :  SEGMENT = 7'b0111111; //-

  endcase
end

endmodule
  
//    //Convert Key Code Into ASCII
//        always @(DispVal)
//    begin
//    case (DispVal)
    
//        4'b0000   : segOut = 7'b1000000;   //0
//        4'b0001   : segOut = 7'b1111001;   //1
//        4'b0010   : segOut = 7'b0100100;   //2
//        4'b0011   : segOut = 7'b0110000;   //3
//        4'b0100   : segOut = 7'b0011001;   //4
//        4'b0101   : segOut = 7'b0010010;   //5
//        4'b0110   : segOut = 7'b0000010;   //6
//        4'b0111   : segOut = 7'b1111000;   //7
//        4'b1000   : segOut = 7'b0000000;   //8
//        4'b1001   : segOut = 7'b0010000;   //9
//        4'b1010   : segOut = 7'b0001000;   //A
//        4'b1011   : segOut = 7'b0000000;   //B
//        4'b1100   : segOut = 7'b1000110;   //C
//        4'b1101   : segOut = 7'b1000000;   //D
//        4'b1110   : segOut = 7'b0000110;   //E
//        4'b1111   : segOut = 7'b0001110;   //F
//        default   : segOut = 7'b1010101;   //0
//    endcase
//    end  
 
      
    


//   always @(DispVal)
//    begin
//    case (DispVal)
    
//        4'b0000   : segOut = 7'b1000000;   //0      Off
//        4'b1001   : segOut = 7'b0010000;   //9      On
//        default   : segOut = 7'b0010000;   //Default is On
//    endcase
//    end  