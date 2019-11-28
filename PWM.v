`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Itzel Ruiz
// Create Date: 11/17/2019 12:50:08 PM
// Design Name: 
// Module Name: PWM for other Modules
//////////////////////////////////////////////////////////////////////////////////
module PWM #(parameter SIZE=16,PERIOD=255)(
input clk,
input [SIZE-1:0] width,//angle_value
output reg pwm
);

reg [SIZE-1:0] count;

initial begin
count = 0;
pwm = 0;
end 

always @(posedge clk)
begin 
count = count + 1; 
if (count == PERIOD)
        count = 0; //reset counter 
if (count < width) //angle_value
        pwm = 1;
else 
    pwm = 0; 
end 
endmodule
 