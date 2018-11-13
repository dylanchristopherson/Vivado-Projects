`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

module clockdiv(
    input wire clk,
    input wire clr,
    output wire dclk,
    output wire segclk
    );
    
    // 17-bit counter variable
    reg [17:0] q;
    
    // Clock divider --
    // Each bit in q is a clock signal that is
    // only a fraction of the master clock.
    always @(posedge clk)
    begin
        q <= q + 1'b1;
    end
    
    // 50Mhz / 2^17 = 381Hz
    assign segclk = q[17];
    // 50Mhz / 2^1 = 25Mhz
    assign dclk = q[1];
    
endmodule