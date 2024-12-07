`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2024 11:47:57 AM
// Design Name: 
// Module Name: divide
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

//module divide(
//    input [31:0] a,  // 32-bit input a (numerator)
//    input [31:0] b,  // 32-bit input b (denominator)
//    output [31:0] result  // 32-bit result
//);

//    // Extract fields
//    wire sign_a = a[31];
//    wire sign_b = b[31];
//    wire [7:0] exp_a = a[30:23];
//    wire [7:0] exp_b = b[30:23];
//    wire [23:0] mant_a = {1'b1, a[22:0]};
//    wire [23:0] mant_b = {1'b1, b[22:0]};

//    // Variables for division
//    reg [47:0] mant_div;
//    reg sign_res;
//    reg [7:0] exp_res;
//    reg [22:0] mant_res;

//    // Assign sign 
//    always @* begin
//        sign_res = sign_a ^ sign_b;
//    end

//    // Align exponents
//    always @* begin
//        exp_res = exp_a - exp_b + 8'd127;  
//    end

//    // Divide mantissas
//    always @* begin
//        mant_div = mant_a / mant_b; // Perform division with extra precision
//    end

//    // Normalize result
//    always @* begin
//        if (mant_div[47]) begin  // If the most significant bit is 1, shift right
//            mant_res = mant_div >> 1;
//            exp_res = exp_res + 1;
//        end else begin  // No need to shift
//            mant_res = mant_div[45:23];
//        end
//    end
//    // Construct the result
//    assign result = {sign_res, exp_res, mant_res};

//endmodule

//module divide(
//    input [31:0] a,  // 32-bit input a (numerator)
//    input [31:0] b,  // 32-bit input b (denominator)
//    output [31:0] result  // 32-bit result
//);

//    // Extract fields
//    wire sign_a = a[31];
//    wire sign_b = b[31];
//    wire [7:0] exp_a = a[30:23];
//    wire [7:0] exp_b = b[30:23];
//    wire [23:0] mant_a = {1'b1, a[22:0]};
//    wire [23:0] mant_b = {1'b1, b[22:0]};

//    // Variables for division
//    reg [23:0] mant_div;  // Result of division should fit in 24 bits
//    reg sign_res;
//    reg [7:0] exp_res;
//    reg [22:0] mant_res;
//    integer shift;

//    // Assign sign
//    always @* begin
//        sign_res = sign_a ^ sign_b;
//    end

//    // Align exponents
//    always @* begin
//        exp_res = exp_a - exp_b + 8'd127;  
//    end

//    // Divide mantissas
//    always @* begin
//        mant_div = (mant_a << 23) / mant_b;  // Shift left for higher precision before division
//    end

//    // Normalize result using a for loop
//    always @* begin
//        mant_res = mant_div[22:0];

//        // Shift mantissa left until MSB is 1
//        for (shift = 0; shift < 23 && mant_res[22] == 1'b0; shift = shift + 1) begin
//            mant_res = mant_res << 1;
//        end

//        // Adjust exponent based on the number of shifts
//        exp_res = exp_res - shift;
//    end

//    // Construct the result
//    assign result = {sign_res, exp_res, mant_res};

//endmodule

//module divide(
//    input [31:0] a,  // 32-bit input a (numerator)
//    input [31:0] b,  // 32-bit input b (denominator)
//    output [31:0] result  // 32-bit result
//);

//    // Extract fields
//    wire sign_a = a[31];
//    wire sign_b = b[31];
//    wire [7:0] exp_a = a[30:23];
//    wire [7:0] exp_b = b[30:23];
//    wire [23:0] mant_a = {1'b1, a[22:0]};
//    wire [23:0] mant_b = {1'b1, b[22:0]};

//    // Variables for division
//    reg [47:0] mant_div;  // Increase bit-width for mantissa division to avoid overflow
//    reg sign_res;
//    reg [7:0] exp_res;
//    reg [22:0] mant_res;
//    integer shift;

//    // Assign sign
//    always @* begin
//        sign_res = sign_a ^ sign_b;
//    end

//    // Align exponents
//    always @* begin
//        exp_res = exp_a - exp_b + 8'd127;
//    end

//    // Divide mantissas
//    always @* begin
//        mant_div = (mant_a << 23) / mant_b;  // Shift left for higher precision before division
//    end

//    // Normalize result using a for loop
//    always @* begin
//        mant_res = mant_div[22:0];

//        // Shift mantissa left until MSB is 1
//        for (shift = 0; shift < 23 && mant_res[22] == 1'b0; shift = shift + 1) begin
//            mant_res = mant_res << 1;
//        end

//        // Adjust exponent based on the number of shifts
//        exp_res = exp_res - shift;

//        // Handle possible exponent underflow or overflow
//        if (exp_res < 8'd0) exp_res = 8'd0;
//        else if (exp_res > 8'd255) exp_res = 8'd255;
//    end

//    // Construct the result
//    assign result = {sign_res, exp_res, mant_res};

//endmodule

//module divide(  
//   input [31:0] a,  // 32-bit input a (numerator)  
//   input [31:0] b,  // 32-bit input b (denominator)  
//   output reg[31:0] result  // 32-bit result  
//);  
  
//   // Extract fields  
//   wire sign_a = a[31];  
//   wire sign_b = b[31];  
//   wire [7:0] exp_a = a[30:23];  
//   wire [7:0] exp_b = b[30:23];  
//   wire [23:0] mant_a = {1'b1, a[22:0]};  
//   wire [23:0] mant_b = {1'b1, b[22:0]};  
  
//   // Variables for division  
//   reg [47:0] mant_div;  
//   reg sign_res;  
//   reg [7:0] exp_res;  
//   reg [22:0] mant_res;  
//   integer i;
  
//   // Assign sign  
//   always @* begin  
//      sign_res = sign_a ^ sign_b;  
//   end  
  
//   // Align exponents  
//   always @* begin  
//      exp_res = exp_a - exp_b + 8'd127;  
//   end  
  
//   // Divide mantissas using a shift and subtract algorithm  
//   always @* begin  
//      mant_div = mant_a;  
//      for (i = 0; i < 24; i=i+1) begin  
//        if (mant_div >= mant_b) begin  
//           mant_div = mant_div - mant_b;  
//           mant_res[i] = 1'b1;  
//        end else begin  
//           mant_div = mant_div << 1;  
//           mant_res[i] = 1'b0;  
//        end  
//      end  
//   end  
  
//   // Normalize result and handle special cases  
//   always @* begin  
//      if (mant_b == 0) begin // Division by zero  
//        if (mant_a == 0) begin // 0/0 is NaN  
//           result = 32'h7FFFFFFF;  
//        end else begin // Non-zero/0 is infinity  
//           result = {sign_a, 8'hFF, 23'h0};  
//        end  
//      end else if (mant_div == 0) begin // Exact division  
//        result = {sign_res, exp_res, 23'h0};  
//      end else begin // Normal case  
//        if (mant_div[47]) begin // If the most significant bit is 1, shift right  
//           mant_res = mant_div >> 1;  
//           exp_res = exp_res + 1;  
//        end else begin // No need to shift  
//           mant_res = mant_div[45:23];  
//        end  
//        // Check for overflow/underflow  
//        if (exp_res > 8'hFF) begin // Overflow  
//           result = {sign_res, 8'hFF, 23'h7F};  
//        end else if (exp_res < 8'h00) begin // Underflow  
//           result = {sign_res, 8'h00, 23'h0};  
//        end else begin  
//           result = {sign_res, exp_res, mant_res};  
//        end  
//      end  
//   end  
  
//endmodule

//module divide(  
//  input [31:0] a, // 32-bit input a (numerator)  
//  input [31:0] b,  // 32-bit input b (denominator)  
//  output reg[31:0] result  // 32-bit result  
//);  
  
//  // Extract fields  
//  wire sign_a = a[31];  
//  wire sign_b = b[31];  
//  wire [7:0] exp_a = a[30:23];  
//  wire [7:0] exp_b = b[30:23];  
//  wire [23:0] mant_a = {1'b1, a[22:0]};  
//  wire [23:0] mant_b = {1'b1, b[22:0]};  
  
//  // Variables for division  
//  reg [47:0] mant_div;  
//  reg sign_res;  
//  reg [7:0] exp_res;  
//  reg [22:0] mant_res;  
//  integer i;  
  
//  // Assign sign  
//  always @* begin  
//    sign_res = sign_a ^ sign_b;  
//  end  
  
//  // Align exponents and perform division  
//  always @* begin  
//    exp_res = exp_a - exp_b + 8'd127;  
//    mant_div = mant_a;  
//    for (i = 0; i < 24; i=i+1) begin  
//      if (mant_div >= mant_b) begin  
//        mant_div = mant_div - mant_b;  
//        mant_res[i] = 1'b1;  
//      end else begin  
//        mant_div = mant_div << 1;  
//        mant_res[i] = 1'b0;  
//      end  
//    end  
//  end  
  
//  // Normalize result and handle special cases  
//  always @* begin  
//    if (mant_b == 0) begin // Division by zero  
//      if (mant_a == 0) begin // 0/0 is NaN  
//        result = 32'h7FFFFFFF;  
//      end else begin // Non-zero/0 is infinity  
//        result = {sign_a, 8'hFF, 23'h0};  
//      end  
//    end else if (mant_div == 0) begin // Exact division  
//      result = {sign_res, exp_res, 23'h0};  
//    end else begin // Normal case  
//      if (mant_div[47]) begin // If the most significant bit is 1, shift right  
//        mant_res = mant_div >> 1;  
//        exp_res = exp_res + 1;  
//      end else begin // No need to shift  
//        mant_res = mant_div[45:23];  
//      end  
//      // Check for overflow/underflow  
//      if (exp_res > 8'hFF) begin // Overflow  
//        result = {sign_res, 8'hFF, 23'h7F};  
//      end else if (exp_res < 8'h00) begin // Underflow  
//        result = {sign_res, 8'h00, 23'h0};  
//      end else begin  
//        result = {sign_res, exp_res, mant_res};  
//      end  
//    end  
//  end  
  
//endmodule

//module divide(  
//   input [31:0] a,  // 32-bit input a (numerator)  
//   input [31:0] b,  // 32-bit input b (denominator)  
//   output [31:0] result  // 32-bit result  
//);  
  
//   // Extract fields  
//   wire sign_a = a[31];  
//   wire sign_b = b[31];  
//   wire [7:0] exp_a = a[30:23];  
//   wire [7:0] exp_b = b[30:23];  
//   wire [23:0] mant_a = {1'b1, a[22:0]};  
//   wire [23:0] mant_b = {1'b1, b[22:0]};  
  
//   // Variables for division  
//   reg [47:0] mant_div;  
//   reg sign_res;  
//   reg [7:0] exp_res;  
//   reg [22:0] mant_res;  
//   integer i;  
  
//   // Assign sign  
//   always @* begin  
//      sign_res = sign_a ^ sign_b;  
//   end  
  
//   // Align exponents  
//   always @* begin  
//      exp_res = exp_a - exp_b + 8'd127;   
//   end  
  
//   // Divide mantissas using a shift and subtract algorithm  
//   always @* begin  
//      mant_div = mant_a;  
//      for (i = 0; i < 24; i=i+1) begin  
//        if (mant_div >= mant_b) begin  
//           mant_div = mant_div - mant_b;  
//           mant_res[i] = 1'b1;  
//        end else begin  
//           mant_div = mant_div << 1;  
//           mant_res[i] = 1'b0;  
//        end  
//      end  
//   end  
  
//   // Normalize result  
//   always @* begin  
//      if (mant_div[47]) begin  // If the most significant bit is 1, shift right  
//        mant_res = mant_div >> 1;  
//        exp_res = exp_res + 1;  
//      end else begin  // No need to shift  
//        mant_res = mant_div[45:23];  
//      end  
//   end  
  
//   // Construct the result  
//   assign result = {sign_res, exp_res, mant_res};  
  
//endmodule

//module divide(  
//   input [31:0] a,  // 32-bit input a (numerator)  
//   input [31:0] b,  // 32-bit input b (denominator)  
//   output [31:0] result  // 32-bit result  
//);  
  
//   // Extract fields  
//   wire sign_a = a[31];  
//   wire sign_b = b[31];  
//   wire [7:0] exp_a = a[30:23];  
//   wire [7:0] exp_b = b[30:23];  
//   wire [23:0] mant_a = {1'b1, a[22:0]};  
//   wire [23:0] mant_b = {1'b1, b[22:0]};  
  
//   // Variables for division  
//   reg [47:0] mant_div;  
//   reg sign_res;  
//   reg [7:0] exp_res;  
//   reg [22:0] mant_res;  
//   integer i;  
  
//   // Assign sign  
//   always @* begin  
//      sign_res = sign_a ^ sign_b;  
//   end  
  
//   // Align exponents  
//   always @* begin  
//      exp_res = exp_a - exp_b + 8'd127;   
//   end  
  
//   // Divide mantissas using a shift and subtract algorithm  
//   always @* begin  
//      mant_div = mant_a;  
//      for (i = 0; i < 24; i=i+1) begin  
//        if (mant_div >= mant_b) begin  
//           mant_div = mant_div - mant_b;  
//           mant_res[i] = 1'b1;  
//        end else begin  
//           mant_div = mant_div << 1;  
//           mant_res[i] = 1'b0;  
//        end  
//      end  
//   end  
  
//   // Normalize result  
//   always @* begin  
//      if (mant_div[47]) begin  // If the most significant bit is 1, shift right  
//        mant_res = mant_div >> 1;  
//        exp_res = exp_res + 1;  
//      end else begin  // No need to shift  
//        mant_res = mant_div[45:23];  
//      end  
//   end  
  
//   // Construct the result  
//   assign result = {sign_res, exp_res, mant_res};  
  
//endmodule
//module divide(  
//   input [31:0] a,  // 32-bit input a (numerator)  
//   input [31:0] b,  // 32-bit input b (denominator)  
//   output [31:0] result  // 32-bit result  
//);  
  
//   // Extract fields  
//   wire sign_a = a[31];  
//   wire sign_b = b[31];  
//   wire [7:0] exp_a = a[30:23];  
//   wire [7:0] exp_b = b[30:23];  
//   wire [23:0] mant_a = {1'b1, a[22:0]};  
//   wire [23:0] mant_b = {1'b1, b[22:0]};  
  
//   // Variables for division  
//   reg [47:0] mant_div;  
//   reg sign_res;  
//   reg [7:0] exp_res;  
//   reg [22:0] mant_res;  
//   integer i;  
  
//   // Assign sign  
//   always @* begin  
//      sign_res = sign_a ^ sign_b;  
//   end  
  
//   // Align exponents  
//   always @* begin  
//      exp_res = exp_a - exp_b + 8'd127;   
//   end  
  
//   // Divide mantissas using a shift and subtract algorithm  
//   always @* begin  
//      mant_div = mant_a;  
//      for (i = 0; i < 24; i=i+1) begin  
//        if (mant_div >= mant_b) begin  
//           mant_div = mant_div - mant_b;  
//           mant_res[i] = 1'b1;  
//        end else begin  
//           mant_div = mant_div << 1;  
//           mant_res[i] = 1'b0;  
//        end  
//      end  
//   end  
  
//   // Normalize result  
//   always @* begin  
//      if (mant_div[47]) begin  // If the most significant bit is 1, shift right  
//        mant_res = mant_div >> 1;  
//        exp_res = exp_res + 1;  
//      end else begin  // No need to shift  
//        mant_res = mant_div[45:23];  
//      end  
//   end  
  
//   // Construct the result  
//   assign result = {sign_res, exp_res, mant_res};  
  
//endmodule

//module divide (
//    input  [31:0] a,        // Input floating-point number a
//    input  [31:0] b,        // Input floating-point number b
//    output reg [31:0] result    // Output floating-point result
//);

//    // Extract sign, exponent, and mantissa
//    wire sign_a = a[31];
//    wire sign_b = b[31];
//    wire [7:0] exp_a = a[30:23]; 
//    wire [7:0] exp_b = b[30:23];
//    wire [23:0] mant_a = (exp_a == 8'd0) ? {1'b0, a[22:0]} : {1'b1, a[22:0]};
//    wire [23:0] mant_b = (exp_b == 8'd0) ? {1'b0, b[22:0]} : {1'b1, b[22:0]};
    
//    reg  sign_result; 
//    reg  [7:0] exp_result;
//    reg  [47:0] mant_result; // 24-bit mantissa / 24-bit mantissa gives a 24-bit quotient
//    reg  [22:0] mant_final;
    
//    always @(*) begin
//        // Sign
//        sign_result = sign_a ^ sign_b;
        
//        // Handle special cases like division by zero, NaN, and infinity
//        if (b == 32'b0) begin
//            // Division by zero
//       result = {sign_result, 8'hFF, 23'b0}; // Infinity
//        end else if (a == 32'b0) begin
//            // Zero divided by any number
//            result = {sign_result, 31'b0}; // Zero
//        end else begin
//            // Exponent
//            exp_result = exp_a - exp_b + 8'd127;
            
//            // Mantissa division
//            mant_result = {mant_a, 24'b0} / mant_b;
            
//            // Normalize the result
//            if (mant_result[23] == 1) begin
//                mant_final = mant_result[22:0];
//            end else begin
//                mant_final = mant_result[22:1];
//                exp_result = exp_result - 1;
//            end
            
//            // Assemble the result
//            result = {sign_result, exp_result, mant_final};
//        end
//    end
//endmodule

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