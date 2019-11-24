`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 11/17/2019 12:50:58 PM
// Module Name: Servo_Marble
// Description:
// This will take in a signal from the Moisture sensor and decide how many marbles
// to dispense.
//////////////////////////////////////////////////////////////////////////////////

module Servo_Marble(
    input clk,
    input enable_servo_marble,
    input marble,
    output reg [20:0] angle_value,
    output reg done_servo_marble
   );

   localparam INIT_STATE = 0, STATE_1 = 1, STATE_2 = 2, STATE_3 = 3;
   
   reg state;
   reg [1:0] count;
   reg [31:0] count_delay;
   reg [1:0]  marble_sync;

   reg start_count;
   reg done_count;

   initial
     begin
        angle_value <= 0;
        state <= 0;
        count <= 0;
        count_delay <= 0;
        start_count <= 0;
        done_count <= 0;
        marble_sync <= 0;
        done_servo_marble <= 0;
     end

   // D-Flip Flop
   always @ (posedge clk)
     marble_sync <= marble;

   // Counter
   always @ (posedge clk)
     begin
        if (start_count)
          count_delay <= count_delay + 1;
        // Half a second
        if (count_delay >= 50_000_000)
          done_count <= 1;
     end

   // State machine
   always @(posedge clk)
     begin
        if (enable_servo_marble)
          case(state)
            INIT_STATE:
              begin
                 count <= count+1;
                 if(count<marble_sync)
                   state <= STATE_2;
                 else
                   begin
                      state <= INIT_STATE;
                      done_servo_marble <= 1;
                   end
              end
            STATE_2: 
              begin
                 angle_value <= 20'd230000;
                 start_count <= 1; 
                 if(done_count)
                   begin
                      start_count <= 0;
                      state <= STATE_3;
                   end
              end

            STATE_3: 
              begin 
                 angle_value <= 20'd65000;
                 start_count <= 1; 
                 if(done_count)
                   begin
                      start_count <= 0;
                      state <= INIT_STATE;
                   end
              end
            default: state<=INIT_STATE;
          endcase // case (state)
        else
          begin
             done_servo_marble <= 0;
             state <= INIT_STATE;
             angle_value <= 0;
             count <= 0;
             count_delay <= 0;
             start_count <= 0;
          end  
     end // always @ (posedge clk)

endmodule
