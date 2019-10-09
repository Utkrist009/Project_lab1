`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2019 09:03:57 PM
// Design Name: 
// Module Name: Servo_pwm
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


 module Servo_pwm(
   input clk,
   output reg angle = 0,  
   input[5:0] sw
   );
    
  reg[17:0] angle_value;

  always @(*)
   casex(sw) 
   6'bxxxxx1: angle_value = 18'd240000; //230000;  //0 degree
   6'bxxxx1x: angle_value = 18'd200000; //190000;  //30 degree
   6'bxxx1xx: angle_value = 18'd145000; //150000; //90 degree
   6'bxx1xxx: angle_value = 18'd110000; //135 degree
   6'bx1xxxx: angle_value = 18'd95000; //150 degree
   6'b1xxxxx: angle_value = 18'd65000; //70000; //180 degree
   default: angle_value = 18'd0;   
   endcase


  reg [20:0] count = 0;
   always@(posedge clk)
	begin
		count <= count + 1;
        
        if (count<angle_value)
        angle <= 1;
     
        else 
        angle <= 0;
   end   
    
  endmodule
