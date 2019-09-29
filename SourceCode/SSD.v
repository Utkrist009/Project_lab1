`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Itzel Ruiz
// Create Date: 09/19/2019 02:57:29 PM
// Module Name: disp_1234
// Project Name: 
// Target Devices:  
// Description: 

//////////////////////////////////////////////////////////////////////////////////

module SSD(
     input clk,
     input comparator,
     input [11:8] sw,
     output reg [3:0] an,      // 4 (anodes)
     output reg [6:0] seg    // 7 (Cathodes)                                
     );
        //reg comparator = 1;
     // Use the 2 MSBs of 19-bit counter to create 190 Hz frequency refresh
     reg [18:0] count;
     always @ (posedge clk)
          count = count + 1;

     // This wire is driven by the 2 MSBs of the counter. We'll use it to
     // refresh the display.
     wire [1:0] refresh;
     assign refresh = count[18:17];

//Case to display desired numbers in our case "1234"
     always @ (*)
          case(refresh)
          2'b00:
                    begin
                          if (sw[11:8] == 4'b1001)
                                begin
                                  an = 4'b0111;
                                  seg = 7'b0000011;//Dispays "B" for over
                                end
                          else if (sw[11:8] == 4'b0110)
                                begin
                                  an = 4'b0111;
                                  seg= 7'b0001110; //Displays "F" for under
                                end 
                         else if (sw[11:8] == 4'b1010)
                             begin
                                 an = 4'b0111;
                                 seg= 7'b1000000; //Displays "0" for under
                             end 
                         else 
                             begin
                                  an = 4'b0111;
                                  seg= 7'b1000000; //Displays "0" for under
                             end
               end            
          2'b01:
               begin
                    an = 4'b1011;
                    seg = 7'b1111111;//Displays 0 
               end
          2'b10:
               begin
                    an = 4'b1101;
                    seg = 7'b1111111;//Displays 0 
               end
          2'b11:
               begin     
                         if (comparator == 1)
                                begin
                                  an = 4'b1110;
                                  seg = 7'b1000000;//Dispays "O" for over
                                end
                              else
                                begin
                                  an = 4'b1110;
                                  seg = 7'b1000001; //Displays "U" for under
                                end
              end
          endcase
endmodule          