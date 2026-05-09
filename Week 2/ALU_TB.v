`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2026 02:44:46 PM
// Design Name: 
// Module Name: ALU_TB
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


module ALU_TB;
    //inputs
    reg [31:0] A; 
    reg [31:0] B;
    reg [3:0] sel;
    
    //outputs
    wire [31:0] ALU_out;
    wire Zero;
    
    //Instatiating the ALU
    ALU tb(.A(A), .B(B), .sel(sel), .ALU_out(ALU_out), .Zero(Zero));
    
    //Tests
    initial begin
        //ADDITION TESTS 
        sel = 4'b0000;
        
        //TEST 1: 5 + 3 = 8
        A = 32'd5; B = 32'd3;
        #10
        $display("TEST 1: 5 + 3, Expected: 8. Got: %0d", ALU_out);
        
        //TEST 2: 0 + 0 = 0, Zero flag high
        A = 32'd0; B = 32'd0;
        #10
        $display("TEST 2: 0 + 0, Expected: 0. Got: %0d, Zero: %b", ALU_out, Zero);
        
        //TEST 3: 0xFFFFFFFF + 1 = 0, overflow wraps around, Zero flag high
        A = 32'hFFFFFFFF; B = 32'd1;
        #10
        $display("TEST 3: 0xFFFFFFFF + 1, Expected: 0. Got: %h, Zero: %b", ALU_out, Zero);
        
        //TEST 4: 400 + 1000 = 1400, large number addition
        A = 32'd400; B = 32'd1000;
        #10
        $display("TEST 4: 400 + 1000, Expected: 1400. Got: %0d", ALU_out);
        
        //SUBTRACTION TESTS
        sel = 4'b0001;
        
        //TEST 5: 10 - 3 = 7
        A = 32'd10; B = 32'd3;
        #10
        $display("TEST 5: 10 - 3, Expected: 7. Got: %0d", ALU_out);
        
        //TEST 6: 5 - 5 = 0, Zero flag high
        A = 32'd5; B = 32'd5;
        #10
        $display("TEST 6: 5 - 5, Expected: 0. Got: %0d, Zero: %b", ALU_out, Zero);
        
        //TEST 7: 3 - 10 = -7, result is negative, check 2's complement
        A = 32'd3; B = 32'd10;
        #10
        $display("TEST 7: 3 - 10, Expected: -7. Got: %d", ALU_out);
        
        //TEST 8: 0 - 1 = 0xFFFFFFFF, undeflow
        A = 32'd0; B = 32'd1;
        #10
        $display("TEST 8: 0 - 1, Expected: 0xFFFFFFFF. Got: %0d", ALU_out);
        
        //AND TESTS
        sel = 4'b0010;
        
        //TEST 9: 0xF0F0F0F0 & 0x0F0F0F0F = 0, no overlap
        A = 32'hF0F0F0F0; B = 32'h0F0F0F0F;
        #10
        $display("TEST 9: 0xF0F0F0F0 & 0x0F0F0F0F = 0, Expected: 0. Got: %0d, Zero: %b", ALU_out, Zero);
        
        //TEST 10: 0xFFFFFFFF & 0xFFFFFFFF = 0xFFFFFFFF, all ones
        A = 32'hFFFFFFFF; B = 32'hFFFFFFFF;
        #10
        $display("TEST 10: 0xFFFFFFFF & 0xFFFFFFFF, Expected: 0xFFFFFFFF. Got: %0h", ALU_out);
        
        //TEST 11: 0xAAAAAAAA & 0x55555555 = 0, alternating bits
        A = 32'hAAAAAAAA; B = 32'h55555555;
        #10
        $display("TEST 11: 0xAAAAAAAA & 0x55555555, Expected: 0. Got: %d, Zero: %b", ALU_out, Zero);
        
        //OR TESTS
        sel = 4'b0011;
        
        //TEST 12: 0xF0F0F0F0 | 0x0F0F0F0F = 0xFFFFFFFF 
        A = 32'hF0F0F0F0; B = 32'h0F0F0F0F;
        #10
        $display("TEST 12: 0xF0F0F0F0 | 0x0F0F0F0F, Expected: 0xFFFFFFFF. Got: %0h", ALU_out);
        
        //TEST 13: 0 | 0 = 0, Zero flag high
        A = 32'd0; B = 32'd0;
        #10
        $display("TEST 13: 0 | 0, Expected: 0. Got: %0d, Zero: %b", ALU_out, Zero);
        
        //TEST 14: 0xAAAAAAAA | 0x55555555 = 0xFFFFFFFF
        A = 32'hAAAAAAAA; B = 32'h55555555;
        #10
        $display("TEST 14: 0xAAAAAAAA | 0x55555555, Expected: 0xFFFFFFFF. Got: %h", ALU_out);
        
        //XOR TESTS
        sel = 4'b0100;
        
        //TEST 15: 0xFFFFFFFF ^ 0xFFFFFFFF = 0
        A = 32'hFFFFFFFF; B = 32'hFFFFFFFF;
        #10
        $display("TEST 15: 0xFFFFFFFF ^ 0xFFFFFFFF, Expected: 0. Got: %0h, Zero: %b", ALU_out, Zero);
        
        //TEST 16: 0xAAAAAAAA ^ 0x55555555 = 0xFFFFFFFF
        A = 32'hAAAAAAAA; B = 32'h55555555;
        #10
        $display("TEST 16: 0xAAAAAAAA ^ 0x55555555, Expected: 0xFFFFFFFF. Got: %h", ALU_out);
        
        //TEST 17: 0xFFFFFFFF + 1 = 0, overflow wraps around, Zero flag high
        A = 32'hFFFFFFFF; B = 32'd1;
        #10
        $display("TEST 17: 0xFFFFFFFF + 1, Expected: 0. Got: %h", ALU_out);
        
        //SLT TESTS
        sel = 4'b0101;//start here
        
        //TEST 18: -1 < 1 → result = 1, negative vs postive
        A = -32'd1; B = 32'd1;
        #10
        $display("TEST 18: -1 < 1, Expected: 1. Got: %0d", ALU_out);
        
        //TEST 19: 1 < -1, result = 0, positive vs negative
        A = 32'd1; B = -32'd1;
        #10
        $display("TEST 19: 1 < -1, Expected: 0. Got: %0d", ALU_out);
        
        //TEST 20: 5 < 5 → result = 0, equal
        A = 32'd5; B = 32'd5;
        #10
        $display("TEST 20: 5 < 5, Expected: 0. Got: %h", ALU_out);
        
        //TEST 21: -5 < -3 → result = 1, both negative
        A = -32'd5; B = -32'd3;
        #10
        $display("TEST 21: -5 < -3, Expected: 1. Got: %0d", ALU_out);
        
        //SLTU UNSIGNED TESTS
        sel = 4'b0110;
        
        //TEST 22: 0xFFFFFFFF < 1 → result = 0, wrong if numbers were signed
        A = 32'hFFFFFFFF; B = 32'd1;
        #10
        $display("TEST 22: 0xFFFFFFFF < 1, Expected: 0. Got: %0d", ALU_out);
        
        //TEST 23: 1 < 0xFFFFFFFF → result = 1
        A = 32'd1; B = 32'hFFFFFFFF;
        #10
        $display("TEST 23: 1 < 0xFFFFFFFF, Expected: 1. Got: %0d", ALU_out);
        
        //TEST 24: 5 < 5 → result = 0, equal
        A = 32'd5; B = 32'd5;
        #10
        $display("TEST 24: 5 < 5, Expected: 0. Got: %d", ALU_out);
        
        //SLL TESTS
        sel = 4'b0111;
        
        //TEST 25: 1 << 1 = 2
        A = 32'd1; B = 32'd1;
        #10
        $display("TEST 25: 1 << 1, Expected: 2. Got: %0d", ALU_out);
        
        //TEST 26: 1 << 31 = 0x80000000, shift to sign bit
        A = 32'd1; B = 32'd31;
        #10
        $display("TEST 26: 1 << 31, Expected: 0x80000000. Got: %0h", ALU_out);
        
        //TEST 27: 0xFFFFFFFF << 1 = 0xFFFFFFFE, drops most significant bit
        A = 32'hFFFFFFFF; B = 32'd1;
        #10
        $display("TEST 27: 0xFFFFFFFF << 1, Expected: 0xFFFFFFFE. Got: %0h", ALU_out);
        
        //TEST 28: 1 << 0 = 1
        A = 32'd1; B = 32'd0;
        #10
        $display("TEST 28: 1 << 0, Expected: 1. Got: %0d", ALU_out);
        
        //SRL TESTS
        sel = 4'b1000;
        
        //TEST 29: 0x80000000 >> 1 = 0x40000000, fills with zero
        A = 32'h80000000; B = 32'd1;
        #10
        $display("TEST 29: 0x80000000 >> 1, Expected: 0x40000000. Got: %0h", ALU_out);
        
        //TEST 30: 0xFFFFFFFF >> 1 = 0x7FFFFFFF, most significant bit becomes 0
        A = 32'hFFFFFFFF; B = 32'd1;
        #10
        $display("TEST 30: 0xFFFFFFFF >> 1, Expected: 0x7FFFFFFF. Got: %0h", ALU_out);
        
        //TEST 31: 4 >> 2 = 1
        A = 32'd4; B = 32'd2;
        #10
        $display("TEST 31: 4 >> 2, Expected: 1. Got: %d", ALU_out);
        
        //TEST 32: 1 >> 0 = 1, shift by 0
        A = 32'd1; B = 32'd0;
        #10
        $display("TEST 32: 1 >> 0, Expected: 1. Got: %0d", ALU_out);
        
        //SRA TESTS
        sel = 4'b1001;
        
        //TEST 33: 0x80000000 >>> 1 = 0xC0000000, fills with 1 because of negative
        A = 32'h80000000; B = 32'd1;
        #10
        $display("TEST 33: 0x80000000 >>> 1, Expected: 0xC0000000. Got: %0h", ALU_out);
        
        //TEST 34: 0x7FFFFFFF >>> 1 = 0x3FFFFFFF, fills with 0 because of positive
        A = 32'h7FFFFFFF; B = 32'd1;
        #10
        $display("TEST 34: 0x7FFFFFFF >>> 1, Expected: 0x3FFFFFFF. Got: %0h", ALU_out);
        
        //TEST 35: -8 >>> 2 = -2 , shifts right to preserve sign
        A = -32'd8; B = 32'd2;
        #10
        $display("TEST 35: -8 >>> 2, Expected: -2. Got: %0d", ALU_out);
        
        //TEST 36: 4 >>> 0 = 4, shift by 0
        A = 32'd4; B = 32'd0;
        #10
        $display("TEST 36: 4 >>> 0, Expected: 4. Got: %0d", ALU_out);
        
        $display("All tests complete.");
        $finish();
    end
endmodule
