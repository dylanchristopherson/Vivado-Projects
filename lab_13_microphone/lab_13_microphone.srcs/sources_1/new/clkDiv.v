`timescale 1ns / 1ps

// ********************************************************
// This module divides the onboard 100Mhz clock to 12.5 Mhz
// for use with the Pmod devices.
// ********************************************************
module clkDiv(
    input CLK,    // input clock
    input RST,    // reset signal
    output sclk   // 12.5 Mhz divided clock
    );
    
    reg [3:0] div;
    
    always @(posedge CLK or posedge RST)
    begin
        if (RST)
            div <= 1'b0;
        else
            div <= div + 1'b1;
    end
    
    assign sclk = div[3];
    
endmodule
