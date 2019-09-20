`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2019 07:22:13 PM
// Design Name: 
// Module Name: MOTOR
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


module MOTOR_mv(
         input clk,
	     //input [7:0] duty,
	     input [7:0] sw,
	     //input [7:0] sw,
	     output reg PWM_output = 0 
);

//  reg[7:0] duty_value;
   
//   always @(*)
//   case(sw) 
//    8'b00000001: duty_value = 8'b00011110;  //30
//    8'b00000010: duty_value = 8'b00111100;  //60
//    8'b00000100: duty_value = 8'b01011010;  //90
//    8'b00001000: duty_value = 8'b01111000; //120
//    8'b00010000: duty_value = 8'b10010110; //150
//    8'b00100000: duty_value = 8'b10110100; //180
//    8'b01000000: duty_value = 8'b11010010; //210
//    8'b10000000: duty_value = 8'b11110000; //240
//    default: duty_value = 8'b00001111;  //15 
//    endcase
   
   
   
    reg [7:0] count = 0;
	always@(posedge clk)
	begin
		count <= count + 1;
		// If count is less than duty, then output is 1.
		// Otherwise, it's 0.
		//PWM_output <= (count < duty);
        if (count<sw)
        PWM_output <= 1;
     
        else 
        PWM_output <= 0;
   end


endmodule
