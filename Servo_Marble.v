`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 11/17/2019 12:50:58 PM
// Module Name: Servo_Marble
// Description:
// This will take in a signal from the Moisture sensor and decide how many marbles
// to dispense. 
//////////////////////////////////////////////////////////////////////////////////
module Servo_Marble(
input clk,
output reg angle = 0, 
output reg marble,
output reg[20:0] angle_value
);

always @ (posedge clk)
 if (start)
 begin 
      if (uS_count <= 100)
        uS_count <= uS_count + 1;
      else
        uS_count<=0;
end 
 
always @(*) //One Marble Dispensed 
case(marble)
  2'b00://Idle
        begin
             angle_value = 20'd65000;
        end
  2'b01://1 marble
        begin
             angle_value = 20'd230000;
             //delay start = 1; 
             
             angle_value = 20'd65000;
        end
  
  2'b10: //2 marbles
        begin
             angle_value = 20'd230000;
             //delay
             angle_value = 20'd65000;
             //delay
             angle_value = 20'd230000;
             //delay
             angle_value = 20'd65000;
        end
  
  2'b11://3 marbles
        begin 
             angle_value = 20'd230000;
             //delay
             angle_value = 20'd65000;
             //delay
             angle_value = 20'd230000;
             //delay
             angle_value = 20'd65000;
             //delay
             angle_value = 20'd230000;
             //delay
             angle_value = 20'd65000;
  end
  endcase

//PWM
//angle  
//angle_value 
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