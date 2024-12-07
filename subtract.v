`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2024 20:26:11
// Design Name: 
// Module Name: add_1
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


module subtract (
    input [31:0] a,  // 32-bit input a
    input [31:0] b,  // 32-bit input b
    output reg[31:0] result  // 32-bit result
);
    integer i;
    // Extract fields
    wire sign_a = a[31];
    wire sign_b = b[31];
    wire [7:0] exp_a = a[30:23];
    wire [7:0] exp_b = b[30:23];
    wire [23:0] mant_a = {1'b1, a[22:0]};
    wire [23:0] mant_b = {1'b1, b[22:0]};

    // Variables for alignment
    reg [23:0] mant_a_shifted;
    reg [23:0] mant_b_shifted;
    reg [7:0] exp_diff;

    // Variables for addition
    reg [24:0] mant_sub;
    reg sign_res;
    reg [7:0] exp_res;
    
    // Process block to align mantissas, add/subtract, and normalize
    always @(*) begin
        // Align exponents
        if (exp_a > exp_b) begin
            exp_diff = exp_a - exp_b;
            mant_b_shifted = mant_b >> exp_diff;
            mant_a_shifted = mant_a;
            exp_res = exp_a;
        end else begin
            exp_diff = exp_b - exp_a;
            mant_a_shifted = mant_a >> exp_diff;
            mant_b_shifted = mant_b;
            exp_res = exp_b;
        end
            
        // Add/Subtract mantissas
        // Subtract mantissas
                if (sign_a == sign_b) begin
                    if (mant_a_shifted >= mant_b_shifted) begin
                        mant_sub = mant_a_shifted - mant_b_shifted;
                        sign_res = sign_a;
                    end else begin
                        mant_sub = mant_b_shifted - mant_a_shifted;
                        sign_res = sign_b-1;
                    end
                end else begin
                    mant_sub = mant_a_shifted + mant_b_shifted;
                    sign_res = sign_a;
                end
                
                // Normalize the result if needed
                if (mant_sub[24] == 1) begin  // Handle carry bit
                    mant_sub = mant_sub >> 1;
                    if(exp_res==8'b0)begin
                        exp_res=8'b0;
                     end
                     else begin
                    exp_res = exp_res + 1;
                    end
                end else begin
                    for (i = 0; i < 23; i = i + 1) begin
                        if (mant_sub[23] != 1 && exp_res != 0) begin
                        mant_sub = mant_sub << 1;
                        exp_res = exp_res - 1;
                    end
                end
        
                // Handle special case when mantissa is zero
//                if (mant_sub == 0) begin
//                    exp_res = 0;
//                end
        end
                // Assemble the result
                result = {sign_res, exp_res, mant_sub[22:0]};
        end
endmodule