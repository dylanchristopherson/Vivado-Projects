`timescale 1ns / 1ps

module SegDisplay_SS(
    input clk,
    input count_clk,
    input [3:0] DispVal,
    output reg [4:1] ENABLE,
    output reg [6:0] SEGMENT,
    input reset,
   
    input off_or_on,
    output reg LED,
    input breakkk
   // output [15:0] passcode,
  //  output reg [8:0] LEDS
    );
    
    //I need to debounce this stupid button
    
    // Case statement
    // Off
    // On
    // Count break in attempts...
    
    reg [2:0] state = 3'b000;
    initial ENABLE <= 4'b1110;
    initial LED <= 1'b0;
    
    reg [15:0] bcd;
    reg [3:0] DECODE_BCD;
    
    reg [15:0] break_attempts;  //Keeps track of the number of attempts to break in         
    initial break_attempts = 16'b0000000000000000;
    reg [3:0] b_a;
    initial b_a = 4'b0000;
    
    reg db_temp;
    //assign db_temp = db;
    
    wire fu;
       
    db_fsm T1 (.clk(clk), .reset(reset), .sw(breakkk), .db(fu));
        
    always @(posedge fu)
    begin
        
//        if (reset)
//            bcd[3:0] <= 4'h0;
        
        begin
            if (b_a == 4'h9)
                b_a <= 4'b0000;
            else
                b_a <= b_a + 1'b1;
        end    
    end
    
    always @(posedge count_clk)
    begin
    
        ENABLE <= {ENABLE[3:1], ENABLE[4]};
        case(state)
            // Off
            3'b000:
            begin
                bcd[3:0] <= 4'b1100;  //12
                bcd[7:4] <= 4'b1100;  //12
                bcd[11:8] <= 4'b1010; //10
                bcd[15:12] <= 4'b1101;    //13
                
                if (off_or_on == 1'b1)
                begin
                    state <= 3'b001;
                end    
            end
            
            // On
            3'b001:
            begin
                    bcd[3:0] <= 4'b1011;      //11
                    bcd[7:4] <= 4'b1010;      //10
                    bcd[11:8] <= 4'b1101;     //13
                    bcd[15:12] <= 4'b1101;    //13
                    
                    if (off_or_on == 1'b0)
                    begin
                        state <= 3'b000;
                    end 
                    
                    if (breakkk)
                    begin
                        state <= 3'b010;
                    end                                              
            end
            
            // Break in
            3'b010:
            begin 
                //bcd[3:0] <= break_attempts[3:0];
                //bcd[7:4] <= break_attempts[7:4];
                //bcd[11:8] <= break_attempts[11:8];
                //bcd[15:12] <= break_attempts[15:12];
                
                bcd[3:0] <= b_a;
                bcd[7:4] <= 4'b0000;
                bcd[11:8] <= 4'b0000;
                bcd[15:12] <= 4'b0000;
            
                if (off_or_on == 1'b0)
                begin
                    state <= 3'b000;
                end 
            
            end
            
        endcase   
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
    4'b0000   : SEGMENT = 7'b1000000;   //0
    4'b0001   : SEGMENT = 7'b1111001;   //1
    4'b0010   : SEGMENT = 7'b0100100;   //2
    4'b0011   : SEGMENT = 7'b0110000;   //3
    4'b0100   : SEGMENT = 7'b0011001;   //4
    4'b0101   : SEGMENT = 7'b0010010;   //5
    4'b0110   : SEGMENT = 7'b0000010;   //6
    4'b0111   : SEGMENT = 7'b1111000;   //7
    4'b1000   : SEGMENT = 7'b0000000;   //8
    4'b1001   : SEGMENT = 7'b0010000;   //9


    4'b1010    :  SEGMENT = 7'b1000000; //0
    4'b1011    :  SEGMENT = 7'b1001000; //n
    4'b1100    :  SEGMENT = 7'b0001110; //f
    4'b1101    :  SEGMENT = 7'b0111111; //-
    default :  SEGMENT = 7'b0111111; //-


//    4'b1010   : segOut = 7'b1000000;   //0    1010: 10
//    4'b1011   : segOut = 7'b1001000;   //n    1011: 11
//    4'b1100   : segOut = 7'b0001110;   //f    1100: 12
//    4'b1101   : segOut = 7'b0111111;   //-    1101: 13

//    4'b1110   : segOut = 7'b0000110;   //E
//    4'b1111   : segOut = 7'b0001110;   //F
//    default   : segOut = 7'b1010101;   //0

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





///////////// Previous code 

//`timescale 1ns / 1ps

//module SegDisplay_SS(
//    input count_clk,
//    input [3:0] DispVal,
//    output reg [4:1] ENABLE,
//    output reg [6:0] SEGMENT,
//    output [15:0] passcode,
//    output reg off_or_on,
//    output reg LED
//   // output reg [8:0] LEDS
//    );
    
//    initial ENABLE <= 4'b1110;
//    initial off_or_on <= 1'b0;
//    initial LED <= 1'b0;
    
//    reg [15:0] bcd;
//    reg [3:0] DECODE_BCD;
    
