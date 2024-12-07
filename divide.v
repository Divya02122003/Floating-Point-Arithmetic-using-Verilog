`timescale 1ns / 1ps

module divide (
    input  [31:0] a,        // Input floating-point number a
    input  [31:0] b,        // Input floating-point number b
    output reg [31:0] result    // Output floating-point result
);

    // Extract sign, exponent, and mantissa
    wire sign_a = a[31];
    wire sign_b = b[31];
    wire [7:0] exp_a = a[30:23]; 
    wire [7:0] exp_b = b[30:23];
    wire [23:0] mant_a = (exp_a == 8'd0) ? {1'b0, a[22:0]} : {1'b1, a[22:0]};
    wire [23:0] mant_b = (exp_b == 8'd0) ? {1'b0, b[22:0]} : {1'b1, b[22:0]};
    
    reg  sign_result; 
    reg  [7:0] exp_result;
    reg  [23:0] mant_result; 
    reg  [23:0] quotient;
    reg  [23:0] divisor;
    reg  [23:0] dividend;
    integer i;
    
    always @(*) begin
        // Sign
        sign_result = sign_a ^ sign_b;
        
        // Handle special cases like division by zero, NaN, and infinity
        if (b == 32'b0) begin
            // Division by zero
            result = {sign_result, 8'hFF, 23'b0}; // Infinity
        end else if (a == 32'b0) begin
            // Zero divided by any number
            result = {sign_result, 31'b0}; // Zero
        end else begin
            // Exponent
            exp_result = exp_a - exp_b + 8'd127;
            
            // Initialize dividend and divisor
            dividend = mant_a;
            divisor  = mant_b;
            quotient = 24'b0;
            
            // Perform shift and subtract division
            for (i = 0; i < 24; i = i + 1) begin
                if (dividend >= divisor) begin
                    dividend = dividend - divisor;
                    quotient = quotient | (1 << (23 - i));
                end
                divisor = divisor >> 1;
            end
            
            // Normalize the result
            if (quotient[23] == 1) begin
                mant_result = quotient[23:1];
            end else begin
                mant_result = quotient[22:0];
                exp_result = exp_result - 1;
            end
            
            // Assemble the result
            result = {sign_result, exp_result, mant_result};
        end
    end
endmodule
