`timescale 1ns / 1ps

module LED_Knight_Rider (
    input clk,
    input reset,
    output reg[7:0] LED
    );
    
reg [29:1] DIVIDER;
reg DIRECTION;
wire SHIFT_clk;
wire FAST_clk;
wire SLOW_clk;
wire speed;

//Clock Generator
always @(posedge clk or posedge reset)
  begin
    if(reset)
      DIVIDER <= {28'h0000000,1'b0};
    else
      DIVIDER <= DIVIDER + 1;
    end
        
assign FAST_clk = DIVIDER[20];
assign SLOW_clk = DIVIDER[21];
assign speed = DIVIDER[29];

assign SHIFT_clk = speed ? FAST_clk : SLOW_clk;

//8-bit knight rider light control
always @(posedge SHIFT_clk or posedge reset)
begin
    if(reset)
        begin
        DIRECTION <= 1'b0;
        LED <= 8'b11000000;
        end
      else
       begin
            if(LED == 8'b00000110)    //"0000_0110b"
                DIRECTION <= 1'b1;
            else if(LED == 8'b01100000)  //"0110_0000b"
                DIRECTION <= 1'b0;
            if(DIRECTION == 1'b0 )     
                LED <= LED >> 1;
            else 
                LED <= LED << 1;
             
        end
    end
endmodule