//    //The passcode sets whether everything is off or on
//    always @(passcode)
//    begin
//        LED <= 1'b1;
////        LEDS[8] <= passcode[7];
////        LEDS[7] <= passcode[8]; //Why is there no output?
////        LEDS[6] <= passcode[9];
////        LEDS[5] <= passcode[10];
////        LEDS[4] <= passcode[11];
////        LEDS[3] <= passcode[12];
////        LEDS[2] <= passcode[13];
////        LEDS[1] <= passcode[14];
////        LEDS[0] <= passcode[15];

        
////        if (passcode == 16'b00010001000100010001 )      //1111
//        if (passcode[15:12] == 4'b0001)                //If there is a one, this one thing should turn on. Perhaps my check is n't working right. 
//            off_or_on <= 1'b1;    
//    end
    
    
//    //Sets ENABLE
//    always @(posedge count_clk)
//    begin
     
//        ENABLE <= {ENABLE[3:1], ENABLE[4]};
               
//        if (off_or_on == 1'b1) begin
//            //bcd <= 16'b0011001100000001;
//            //--on
//            bcd[3:0] <= 4'h1;
//            bcd[7:4] <= 4'h0;
//            bcd[11:8] <= 4'h3;
//            bcd[15:12] <= 4'h3;
//        end
//        else begin
//            //bcd <= 16'b001100000100010;
//            //-off
//            bcd[3:0] <= 4'h2;
//            bcd[7:4] <= 4'h2;
//            bcd[11:8] <= 4'h0;
//            bcd[15:12] <= 4'h3;
//        end
//    end


////Based on enable, chooses correct value from bcd
//always @(ENABLE or bcd)
//begin
//    case (ENABLE)
//        4'b1110 : DECODE_BCD = bcd[3:0];
//        4'b1101 : DECODE_BCD = bcd[7:4];
//        4'b1011 : DECODE_BCD = bcd[11:8];
//        4'b0111 : DECODE_BCD = bcd[15:12];
//        //default : DECOD
//    endcase
//end
    
////Evaluates decode_bcd and assigns ssd values
//always @(DECODE_BCD)
//begin
//  case(DECODE_BCD)
//    4'h0    :  SEGMENT = 7'b1000000; //0
//    4'h1    :  SEGMENT = 7'b1001000; //n
//    4'h2    :  SEGMENT = 7'b0001110; //f
//    4'h3    :  SEGMENT = 7'b0111111; //-
//    default :  SEGMENT = 7'b0111111; //-

//  endcase
//end

//endmodule











    
    
//    //Sets ENABLE
//    always @(posedge count_clk)
//    begin
     
//        ENABLE <= {ENABLE[3:1], ENABLE[4]};
                              
//        if (off_or_on == 1'b1) begin
//            //bcd <= 16'b0011001100000001;
            
//            //--on
//            if (break_attempts > 16'b0000000000000000)
//                begin
//                    LED <= 1'b0;
//                    bcd[3:0] <= break_attempts[3:0];
//                    bcd[7:4] <= break_attempts[7:4];
//                    bcd[11:8] <= break_attempts[11:8];
//                    bcd[15:12] <= break_attempts[15:12];
//                end
//            else
//                begin
//                    LED <= 1'b1;
//                    bcd[3:0] <= 4'b1011;      //11
//                    bcd[7:4] <= 4'b1010;      //10
//                    bcd[11:8] <= 4'b1101;     //13
//                    bcd[15:12] <= 4'b1101;    //13
//                end                
//        end
//        else begin
//            //bcd <= 16'b001100000100010;
            
//            //-off
//            LED <= 1'b1;
//            bcd[3:0] <= 4'b1100;  //12
//            bcd[7:4] <= 4'b1100;  //12
//            bcd[11:8] <= 4'b1010; //10
//            bcd[15:12] <= 4'b1101;    //13
            
//        end
//    end







    
//    always @(breakkk)
//    begin
//        LED <= 1'b1;
//         //Up counter...
//        if (break_attempts[3:0] == 1'h9)    begin
//            break_attempts[3:0] <= 4'h0;
            
//            if (break_attempts[7:4] == 1'h9)    begin
//                break_attempts[7:4] <= 4'h0;
            
//                if (break_attempts[11:8] == 1'h9)   begin
//                    break_attempts[11:8] <= 4'h0;
                    
//                    if (break_attempts[15:12] == 1'h9)  begin
//                        break_attempts <= 0;
                                 
//                    end else begin
//                        break_attempts[15:12] <= break_attempts[15:12] + 1;
//                    end
//                end else begin
//                    break_attempts[11:8] <= break_attempts[11:8] + 1;
//                end
//            end else begin
//                break_attempts[7:4] <= break_attempts[7:4] + 1;
//            end
//        end else begin
            
//            break_attempts[3:0] <= break_attempts[3:0] + 1;
//        end
        
////        LEDS[0] <= break_attempts[0];
////        LEDS[1] <= break_attempts[1];
////        LEDS[2] <= break_attempts[2];
////        LEDS[3] <= break_attempts[3];
        
//    end
    