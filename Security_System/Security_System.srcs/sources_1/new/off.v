`timescale 1ns / 1ps

module off(
    input wire clk,
    input wire [3:0] ENABLE,
    output reg [3:0] bcd,
    output reg [3:0] enable
);

reg [3:0] count;  

always @(posedge clk)
begin
if (count == 1'h2)
begin
    count <= 4'h0;
    enable <= 4'b1011;
    bcd <= 4'h0;
end
else if (count == 1'h1)
begin
    count <= 4'h2;
    enable <= 4'b1101;
    bcd <= 4'h0;
end
else
begin
    count <= 4'h1;
    enable <= 4'b1110;
    bcd <= 4'h1;
end
end

endmodule
