`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2019 06:03:54 PM
// Design Name: 
// Module Name: sensor
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


module sensor(
    input clk,
    output reg enable,
    input echo,
    output reg [15:0] binary,
    output reg [3:0] dig1,
    output reg [3:0] dig2,
    output reg [3:0] dig3,
    output reg [3:0] dig4
    );
   
    
    reg [15:0] dist;
    reg clk_out = 0;
    reg[31:0] scale = 50;
    reg [15:0] count = 16'b0;

    always @(posedge clk)
        if (count == scale - 1) 
        begin
            count <= 16'b0;
            clk_out <= ~clk_out;
        end else begin
            count <= count +1;
            clk_out <= clk_out;
        end
        
     reg [15:0] trigCount = 16'b0;
     always @(posedge clk_out)
     begin
        if(trigCount < 20)
        begin
            enable = 1;
            trigCount = trigCount +1;
        end
        else if (trigCount >20 && trigCount < 65000)
        begin
            enable = 0;
            trigCount = trigCount +1;
        end else begin
            enable = 0;
            trigCount = 16'b0;
            dist = 0;
        end
        
        if(echo == 1)
            dist = dist +1;
        else
             binary = dist / 58;// calculate distance and send to antoher module
            
     end

 
    BCD utt(.binary(binary), .thousands(dig4), .hundreds(dig3), .tens(dig2), .ones(dig1)) ;


endmodule
