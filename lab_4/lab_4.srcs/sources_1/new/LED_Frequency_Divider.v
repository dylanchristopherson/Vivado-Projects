`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Frequency Generator:
//On-board oscillator: 100MHz
//T=1/f=1/(100MHz)=1*10^-8
//////////////////////////////////////////////////////////////////////////////////


module LED_Frequency_Divier(
    input clk,
    input reset,
    output [7:0] LED
    );
   
reg [30:1] DIVIDER;

// Frequency Generator

always @(posedge clk or posedge reset)
    begin  
        if(reset)
            DIVIDER <= DIVIDER + 1'b1;
        else
            DIVIDER <= DIVIDER + 1'b1;
        end
        
assign LED[0] = DIVIDER[23],
       LED[1] = DIVIDER[24],
       LED[2] = DIVIDER[25],
       LED[3] = DIVIDER[26],
       LED[4] = DIVIDER[27],
       LED[5] = DIVIDER[28],
       LED[6] = DIVIDER[29],
       LED[7] = DIVIDER[30];       

endmodule