`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2019 06:27:47 PM
// Design Name: 
// Module Name: SevenSeg
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


module SevenSeg(
     input clk,
     
     output reg [3:0] an,      // 4 Digits on Basys 3 Board
     output reg [6:0] seg    // 7 Segment Display
     );
     wire [3:0] display1;
     wire [3:0] display2;
     wire [3:0] display3;
     wire [3:0] display4;


    sensor utt(.display1(dig1), .display2(dig2), .display3(dig3), .display4(dig4));




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
                     if (display1 == 4'd0)
                                begin
                                  an = 4'b0111;
                                  seg = 7'b1000000;//Dispays "B" for over
                                end
                          else if (display1 == 4'd1)
                                begin
                                  an = 4'b0111;
                                  seg= 7'b1111001; //Displays "F" for under
                                end 
                         else if (display1 == 4'd2)
                             begin
                                 an = 4'b0111;
                                 seg= 7'b0100100; //Displays "0" for under
                             end 
                         else 
                             begin
                                  an = 4'b0111;
                                  seg= 7'b1111111; //Displays "0" for under
                             end
               end
          2'b01:
               begin
                    an = 4'b1011;
                    seg = 7'b0001000;
               end
          2'b10:
               begin
                    an = 4'b1101;
                    seg = 7'b0000011;
               end
          2'b11:
               begin
                    an = 4'b1110;
                    seg = 7'b1111001;
               end
          endcase

endmodule
