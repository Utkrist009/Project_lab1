`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2019 05:23:46 PM
// Design Name: 
// Module Name: Servo
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



module Servo(
input clk, reset,
input sw,
//output 
output enable1,
output reg led
//output enable_temp,
//output enable2
);
wire timerDone;
reg timerActive= 0;
reg [3:0] Seconds = 4'b0000;
reg done_servo_arm = 0;

wire n_clk; 

localparam servo90d=18'd145000,servo180d=18'd65000,servo0d=18'd240000,servo30d=18'd200000,servo150d=18'd95000,servo135d = 18'd110000;

reg [17:0] angle_value_servo1 = servo90d;
//reg [17:0] angle_value_servo2 = servo90d;
//localparam servo90d=3,servo180d=6,servo0d=1,servo30d=2,servo150d=5,servo135d=4;


// Second_Counter delay(.clk(clk),.reset(reset),.n_clk(n_clk));
//Second_Counter delay(.clk(clk));
 reg[2:0] Servo_FSM = 3'b000; 
 
Servo_PWM servo1(
.clk(clk),
.angle_value(angle_value_servo1),
.angle(enable1));

/*Servo_PWM servo2(
.clk(clk),
.angle_value(angle_value_servo2),
.angle(enable2));
*/

delay_seconds test(.clk(clk), .limit(Seconds), .active(timerActive), .signal(timerDone));
//localparam DELAY = 10000;
//reg [DELAY-1:0] shift_reg;
//always @(posedge clk)
// begin
// shift_reg <= {shift_reg[DELAY-2:0], enable_temp};
// end 
//assign enable2 = shift_reg[DELAY-1];
 
 always @(posedge clk)
 begin
 if (sw)
 case (Servo_FSM)
 3'b000:
 begin 
 angle_value_servo1 <= servo90d;
 //angle_value_servo2 <= servo90d;
 Seconds = 2; //period set to 2M so 4sec delay
 timerActive = 1;
 if (timerDone)
 begin
 timerActive = 0;
 Seconds = 0;
 Servo_FSM = 3'b001;
 end
 end 
 
 3'b001:
 begin 
 angle_value_servo1 <= servo180d;
 Seconds = 2; //period set to 2M so 4sec delay
 timerActive = 1;
 if (timerDone)
 begin
 timerActive = 0;
 Seconds = 0;
 Servo_FSM = 3'b010;
 end
 end 
 
 3'b010:
 begin 
 angle_value_servo1 <= servo90d;
 Seconds = 2; //period set to 2M so 4sec delay
 timerActive = 1;
 if (timerDone)
 begin
 timerActive = 0;
 Seconds = 0;
 Servo_FSM = 3'b011;
 end
 end 
 
 3'b011:
 begin 
 done_servo_arm = 1;
 if (done_servo_arm)
 begin 
    led = 1;
  end
 end 
 
 endcase 
 end 
endmodule