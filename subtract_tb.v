`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2024 10:32:26
// Design Name: 
// Module Name: substract_tb
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


module subtract_tb();
reg [31:0]a;
reg [31:0]b;
wire [31:0]result;
subtract test(a,b,result);
initial
begin
a=0;
b=0;
#10 a=32'b01000001000111000000000000000000;
b=32'b00111111000100000000000000000000;
#10 a=32'b01000001000111000000000000000000;
b=32'b10111111000100000000000000000000;
#10 a=32'b10110000000000000000000000000000;
b=32'b11000000000000000000000000000000;
end
endmodule;