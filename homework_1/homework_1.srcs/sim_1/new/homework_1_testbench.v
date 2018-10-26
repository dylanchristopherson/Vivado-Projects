`timescale 1ns / 1ps

module homework_1_testbench;

    //Inputs
    reg a;
    reg b;
    reg c;
    reg d;
    
    //Outputs
    wire y;

    //Instantiate the Device Under Test (DUT)

    homework_1 uut(
        .y(y),
        .a(a),
        .b(b),
        .c(c),
        .d(d)  
    );
    
    initial begin
    #5 {a, b, c, d} = 4'b0000;
    #5 {a, b, c, d} = 4'b0001;
    #5 {a, b, c, d} = 4'b0010;
    #5 {a, b, c, d} = 4'b0011;
    #5 {a, b, c, d} = 4'b0100;
    #5 {a, b, c, d} = 4'b0101;
    #5 {a, b, c, d} = 4'b0110;
    #5 {a, b, c, d} = 4'b0111;
    #5 {a, b, c, d} = 4'b1000;
    #5 {a, b, c, d} = 4'b1001;  //Time delays?
    #5 {a, b, c, d} = 4'b1010;
    #5 {a, b, c, d} = 4'b1011;
    #5 {a, b, c, d} = 4'b1100;
    #5 {a, b, c, d} = 4'b1101;
    #5 {a, b, c, d} = 4'b1110;
    #5 {a, b, c, d} = 4'b1111;    
    end
    
    initial begin #500 $finish; end
    //initial begin $monitor ($time,,"%h %b", {A, B, C, D}, Y); end
    //I added stimulus
    always @(a or b or c or d or y)     //If any of these variable changes, the loop runs
    #1 $display("A=%b, B=%b, C=%b, D=%b, Y=%b", a, b, c, d, y);     //Why does this all need to be b?

endmodule
