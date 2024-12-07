`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2024 11:28:33
// Design Name: 
// Module Name: multiply_tb
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


module multiply_tb();
reg [31:0]a;
reg [31:0]b;
wire [31:0]result;
multiply test(a,b,result);
initial
begin
a=0;
b=0;
#10;
a = 32'b00111111101000000000000000000000;  
b = 32'b00111111010000000000000000000000;  
#10 a=32'b01000001000111000000000000000000;
b=32'b10111111000100000000000000000000;
#10;
end
endmodule;