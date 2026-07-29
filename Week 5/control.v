`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2026 04:50:00 PM
// Design Name: 
// Module Name: control
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


module control(
    input [6:0] opcode,
    input [2:0] funct3,
    input funct7b5,//only 5 bits to distinguish between add vs sub
    input zero,
    output PCSrc,
    output reg RegWrite, ALUSrc, MemWrite, MemRead, Branch,
    output reg [1:0] ResultSrc, ALUOp
);
    
    assign PCSrc = Branch && zero;
    always @(*) begin
        case(opcode)
            7'b0110011: begin
                RegWrite = 1;
                ALUSrc = 0; 
                MemWrite = 0;
                MemRead = 0;
                ResultSrc = 2'b00;
                ALUOp = 2'b10;
                Branch = 0;
            end
            7'b0010011: begin
                RegWrite = 1;
                ALUSrc = 1; 
                MemWrite = 0;
                MemRead = 0;
                ResultSrc = 2'b00;
                ALUOp = 2'b10;               
                Branch = 0;
            end
            7'b0000011: begin
                RegWrite = 1;
                ALUSrc = 1; 
                MemWrite = 0;
                MemRead = 1;
                ResultSrc = 2'b01;
                ALUOp = 2'b00;              
                Branch = 0;
            end
            7'b0100011: begin
                RegWrite = 0;
                ALUSrc = 1; 
                MemWrite = 1;
                MemRead = 0;
                ResultSrc = 2'b00;
                ALUOp = 2'b00;               
                Branch = 0;
            end
            7'b1100011: begin
                RegWrite = 0;
                ALUSrc = 0; 
                MemWrite = 0;
                MemRead = 0;
                ResultSrc = 2'b00;
                ALUOp = 2'b01;
                Branch = 1;
            end
            default: begin
                RegWrite = 0;
                ALUSrc = 0; 
                MemWrite = 0;
                MemRead = 0;
                ResultSrc = 2'b00;
                ALUOp = 2'b00;                
                Branch = 0;
            end
       endcase
    end
    
endmodule
