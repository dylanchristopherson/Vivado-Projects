`timescale 1ns / 1ps

module on_or_off_display(
    input clk,
    input switch,
    input reset,
    output wire pointer,
    output wire [3:0] ENABLE,
    output reg [6:0] SEGMENT
    );

//Binary coded decimal (BCD) is a system of writing numberals that assigns a four-digit binary code
// to each digit 0 through 9 in a decimal number

// I would like to use the switch to display either OFF or ON, on the 7 segment display so I understand how it works



reg [3:0] BCD;

//Time Generator
always @(posedge clk or posedge reset)
  begin
  if(reset)
      BCD <= 4'h0;
      else
          begin
              if(switch == 1'b0)
                BCD <= 4'h0;
              else
                BCD <= 4'h9;
          end
  end
  
//BCD to seven segment decoder
always @(BCD)
begin
  case(BCD)
    4'h0    :  SEGMENT = 7'b1000000; //0
    4'h1    :  SEGMENT = 7'b1001000; //n
    //4'h2    :  SEGMENT = 7'b0100100; //2
    //4'h3    :  SEGMENT = 7'b0110000; //3
    //4'h4    :  SEGMENT = 7'b0011001; //4
    //4'h5    :  SEGMENT = 7'b0010010; //5
    //4'h6    :  SEGMENT = 7'b0000010; //6
    //4'h7    :  SEGMENT = 7'b1111000; //7
    //4'h8    :  SEGMENT = 7'b0000000; //8
    4'h9    :  SEGMENT = 7'b0001110; //F
    default :  SEGMENT = 7'b1111111; //
  endcase
end

//Chooses which SSD to turn on
assign ENABLE = 4'b0000;

//Because the clk frequency is so quick, the FPGA is turning the point on the board on and off quickly
// and to us it looks always off because it turns the LED on and off so quickly.
assign pointer = clk;

endmodule
