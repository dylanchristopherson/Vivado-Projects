`timescale 1ns / 1ps

//`define RED 2'd0    //2'b00
//`define YELLOW 2'd1 //2'b01
//`define GREEN 2'd2  //2'b10

//delays for traffic lights
//`define Y2RDELAY 3
//`define R2GDELAY 2

module Traffic_controller(
    input wire clk,
    input wire clr,
    output reg [5:0] lights
    );
    
    //Internal state variables
    reg [2:0] state;
    reg [3:0] count;
    
    //State variables                 HWY     Cntry
    parameter   S0 = 3'b000,          //Green Red
                S1 = 3'b001,          //Yellow Red
                S2 = 3'b010,          //Red   Red
                S3 = 3'b011,          //Red   Green
                S4 = 3'b100,          //Red   Yellow
                S5 = 3'b101;          //Red   Red

    parameter SEC5 = 4'b1111, SEC1=4'b0011;
        
    //state changes only at positive edge of clock
    always @(posedge clk or posedge clr)
      begin
        if (clr == 1)
        begin
          state <= S0;
          count <= 0;
        end
    else
        case (state)
          S0: if (count < SEC5)
            begin
            state <= S0;
            count <= count + 1'b1;
            end
            else
            state <= S1;  

          S1: if (count < SEC1)
            begin
            state <= S1;
            count <= count + 1'b1;
            end
            else
            state <= S2; 

          S2: if (count < SEC1)
            begin
            state <= S2;
            count <= count + 1'b1;
            end
            else
            state <= S3; 

          S3: if (count < SEC5)
            begin
            state <= S3;
            count <= count + 1'b1;
            end
            else
            state <= S4; 

          S4: if (count < SEC1)
            begin
            state <= S4;
            count <= count + 1'b1;
            end
            else
            state <= S5; 

          S5: if (count < SEC1)
            begin
            state <= S5;
            count <= count + 1'b1;
            end
            else
            state <= S0;
         endcase 
      end                         
      always @(*)
        begin
            case (state)
                S0: lights = 6'b100001;
                S1: lights = 6'b100010;
                S2: lights = 6'b100100;
                S3: lights = 6'b001100;
                S4: lights = 6'b010100;
                S5: lights = 6'b100001;
            //S5: lights = 6 'b100100;
                default: lights = 6'b100001;
            endcase
        end
endmodule
