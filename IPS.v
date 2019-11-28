`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Itzel Ruiz
// Create Date: 10/09/2019 05:51:02 PM
// Design Name: IPS w/ Motors
//Goal: Ultrasonic Triggers motors to stop
// Description: This will take in signals from the IPS to determine which way to
// move, it will stop when a box is detected. 
//////////////////////////////////////////////////////////////////////////////////
module IPS(
 input clk, //clock
 input [2:0] sensor, //IPS (BASYS)
 //input enable_IPS, 
 input IPS_using_US,
 output [2:0] indicator,//LED on Basys
 output reg [3:0] direction, //4 bit binary for H-Bridge
 input stop, //Ultrasonic //maybe output
 output reg [15:0] widthChassis // 16 bit duty cycle value
 //output reg done_IPS
);

assign indicator = ~sensor; //invert logic on the sensor since it's active low 
   
//Duty Cycle Code 
initial 
    begin  
        direction = 4'b0;
        widthChassis = 16'd0;
    end 
 
//IPS Code 
always @(*)
begin
    if(IPS_using_US && stop)
    begin
       // case(indicator)
          //   3'b000: //Ultrasonic Found
             //begin
                  widthChassis = 16'd00000; //stop
                  direction = 4'b0000;//stop
             //end
        //endcase
    end
    else
    begin
        case (indicator)   
    3'b001://left
        begin 
            widthChassis = 16'd40000; //regular speed
            direction = 4'b0101; //left
        end
    3'b010: //forward
        begin
            widthChassis = 16'd40000;// forward 
           direction = 4'b0110; //forward
        end
    3'b100: //right
        begin
            widthChassis = 16'd40000; // right
             direction = 4'b1010; //right
        end
    3'b011: //left-s
        begin
            widthChassis = 16'd40000;//left slight
            direction = 4'b0101;
        end
    3'b101: //back 
        begin
            widthChassis = 16'd40000; //back-up
             direction = 4'b1001; //"back"
        end
    3'b110: //right-s
        begin
            widthChassis = 16'd40000; // right-slight
             direction = 4'b1010;//right
        end
    3'b111: //stop
        begin
            widthChassis = 16'd40000; //stop
            direction = 4'b0000; 
        end    
 endcase 
 end
 end 
endmodule 