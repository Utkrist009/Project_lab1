`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 10/26/2019 12:35:49 PM 
// Module Name: MoistureSensor
// Description: This will use the Moisture sensor to go through a comparator circuit 
// and determine if the Moisture is High,Med,Low
//////////////////////////////////////////////////////////////////////////////////
module MoistureSensor(
input clk,
input MoistureCompHigh, //Determines if moisture is high (BASYS)
input MoistureCompMed, //Determines if moisture is medium or low (BASYS)
output reg LED15,//Moisture is High (1 Marble)
output reg LED14,//Moisture is Medium (2 Marbles)
output reg LED13,//Moisture is Low (3 Marbles)
output reg [1:0] marble
);

always @(*) 
  begin     
         //if (MoistureCompHigh && MoistureCompMed)
           if (MoistureCompHigh == 1 )
            begin
               LED15 = 1;  
               marble = 2'b01; //1 marble
             end
        // else if (MoistureCompMed == 1 && MoistureCompHigh == 0)
        else if(MoistureCompMed == 1)
             begin
                LED14 = 1;
                marble = 2'b10; //2 marbles
             end
        else 
            begin 
                LED13 = 1;  
                marble = 2'b11; //3 marbles
           end
end           
endmodule