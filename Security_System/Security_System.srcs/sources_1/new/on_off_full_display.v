`timescale 1ns / 1ps

module on_off_full_display(
    input clk,
    input switch,
    input reset,
    output wire pointer,
    output reg [4:1] ENABLE,
    output reg [6:0] SEGMENT,
    output reg LED
    );

//Double BCD so that I can hold info for 
// both on and off?
// reg [31:0] bcd

//Binary converted Decimal

//Plug in the values you want into bcd
// then, using enable, you'll be able to tell
// where those come from. And plug them into 
// the proper area...
initial ENABLE <= 4'b1110;

reg [15:0] bcd;
reg [3:0] DECODE_BCD;
reg [24:1] divider;
wire count_clk;

always @(posedge clk)
    begin
        if (reset) begin
            divider <= 24'h000000;
        end
        else
            divider <= divider + 1;
        end
assign count_clk = divider[15];
           
//Sets LED 
always @(posedge count_clk) begin
    if (switch ==1'b1) begin
        LED <= 1'b1;
    end
    else begin
        LED <= 1'b0;
    end
end

//Sets ENABLE
always @(posedge count_clk)
begin
 
    if (reset) begin
        ENABLE <= 4'b1110;
    end
    else begin
        ENABLE <= {ENABLE[3:1], ENABLE[4]};
    end
    
    if (switch == 1'b1) begin
        //bcd <= 16'b0011001100000001;
        //--on
        bcd[3:0] <= 4'h1;
        bcd[7:4] <= 4'h0;
        bcd[11:8] <= 4'h3;
        bcd[15:12] <= 4'h3;
    end
    else begin
        //bcd <= 16'b0011000000000010;
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
    
//    4'h4    :  SEGMENT = 7'b0011001; //4
//    4'h5    :  SEGMENT = 7'b0010010; //5
//    4'h6    :  SEGMENT = 7'b0000010; //6
//    4'h7    :  SEGMENT = 7'b1111000; 
//    4'h8    :  SEGMENT = 7'b0000000; 
//    4'h9    :  SEGMENT = 7'b0001110; //F

  endcase
end

//Chooses which SSD to turn on
//assign ENABLE = 4'b0000;

//Because the clk frequency is so quick, the FPGA is turning the point on the board on and off quickly
// and to us it looks always off because it turns the LED on and off so quickly.
assign pointer = clk;

endmodule
