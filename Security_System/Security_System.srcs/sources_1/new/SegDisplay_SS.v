`timescale 1ns / 1ps

module SegDisplay_SS(
    input clk,
    output reg [4:1] ENABLE,
    output reg [6:0] SEGMENT,
    input off_or_on,
    output reg LED,
    input break,
    input reset
    );
    
    reg [2:0] state = 3'b000;
    reg [15:0] bcd;
    reg [3:0] DECODE_BCD;
    reg [15:0] break_attempts;  //Keeps track of the number of attempts to break in
    reg [15:0] b_a;    
    reg carry;    
    reg [3:0] break_bounces;
    
    initial ENABLE <= 4'b1110;
    initial LED <= 1'b0;
    initial break_attempts = 16'b0000000000000000;  
    initial b_a = 4'b0000;
    initial carry = 1'b0; 
     
    reg broken;    // wire fu is the input from the break beams
              
    always @(negedge clk) //or posedge reset)
    begin
        if(!break)
            break_bounces <=4'b0;
        else
        
         if(break_bounces < 4'hE)
             break_bounces <= break_bounces + 4'h1;
         
         broken <= (break_bounces < 4'hE)? 1'b0: 1'b1;   
    end
    
   always @(posedge broken or posedge reset)  
   begin
       if (reset) begin
           b_a <= 4'b000;
       end
     
       else
       begin       
           if (b_a[3:0] == 4'h9)
           begin
               b_a[3:0] <= 4'h0;
               b_a[7:4] <= b_a[7:4] + 1;
           end
           else
               b_a[3:0] <= b_a[3:0] + 1;
               if(b_a == 8'h99)
                   b_a <= 8'h00;              
       end
   end    
     
    wire count_clk;
    reg [24:1] divider;
    
    // Clock divider
    always @(posedge clk)
        begin
            if (reset) begin
                divider <= 24'h000000;
            end
            else
                divider <= divider + 1;
            end
    assign count_clk = divider[10];
    
    // Gives SSD correct values
    always @(posedge count_clk)
    begin
    
        ENABLE <= {ENABLE[3:1], ENABLE[4]};     //Swaps the first bit with the last three bits
        case(state)
        
            // Security System Off
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
            
            // Security System On
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
                    if (!break)
                    begin
                        state <= 3'b010;
                    end                                              
            end
            
            // Break beam broken
            3'b010:
            begin 
                bcd[3:0] <= b_a[3:0];
                bcd[7:4] <= b_a[7:4];
                bcd[11:8] <= b_a[11:8];
                bcd[15:12] <= b_a[15:12];
                                   
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

  endcase
end

endmodule
  
   
   
   
//    4'b1010   : segOut = 7'b1000000;   //0    1010: 10
//    4'b1011   : segOut = 7'b1001000;   //n    1011: 11
//    4'b1100   : segOut = 7'b0001110;   //f    1100: 12
//    4'b1101   : segOut = 7'b0111111;   //-    1101: 13

//    4'b1110   : segOut = 7'b0000110;   //E
//    4'b1111   : segOut = 7'b0001110;   //F
//    default   : segOut = 7'b1010101;   //0 