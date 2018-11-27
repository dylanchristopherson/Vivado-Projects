`timescale 1ns / 1ps

// Generates LED outputs

module LED_Outputs(
    input CLK,
    input [11:0] digital,
    output reg [11:0] led,
    input SWITCH
    );
    
always @(posedge CLK)
begin
    if(digital<12'd2)
            led <= 8'b00000000;
        else if (digital <12'd900)
            led <= 8'b00000001;
        else if (digital <12'd950)
                led <= 8'b00000011;
        else if (digital <12'd1000)
                led <= 8'b00000111;
        else if (digital <12'd1050)
                led <= 8'b00001111;
        else if (digital <12'd1100)
                led <= 8'b00011111;
        else if (digital <12'd1150)
                led <= 8'b00111111;
        else if (digital <12'd1200)
                led <= 8'b01111111;
        else if (digital <12'd1250)
                led <= 8'b11111111;

else begin							// when switch is low, the PmodMIC is in use
	if(digital<12'd2)					// lowest level (no LEDs on)
			led <= 8'b00000000;
		else if(digital<12'd100)	// first level
			led <= 8'b00000001;
		else if(digital<12'd400)
			led <= 8'b00000011;
		else if(digital<12'd700)
			led <= 8'b00000111;
		else if(digital<12'd1000)
			led <= 8'b00001111;
		else if(digital<12'd1300)
			led <= 8'b00011111;
		else if(digital<12'd1600)
			led <= 8'b00111111;
		else if(digital<12'd1900)
			led <= 8'b01111111;
		else if(digital>12'd1900)	// highest level (all LEDs on)
			led <= 8'b11111111;
	
	end
end
    
endmodule
