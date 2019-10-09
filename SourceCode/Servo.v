`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2019 07:17:03 PM
// Design Name: 
// Module Name: servo_test
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
input clk,
input[5:0] sw,
output enable
    );
    
Servo_pwm Test(
.clk(clk),
.sw(sw),
.angle(enable));
        
    
endmodule



