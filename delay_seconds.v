`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2019 05:24:38 PM
// Design Name: 
// Module Name: delay_seconds
// Project Name: 
// Description:
//////////////////////////////////////////////////////////////////////////////////

module delay_seconds(
    input clk,
    input[3:0] limit,
    input active,
    output reg signal = 0
    );

reg reset = 0;
reg [31:0] counter = 0;
reg [3:0] second_counter = 0;
reg [31:0] Period = 100000000;
    
always@ (posedge clk)
begin
if(reset)
   begin
        counter = 0;
        second_counter=0;
        signal = 0;
   end 
if (active)
    begin
    if (second_counter<limit)
    begin
        reset = 0;
        if (counter<Period)
        begin
            counter <= counter + 1;
        end
        else 
        begin 
        counter = 0;
        second_counter <= second_counter + 1;
        end
   end
else
   begin 
        signal = 1;
        reset = 1; 
   end
end
end
endmodule