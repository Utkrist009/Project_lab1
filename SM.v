`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Itzel Ruiz
// Create Date: 11/11/2019 01:26:26 PM
// Design Name: 
// Module Name: SM
// Project Name: 
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module SM 
  (input  clk,
   input      stop,
   input      done_servo_arm,
   input      done_servo_marble,
   // These all need to be registers if you're making procedural changes to them
   output reg IPS_using_US,
   output reg enable_servo_arm,
   output reg enable_servo_marble,
   output reg reset_servo_marble,
   output reg reset_servo_arm 
   );

   localparam IPS = 0, ARM_SENSOR = 1, MARBLE_DROP = 2, IPS_NO_ULTRA = 3;
   
   reg      [1:0] state;
   reg      [1:0] count;
   reg      [31:0] count_delay;

   reg      start_count;
   reg      done_count;

   initial
     begin
        state <= 0;
        count <= 0;
        count_delay <= 0;
        start_count <= 0;
        done_count <= 0;
        // Initializing the output reg's
        IPS_using_US <= 1; // Initialize to 1 so it starts off looking at the stop signal
        enable_servo_arm <= 0;
        enable_servo_marble <= 0;
     end

// State machine
   always @(posedge clk)
   begin
     case(state)
       IPS: 
         begin 
            //ips will begin when enabled 
            //Ultrasonic will trigger the arm
            // if (done_IPS)
            if (stop)
              state <= ARM_SENSOR;
         end

       ARM_SENSOR: 
         begin 
            //arm will begin when enabled
            enable_servo_arm <= 1;
             reset_servo_arm <= 0;
            if (done_servo_arm)
              begin
                 enable_servo_arm <= 0;
                 reset_servo_arm <= 1;
                 state <= MARBLE_DROP;
              end
         end

       MARBLE_DROP: 
         begin 
            //will dispense marbles when enabled
            enable_servo_marble <= 1;
            reset_servo_marble <= 0;
            if (done_servo_marble)
              begin
                 enable_servo_marble <= 0;
                 reset_servo_marble <= 1;
                 state <= IPS_NO_ULTRA;
                 IPS_using_US <= 0;
              end
         end

       IPS_NO_ULTRA: 
         begin 
            //will ignore IPS sensor until something is detected 
            if (~stop)
              begin
                 IPS_using_US <= 1;
                 state <= IPS;
              end
         end
       default: state<=IPS;
endcase // case (state) 
end  // always @ (posedge clk)  
endmodule
