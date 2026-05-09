`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2026 07:06:43 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] A, 
    input [31:0] B, 
    input [3:0] sel,
    output [31:0] ALU_out,
    output Zero
    );
    reg [31:0] result;
    assign ALU_out = result;
    
    assign Zero = (result == 32'b0);
    
    always @(*)
    begin
        case(sel)
        4'b0000://add
            result = A + B;
        4'b0001://subtract
            result = A - B;
        4'b0010://AND
            result = A & B;
        4'b0011://OR
            result = A | B;
        4'b0100://XOR
            result = A ^ B;
        4'b0101://set less than, signed
            result = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;
        4'b0110:// set less than, unsigned
            result =(A < B) ? 32'd1 : 32'd0;
        4'b0111://shift left logical
            result = A << B[4:0];    
        4'b1000://shift right logical
            result = A >> B[4:0];
        4'b1001://shift right arthimitic
            result = $signed(A) >>> B[4:0];  
        default 
            result = 32'bx;       
        endcase  
    end
endmodule
