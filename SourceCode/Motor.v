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


module MOTOR (
         input clk,
	     //input [7:0] duty,
	     input [7:0] sw,
	     //input [7:0] sw,
	     output reg PWM_output = 0 
);

  reg[15:0] duty_value;
   
   always @(*)
   casex(sw) 
   8'b00000001: duty_value = 16'd25000;  //30
   8'b0000001x: duty_value = 16'd30000;  //60
   8'b000001xx: duty_value = 16'd35000;  //90
   8'b00001xxx: duty_value = 16'd40000; //120
   8'b0001xxxx: duty_value = 16'd45000; //150
   8'b001xxxxx: duty_value = 16'd50000; //180
   8'b01xxxxxx: duty_value = 16'd55000; //210
   8'b1xxxxxxx: duty_value = 16'd65535; //255
   default: duty_value = 16'd0;  //15 
   endcase
   
   
   
    reg [15:0] count = 0;
	always@(posedge clk)
	begin
		count <= count + 1;
		// If count is less than duty, then output is 1.
		// Otherwise, it's 0.
		//PWM_output <= (count < duty);
        if (count<duty_value)
        PWM_output <= 1;
     
        else 
        PWM_output <= 0;
   end


endmodule