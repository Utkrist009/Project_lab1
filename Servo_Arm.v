`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2019 05:23:46 PM
// Design Name: 
// Module Name: Servo
// Project Name: 
// 
//////////////////////////////////////////////////////////////////////////////////
module Servo_Arm(
input clk,stop,
input enable_servo_arm, //sw 
output reg done_servo_arm, //led
output reg [17:0] widthArm
);

wire timerDone;
reg timerActive= 0;
reg [3:0] Seconds = 4'b0000;
//reg done_servo_arm = 1'b0;

wire n_clk; 

localparam servo90d=18'd145000,servo180d=18'd65000,servo0d=18'd240000,servo30d=18'd200000,servo150d=18'd95000,servo135d = 18'd110000;
initial 
    begin 
        widthArm = servo90d; //keep
    end

reg[2:0] Servo_FSM = 3'b000; 

delay_seconds test(.clk(clk), .limit(Seconds), .active(timerActive), .signal(timerDone));

 always @(posedge clk)
    begin
        if (enable_servo_arm)
        case (Servo_FSM)
 3'b000:
    begin 
        widthArm <= servo90d;
        Seconds = 2; 
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
        widthArm <= servo180d;
        Seconds = 5; //period set to 2M so 4sec delay
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
        widthArm <= servo90d;
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
       // if (done_servo_arm)
   // begin 
     //   led = 1;
    //end
end 
endcase 
end 
endmodule