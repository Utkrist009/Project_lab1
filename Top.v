`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Itzel Ruiz
// Create Date: 11/11/2019 01:26:26 PM
// Design Name: 
// Module Name: Top
// Project Name: 
// Revision:
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module Top(
   trig, seg, indicator, direction, an, LED15, LED14, LED13,
   servoMarble, servoArm, HBridgeEN,
   // Inputs
   sensor, rst, echo, comparator, clk, MoistureCompMed,
   MoistureCompHigh
);
   input clk;
   input echo;
   input rst;
   input [2:0] sensor;
   input comparator;
   input MoistureCompHigh; 
   input MoistureCompMed;
   //input done_servo_arm,
   //input done_servo_marble,
   //output reg IPS_using_US,
   output servoMarble;
   output servoArm;
   output [1:0] HBridgeEN;
   output [3:0] direction; 
   output [2:0] indicator;
   //output [1:0] enable;
   output [3:0] an;
   output [6:0] seg;
   output trig; 
   output LED13;
   output LED14;
   output LED15;
   
   wire IPS_using_US;
   wire done_servo_arm;
   wire done_servo_marble;
   wire enable_servo_arm;
   wire enable_servo_marble;
   wire stop; 
   wire [1:0]  marble;
   wire [15:0] widthChassis; 
   wire [17:0] widthMarble;
   wire [17:0] widthArm;
   wire pwm;
   
   //assign enable = {pwm,pwm}; //vector
   
   //Chassis PWM (HBridgeEN)
   PWM #(16,65535) u00(
   .clk(clk),
   .width(widthChassis),
   .pwm(HBridgeEN[1])
   );
   
   PWM #(16,65535) u01(
   .clk(clk),
   .width(widthChassis),
   .pwm(HBridgeEN[2])
   );
   
   //Servo Marble
    PWM #(19,600000) u02(
   .clk(clk),
   .width(widthMarble),
   .pwm(servoMarble)
   );
   
   //Servo Arm
  PWM #(19,600000) u03(
    .clk(clk),
    .width(widthArm),
    .pwm(servoArm)
     );
   
    IPS u04(
        .clk(clk),
        .IPS_using_US(IPS_using_US),
        .direction(direction [3:0]),
        .sensor(sensor [2:0]),
        .indicator(indicator),
        .stop(stop),
        .widthChassis(widthChassis[15:0])
        );
    Ultrasonic u05(
        .clk(clk),
        .echo(echo),
        .trig(trig),
        .stop(stop)
      );
      
     CP_SSD u06(
        .clk(clk),
        .comparator(comparator),
        .an(an[3:0]),
        .seg(seg[6:0])
        );
        
     MoistureSensor u07(
        .clk(clk),
        .MoistureCompHigh(MoistureCompHigh),
        .MoistureCompMed(MoistureCompMed),
        .marble(marble[1:0]),
        .LED13(LED13),
        .LED14(LED14),
        .LED15(LED15)
        );
     
     Servo_Marble u08(
        .done_servo_marble(done_servo_marble),       
        .clk(clk),
        .enable_servo_marble(enable_servo_marble),
        .marble(marble[1:0]),
        .widthMarble(widthMarble[17:0]),
        .rst(rst)
        ); 
        
    Servo_Arm u09(
      .done_servo_arm(done_servo_arm),
      .enable_servo_arm(enable_servo_arm),
      .clk(clk),
      .stop(stop),
      .widthArm(widthArm[17:0]));
      
    SM u10(
    .IPS_using_US(IPS_using_US), //outputs
    .enable_servo_arm(enable_servo_arm),
    .enable_servo_marble(enable_servo_marble),
    .clk(clk), //inputs
    .stop(stop),
    .done_servo_arm(done_servo_arm),
    .done_servo_marble(done_servo_marble)
 );
endmodule
