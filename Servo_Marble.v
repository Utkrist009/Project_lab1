`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 11/17/2019 12:50:58 PM
// Module Name: Servo_Marble
// Description:
// This will take in a signal from the Moisture sensor and decide how many marbles
// to dispense.
//////////////////////////////////////////////////////////////////////////////////

module Servo_Marble(
    input             clk, 
    // input rst,
    input             enable_servo_marble,//from Main SM
    input [1:0]       marble,
    output reg [17:0] widthMarble,
    output reg        done_servo_marble // To Main SM 
   );

   // State definitions
   localparam INIT_STATE = 0, STATE_1 = 1, STATE_2 = 2, STATE_3 = 3;
   // Define the delay for waiting for the servo to be finished
   //localparam DELAY=100;
   localparam DELAY=200_000_000;
   
   reg [1:0] state;
   reg [1:0] count;
   reg [31:0] count_delay;
   reg [1:0]  marble_sync;

   initial
     begin
        widthMarble <= 0;
        state <= 0;
        count <= 0;
        count_delay <= 0;
        marble_sync <= 0;
        done_servo_marble <= 0;
     end

   // D-Flip Flop
   always @ (posedge clk)
     marble_sync <= marble;

   // State machine
   always @(posedge clk)
    // begin
        //if (rst)
          begin
             /*AUTORESET*/
             // Beginning of autoreset for uninitialized flops
             //widthMarble <= 20'h0;
             //count <= 2'h0;
             //count_delay <= 32'h0;
             //done_servo_marble <= 1'h0;
             //state <= 2'h0;
             // End of automatics
          //end  
       // else 
          if (enable_servo_marble && ~done_servo_marble)
            case(state)
              INIT_STATE:
                begin
                   count <= count+1;
                   if(count<=marble_sync - 1)
                     state <= STATE_2;
                   else
                     begin
                        state <= INIT_STATE;
                        done_servo_marble <= 1;
                     end
                end
              STATE_2: 
                begin
                   widthMarble <= 18'd240000;
                   count_delay <= count_delay + 1;
                   if(count_delay >= DELAY)
                     begin
                        count_delay <= 0;
                        state <= STATE_3;
                     end
                end

              STATE_3: 
                begin 
                   widthMarble <= 18'd65000;
                   count_delay <= count_delay + 1;
                   if(count_delay >= DELAY)
                     begin
                        count_delay <= 0;
                        state <= INIT_STATE;
                     end
                end
              default: state<=INIT_STATE;
            endcase // case (state)
     end // always @ (posedge clk)

endmodule