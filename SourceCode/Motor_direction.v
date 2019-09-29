`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2019 05:14:47 PM
// Design Name: 
// Module Name: Motor_direction
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2019 01:48:34 PM
// Design Name: 
// Module Name: Motor_movement
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


module Motor_direction(
   input clk,
   input [11:0]sw,
   input comparator,
   output [3:0] direction, 
   output [1:0]enable,
   output [3:0] an,
   output [6:0] seg
    );
    
    
    assign direction = sw[11:8];
    MOTOR u1(
        .clk(clk),
        .sw(sw[7:0]),
        .PWM_output(enable[0]));

    MOTOR u2(
        .clk(clk),
        .sw(sw[7:0]),
        .PWM_output(enable[1]));
   
    SSD x1(
        .clk(clk),
        .comparator(comparator),
        .sw(sw[11:8]),
        .an(an),
        .seg(seg));
                    
//    always @(*)
//    case(sw)
//    4'b0001: direction = 2'b01;
//    4'b0010: direction = 2'b10;
//    default: direction = 2'b01;
//    endcase
    
    
endmodule