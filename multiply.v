`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2024 10:43:04
// Design Name: 
// Module Name: multiply
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


module multiply (
    input  [31:0] a,  // Input floating-point number a
    input  [31:0] b,  // Input floating-point number b
    output [31:0] result // Output floating-point result
);

    // Extract sign, exponent, and mantissa
    wire sign_a, sign_b, sign_result;
    wire [7:0] exp_a, exp_b, exp_result;
    wire [23:0] mant_a, mant_b;
    wire [47:0] mant_result; // 24-bit mantissa * 24-bit mantissa gives a 48-bit product
    wire [23:0] mant_final;
    wire [7:0] exp_final;

    // Sign
    assign sign_a = a[31];
    assign sign_b = b[31];
    assign sign_result = sign_a ^ sign_b;

    // Exponent (considering the implicit 1 in mantissa)
    assign exp_a = a[30:23];
    assign exp_b = b[30:23];

    // Mantissa (adding the implicit 1 in the 24th bit)
    assign mant_a = {1'b1, a[22:0]};
    assign mant_b = {1'b1, b[22:0]};

    // Multiply mantissas
    assign mant_result = mant_a * mant_b;

    // Add exponents (and subtract the bias)
    assign exp_result = exp_a + exp_b - 8'd127;

    // Normalize mantissa and adjust exponent
    assign mant_final = mant_result[47] ? mant_result[46:24] : mant_result[45:23];
    assign exp_final = mant_result[47] ? exp_result : exp_result-1;
//    assign exp_final = (exp_result == 0) ? exp_result + 8'd127 : exp_result;

    // Zero Exception Handling
    wire is_a_zero = (a[30:0] == 31'b0);
    wire is_b_zero = (b[30:0] == 31'b0);
    wire is_result_zero = is_a_zero | is_b_zero;

    // Combine the result with zero exception
    assign result = is_result_zero ? 32'b0 : {sign_result, exp_final, mant_final[22:0]};

endmodule