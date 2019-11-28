//////////////////////////////////////////////////////////////////////////////////
// Name: Itzel Ruiz
// Date: 10/16/2019
// Description: Measures Distance using ultrasonic sensor, sends signal to IPS
// if object is in range.
//////////////////////////////////////////////////////////////////////////////////
module Ultrasonic(
    input clk,
    input echo,
    output reg trig,
    output reg stop );
    
  parameter scale = 50;
	reg [15:0] count = 16'b0;
	reg [15:0] dist = 16'b0;
    reg [15:0] finalDist;
    reg [15:0] trigCount = 16'b0;
    reg [7:0] uS_count;
    wire uS_count_done = (uS_count == 100) ? 1 : 0; //Question like if else 
    
    initial begin
    count = 0;
    dist = 0;
    finalDist = 0; 
    trigCount = 0; 
    uS_count = 0; 
    trig = 0;
    stop = 0; 
    end 
    
    always @ (posedge clk)
      if (uS_count <= 100)
        uS_count <= uS_count + 1;
      else
        uS_count<=0;
        
    always @(posedge clk) begin 
           //trigger ultrasonic
       if (uS_count_done)
       begin
        if(trigCount < 20) begin
            trig = 1;
            trigCount = trigCount + 1;
        end else if(trigCount >= 20 && trigCount < 65000) begin
            trig = 0;
            trigCount = trigCount + 1;
        end else begin
            trig = 0;
            trigCount = 16'b0;
            dist = 0;
        end
            
        if(echo == 1) begin
            dist = dist + 1;
        end else begin
            finalDist = dist;
        end
        end
    end
    
    always @(posedge clk) begin
        if(finalDist > 176 && finalDist < 588)//change values
            stop  = 1;
        else
            stop = 0;
    end
endmodule