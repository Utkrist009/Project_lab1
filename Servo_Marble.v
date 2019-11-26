`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2019 02:17:47 AM
// Design Name: 
// Module Name: Servo_Marble
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


module Servo_Marble(
input clk, reset,
input sw,
//output 
output enable_m,
output reg led
);

wire timerDone;
reg timerActive= 0;
reg [3:0] Seconds = 4'b0000;
reg done_servo_marble = 0;


wire n_clk; 

localparam servo90d=18'd145000,servo180d=18'd65000,servo0d=18'd240000,servo30d=18'd200000,servo150d=18'd95000,servo135d = 18'd110000;

reg [17:0] angle_value_marble = servo180d;
//reg [17:0] angle_value_servo2 = servo90d;
//localparam servo90d=3,servo180d=6,servo0d=1,servo30d=2,servo150d=5,servo135d=4;


// Second_Counter delay(.clk(clk),.reset(reset),.n_clk(n_clk));
//Second_Counter delay(.clk(clk));
 reg[2:0] Marble_FSM = 3'b000; 
 
Servo_PWM marble(
.clk(clk),
.angle_value(angle_value_marble),
.angle(enable_m));

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
 case (Marble_FSM)
 3'b000:
 begin 
 angle_value_marble <= servo180d;
 //angle_value_servo2 <= servo90d;
 Seconds = 1; //period set to 2M so 4sec delay
 timerActive = 1;
 if (timerDone)
 begin
 timerActive = 0;
 Seconds = 0;
 Marble_FSM = 3'b001;
 end
 end 
 
 3'b001:
 begin 
 angle_value_marble <= servo0d;
 Seconds = 1; //period set to 2M so 4sec delay
 timerActive = 1;
 if (timerDone)
 begin
 timerActive = 0;
 Seconds = 0;
 Marble_FSM = 3'b010;
 end
 end 
 
 3'b010:
 begin 
 angle_value_marble <= servo180d;
 Seconds = 1; //period set to 2M so 4sec delay
 timerActive = 1;
 if (timerDone)
 begin
 timerActive = 0;
 Seconds = 0;
 Marble_FSM = 3'b011;
 end
 end 
 
 3'b011:
 begin 
 done_servo_marble = 1;
 if (done_servo_marble)
 begin 
    led = 1;
  end
 end 
 
 endcase 
 end 


endmodule
