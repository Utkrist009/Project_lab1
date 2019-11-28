`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Itzel Ruiz
// Create Date: 09/19/2019 02:57:29 PM
// Module Name: SSD  
// Description: 
// This is the Module for the Comparator/Current Detection, with the SSD on the BASYS
// and the GreenBoard. 
//////////////////////////////////////////////////////////////////////////////////

module CP_SSD(
     input clk,
     input comparator,//signal from comparator circuit
     output reg [3:0] an,      // 4 (anodes)
     output reg [6:0] seg    // 7 (Cathodes)                                
     );
     
     
     // Use the 2 MSBs of 19-bit counter to create 190 Hz frequency refresh
     reg [18:0] count;
     always @ (posedge clk)
          count = count + 1;
     // This wire is driven by the 2 MSBs of the counter. We'll use it to
     // refresh the display.
     wire [1:0] refresh;
     assign refresh = count[18:17];

//Case to display desired numbers in our case "F(b)--U(O)"
     always @ (*)
          case(refresh)
          2'b00:
               begin
                    an = 4'b1011;
                    seg = 7'b1111111;//Displays 0 
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