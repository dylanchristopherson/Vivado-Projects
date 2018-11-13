`timescale 1ns / 1ps

module easy_testbench;

    //inputs
    reg a;
    reg b;
    reg c;
    //outputs
    wire y;
    
    easy uut(
      .a(a),
      .b(b),
      .c(c),
      .y(y)
    );
    
    initial
    //unit, precision, "ns" string, string midwidth
    $timeformat(-9,1,"ns",12);
    
    initial begin
    
    // Initalize Inputs
    #0 a = 1'b0; b = 1'b0; c = 1'b0;
    #5 a = 1'b0; b = 1'b0; c = 1'b1;
    #10 a = 1'b0; b = 1'b1; c = 1'b0;
    #15 a = 1'b0; b = 1'b1; c = 1'b1;
    #20 a = 1'b1; b = 1'b0; c = 1'b0;
    #25 a = 1'b1; b = 1'b0; c = 1'b1;
    #30 a = 1'b1; b = 1'b1; c = 1'b0;
    #35 a = 1'b1; b = 1'b1; c = 1'b1;
    
    end
    
    always @(a or b or c or y)
    #1 $display("Time=%t, a=%b, b=%b, c=%b,  y=%b", $time, a, b, c, y);
      
endmodule

//`timescale 1ns / 1ps

//module Comlogic_Testbench;

//	// Inputs
//	reg a;
//	reg b;
//	reg c;
//	//reg d;

//	// Outputs
//	wire y;

//	// Instantiate the Unit Under Test (UUT)
//	easy uut (
//		.a(a), 
//		.b(b), 
//		.c(c), 
//	//	.d(d), 
//		.y(y)
//	);

//	initial
	
//	//unit, precision,string"ns",string minwidth
	
//	$timeformat(-9,1,"ns",12);

//	initial begin
	
//	// Initialize Inputs
		
//	#0  a = 1'b0;
//		 b = 1'b0;
//		 c = 1'b0;
//	//	 d = 1'b0;
		 
//   // apply test vectors	
	
//	#5  a = 1'b0;
//		 b = 1'b0;
//		 c = 1'b0;
//		// d = 1'b1;
		
//	#10 a = 1'b0;
//		 b = 1'b0;
//		 c = 1'b1;
//	//	 d = 1'b0;
		 
//   #15 a = 1'b0;
//	  	 b = 1'b0;
//		 c = 1'b1;
//	//	 d = 1'b1;
		 
//	#20 a = 1'b0;
//	  	 b = 1'b1;
//		 c = 1'b0;
//	//	 d = 1'b0;
		 
//	#25 a = 1'b0;
//	  	 b = 1'b1;
//		 c = 1'b0;
//	//	 d = 1'b1;
		 
//	#30 a = 1'b0;
//	  	 b = 1'b1;
//		 c = 1'b1;
//	//	 d = 1'b0;
		 
//	#35 a = 1'b0;
//	  	 b = 1'b1;
//		 c = 1'b1;
//	//	 d = 1'b1;
		 
//	#40 a = 1'b1;
//	  	 b = 1'b0;
//		 c = 1'b0;
////d = 1'b0;
		 
//	#45 a = 1'b1;
//	  	 b = 1'b0;
//		 c = 1'b0;
////		 d = 1'b1;
		 
//	#50 a = 1'b1;
//	  	 b = 1'b0;
//		 c = 1'b1;
//	//	 d = 1'b0;
		 
//	#55 a = 1'b1;
//	  	 b = 1'b0;
//		 c = 1'b1;
//	//	 d = 1'b1;
		 
//	#60 a = 1'b1;
//	  	 b = 1'b1;
//		 c = 1'b0;
//	//	 d = 1'b0;
		 
//	#65 a = 1'b1;
//	  	 b = 1'b1;
//		 c = 1'b0;
//	//	 d = 1'b1;
		 
//	#70 a = 1'b1;
//	  	 b = 1'b1;
//		 c = 1'b1;
//	//	 d = 1'b0;
		 
//	#75 a = 1'b1;
//	  	 b = 1'b1;
//		 c = 1'b1;
//	//	 d = 1'b1; 
//	end
    
//	always @(a or b or c or y)
//	#1 $display("Time=%t, a=%b, b=%b, c=%b,  y=%b", $time, a, b, c, y);
//endmodule


