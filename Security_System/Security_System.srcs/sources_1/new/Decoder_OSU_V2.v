`timescale 1ns / 1ps

module Decoder_OSU_V2(
  input clk,
  input reset,
  input [3:0] Row,
  output reg [3:0] Col,
  
  output reg off_or_on
//  output reg [8:0] LEDS
  
//  output reg [15:0] DecodeOut,
//  output reg [15:0] state_led,
//  output reg [3:0] pass_signal,
//  output reg [2:0]  press_count_out
//  output reg [15:0] display_out
//  input lock_button
); 

// STATE 0: HANDLES INPUT FROM KEYPAD AND ALSO APPENDS NUMBER TO pass_buffer
// STATE 1:
// STATE 2 Checks Password	: Checks password
// STATE 3 Unlocks Motor    : Switches on or off
// STATE 4 Locks Motor
  
  reg [15:0] DecodeOut;
  reg [15:0] state_led;
  reg [3:0] pass_signal;
  reg [2:0] press_count_out;
  reg [19:0] divider;
  reg [15:0] pass = 16'b0001000100010001; //hardcoded password
  
  /*Password buffer*/
  reg [15:0] pass_buffer;
  
  reg [2:0]  press_count;
  reg [2:0]  state = 3'b000;
  reg [3:0]  decode_buffer;
  reg [31:0] delay_clk;
  //reg [2:0]  flash_count;
  
  always @(posedge reset or posedge clk)
    begin
      if(reset)
        begin
          divider <= 20'b00000000000000000000;
        end
      else
        divider <= divider + 1;
  end
  
  always @(posedge clk)
    begin
      case(state)
      
      
      
        //HANDLES INPUT FROM KEYPAD AND ALSO APPENDS NUMBER TO pass_buffer
        3'b000:
          begin
//          LEDS[0] <= 1'b1;
//          LEDS[1] <= 1'b0;
//          LEDS[2] <= 1'b0;
//          LEDS[3] <= 1'b0;
            
            if(divider ==  20'b00011000011010100000) // 11000011010100000 1ms delay =100000
              Col <= 4'b0111;
            else if(divider == 20'b00011000011010101000) // =100008
              if (Row == 4'b0111)
                begin
						  decode_buffer <= 4'b0001; //1	
						  pass_buffer <= {pass_buffer, 4'b0001};
						  state = 3'b001;
                end

            else if(Row == 4'b1011)
                begin
                        decode_buffer = 4'b0100;  //4
                        pass_buffer <= {pass_buffer, 4'b0100};
                        state = 3'b001;
                end  
                
            else if(Row == 4'b1101)
            begin
                          decode_buffer = 4'b0111;//7  
                          pass_buffer <= {pass_buffer, 4'b0111};
                          state = 3'b001;
            end  
            
            else if(Row == 4'b1110) 
            begin
                          decode_buffer = 4'b0000;  //0
                          pass_buffer <= {pass_buffer, 4'b0000};
                          state = 3'b001;
            end

            if(divider ==  20'b00110000110101000000) //=200000
              Col <= 4'b1011;
            else if(divider == 20'b00110000110101001000) //=200008
              begin 
                if (Row == 4'b0111)
                  begin
                              decode_buffer = 4'b0010;  //2
                              pass_buffer <= {pass_buffer, 4'b0010};
                              state = 3'b001;
                            end //2
                else if(Row == 4'b1011)  
                  begin
                              decode_buffer = 4'b0101;  //5
                              pass_buffer <= {pass_buffer, 4'b0101};
                              state = 3'b001;
                            end //5
                else if(Row == 4'b1101)
                  begin
                              decode_buffer = 4'b1000;  //8
                              pass_buffer <= {pass_buffer, 4'b1000};
                              state = 3'b001;
                            end
                else if(Row == 4'b1110)
                  DecodeOut <= 4'b1010; //f
              end

            if(divider ==  20'b01100001101010000000) //#400000
              Col <= 4'b1101;
            else if(divider == 20'b01100001101010001000) //400000
              begin 
                if (Row == 4'b0111)
                  begin
                    decode_buffer = 4'b0011;  //3
                    pass_buffer <= {pass_buffer, 4'b0011};
                    state = 3'b001;
                  end //3
                else if(Row == 4'b1011)  
                  begin
                    decode_buffer = 4'b0110;  //6
                    pass_buffer <= {pass_buffer, 4'b0110};
                    state = 3'b001;
                  end //6
                else if(Row == 4'b1101)
                  begin
                    decode_buffer = 4'b1001;  //9
                    pass_buffer <= {pass_buffer, 4'b1001};
                    state = 3'b001;
                  end  //9
                else if(Row == 4'b1110)
                  DecodeOut <= 4'b1010;
              end

            if(divider ==  20'b11000011010100000000) //#800000
              Col <= 4'b1110;
            else if(divider == 20'b11000011010100001000) //800008
              begin 
                if (Row == 4'b0111)
                  DecodeOut <= 4'b1010; //a
                else if(Row == 4'b1011)  
                  DecodeOut <= 4'b1010; //b
                else if(Row == 4'b1101)
                  DecodeOut <= 4'b1010;  //c
                else if(Row == 4'b1110)      
                  DecodeOut <= 4'b1010;  //d
              end  
			
          
          end
          
       
        3'b001:
          begin
          
//          LEDS[0] <= 1'b0;
//          LEDS[1] <= 1'b1;
//          LEDS[2] <= 1'b0;
//          LEDS[3] <= 1'b0;
          
		      if(delay_clk[31:0] == 32'd30000000)
			  begin
			    state_led <= 16'b0000000000000011;
		//	    display_out <= pass_buffer;
				DecodeOut <= decode_buffer;
				delay_clk <= 32'd0;
				press_count = press_count + 1'b1;
				press_count_out <= press_count;
				if(press_count[2:0] == 3'd4)
          begin
            press_count <= 3'd0;
            state <= 3'b010;
                        
          end
				else
				    state <= 3'b000;
 			  end
			  else
			  delay_clk = delay_clk + 1'b1;
	       end
		
		//STATE 2 Checks Password	  
		3'b010:
            begin
            
//            LEDS[0] <= 1'b0;
//            LEDS[1] <= 1'b0;
//            LEDS[2] <= 1'b1;
//            LEDS[3] <= 1'b0;
                /*if passward entered matches hardcoded password
                    go to the next state
                */
                
                if(pass_buffer == pass)
                begin
                    state <= 3'b011;
                end
                
                /*
                Wrong passcode entered
                goes back to state 0
                */
                else
                    state <= 3'b000;
                    state_led <= 16'b0000000000000000;
            
            end
            
            
//////// Use these states for on_or_off to control seven segment display ////////////            
            
          //STATE 3 Locks or Unlocks Security System
          3'b011: 
          begin
//          LEDS[0] <= 1'b0;
//          LEDS[1] <= 1'b0;
//          LEDS[2] <= 1'b0;
//          LEDS[3] <= 1'b1;
            state_led <= 16'b1111111111111111;
            pass_signal <= 4'b0001;
            
            if (off_or_on == 1'b0)   //Turns on security system
                off_or_on <= 1'b1;         
            else                     //Turns off security system
                off_or_on <= 1'b0;
                
            state <= 3'b000;         //Resets back to the first state
          end
          
//          //STATE 4 Locks Motor
//          3'b100:
//          begin
//            state_led <= 16'b0000000000000011;
//            pass_signal <= 4'b0010;
//            state <= 3'b000;
//          end
            
      endcase
    end
endmodule