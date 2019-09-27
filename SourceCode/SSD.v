`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Itzel Ruiz
// 
// Create Date: 09/27/2019 05:10:27 PM
// Design Name: 
// Module Name: SSD
// Project Name:
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SSD(
input clk,
     output reg [3:0] an,      // 4 Digits on Basys 3 Board
     output reg [6:0] seg    // 7 Segment Display
     );

     // Use the 2 MSBs of 19-bit counter to create 190 Hz frequency refresh
     reg [18:0] count;
     always @ (posedge clk)
          count = count + 1;

     // This wire is driven by the 2 MSBs of the counter. We'll use it to
     // refresh the display.
     wire [1:0] refresh;
     assign refresh = count[18:17];

     // Usually always @ * is not recommended because it's resource intensive
     // and usually unnecessary, and if you're not careful it will cause timing
     // issues. This isn't an issue for a simple program like this though.
     always @ (*)
          case(refresh)
          2'b00:
               begin
                    an = 4'b0111;//Digit 1
                    seg = 7'b0000011;//Displays "b" for Backwards
               end
          2'b01:
               begin
                    an = 4'b1011;//Digit 2
                    seg = 7'b0001110;//Displays "F" for Forwards
               end
          2'b10:
               begin
                    an = 4'b1101;//Digit 3
                    seg = 7'b1000000;//Displays "O" for over
               end
          2'b11:
               begin
                    an = 4'b1110; //Digit 4
                    seg = 7'b10000001;//Displays "U" for under
               end
endcase


endmodule