`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 02:58:17 PM
// Design Name: 
// Module Name: decode
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


module decode(
    input [31:0] instr, 
    output [6:0] opcode, funct7,
    output [4:0] rd, rs1, rs2, 
    output [2:0] funct3, 
    output reg [31:0] imm
    );
    
    assign opcode = instr[6:0];
    assign rd = instr[11:7];
    assign funct3 = instr[14:12];
    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign funct7 = instr[31:25];
    
    always @(*) begin
        case(opcode)
            //I-Type
            7'b0010011: imm = {{20{instr[31]}}, instr[31:20]};//arithmitic
            7'b0000011: imm = {{20{instr[31]}}, instr[31:20]};//load
            7'b1100111: imm = {{20{instr[31]}}, instr[31:20]};//JALR
            //S-type
            7'b0100011: imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};//store
            //B-Type
            7'b1100011: imm = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};//branch
            //U-Type
            7'b0110111: imm = {instr[31:12], 12'b0};//load upper immediate
            7'b0010111: imm = {instr[31:12], 12'b0};//add upper immeadiate to PC
            //J-Type
            7'b1101111: imm = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};//jump and link
            default: imm = 32'b0;
        endcase
    end
endmodule
