`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/24/2026 03:43:28 PM
// Design Name: 
// Module Name: ALUControl
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


module ALUControl(
    input funct7b5, 
    input [2:0] funct3, 
    input [1:0] ALUOp,
    output reg [3:0] ALUSel
    );
    always @(*) begin
        case(ALUOp)
            2'b00: ALUSel = 4'b0000; 
            2'b01: ALUSel = 4'b0001; 
            2'b10: begin              
                case(funct3)
                    3'b000: 
                        if(funct7b5) ALUSel = 4'b0001;
                        else ALUSel = 4'b0000;
                    3'b001: ALUSel = 4'b0111;
                    3'b010: ALUSel = 4'b0101;
                    3'b011: ALUSel = 4'b0110;
                    3'b100: ALUSel = 4'b0100;
                    3'b101:
                        if(funct7b5) ALUSel = 4'b1001;
                        else ALUSel = 4'b1000;
                    3'b110: ALUSel = 4'b0011;
                    3'b111: ALUSel = 4'b0010;
                    default: ALUSel = 4'b0000;
                endcase
            end
            default: ALUSel = 4'b0000;
        endcase
    end
    
endmodule
