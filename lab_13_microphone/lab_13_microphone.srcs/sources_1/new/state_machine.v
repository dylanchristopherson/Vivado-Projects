`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2018 02:12:45 PM
// Design Name: 
// Module Name: state_machine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module state_machine(
    input clk,
    input reset,
    input sdata,
    output reg [11:0] digital, 
    output reg CS,
    output reg done,
    input switch
    );
    
    reg start;
    reg [15:4] temp;
    reg [2:0] state;
    reg [4:0] cnt;            
  
  parameter idle = 2'b01, 
            shiftin = 2'b10,
            syncdata = 2'b11;
    
      
      always @(posedge clk or  posedge reset )
      begin
          if(reset)
          begin
               start <= 1'b0;
               cnt <= 4'b0000;
               CS <= 1'b1;
               temp <= 12'b000000000000;
               digital <= 12'b000000000000;
               done <= 1'b1;
               state <= idle;   
          end
          
         else
         begin
          case(state)
      idle:
          if(start == 1'b1 && cnt < 16)
              state <= shiftin;
           else
          begin
              done <= 1'b1;
              start <= 1'b1;
              cnt <= 4'b0001;
              CS <= 1'b1;
              temp <= 12'b000000000000;
              digital <= 12'b000000000000;
              state <= shiftin;
          end
          
         shiftin:
          if(start == 1'b1 && cnt == 16)
          state <= syncdata;
          else
          begin
           CS <= 1'b0;
           done <=1'b0;
           if(cnt > 3)
           begin
              if(switch)
              begin
                  temp[19-cnt] <= sdata;
               end
          end
          cnt <= cnt + 1'b1;
          state <= shiftin;
          end
          
       syncdata:
       if(start == 1'b0)
               state <= idle;
               else
               begin
                CS <= 1'b1;
                done <=1'b0;
                digital [11:0] <= temp [15:4];
                start <= 1'b0;
                state <= syncdata;
                end
               
          
   endcase   
      
      end
      
   end
  
    
    
  
    
endmodule


//    reg [2:0] state;
//    reg [5:0] count;        //Sixteen bit counter
//    reg temp;
    
//    parameter S0 = 3'b000,    //Idle
//              S1 = 3'b001,    //ShiftIn
//              S2 = 3'b010;    //SyncData
    
//    initial state = S0;
    
    
///*******************************************/    
    
//    always @(posedge CLK or posedge RST)
//    begin
//        if (RST)
//        begin
//            state <= S0;
//        end
        
//        else
//        begin
//            case(state)
//                //Idle
//                S0: if (SWITCH == 1'b0)
//                begin
//                    CS <= 1;
//                    DONE <= 1;
//                end else   //Switch == 1'b1
//                begin   
//                    state <= S1;
//                end
                
//                //ShiftIn
//                S1: if (count < 3'b100)
//                begin
//                    count <= count + 1'b1;   //Removes the first four bits
//                    temp <= SDATA;
//                end 
//                else if(count <= 4'b1111)
//                begin
//                //    count <= count + 1'b1;
//                    if (SDATA == 1'b0)
//                    begin
//                        dig_out <<< 1;
//                    end
//                    else dig_out << 1;
//                end
//                else
//                begin
//                    dig_out << 1;
//                end
//                                            //Shift data into dig_out
                
//                end else
//                begin
//                    state <= S2;
//                end
                         
                
//                //SyncData
//                S2:
//             endcase    
//        end 
//    end       
            
       




//    always @(posedge CLK or posedge RST)
//    begin
//        if(RST)
//        begin
//            CS <= 1'b1;
//            DONE <= 1'b1;
//            count <= 1'b0000;
//        end
//        else if (count < 1'b1111) 
//        begin
//            //Is this how this works?
            
//            count <= count + 1'b1;
//            CS <= 0;
//            DONE <= 0;
//           // dig_out[11:0] <= SDATA[15:4];
//        end
//        else
//            count <= 0;
//            CS <= 1'b1;
//            DONE <= 1'b0;
//    end