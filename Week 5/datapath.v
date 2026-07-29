`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 03:39:40 PM
// Design Name: 
// Module Name: datapath
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


module datapath(
    input clk, rst, 
    output [31:0] pc_out, instr, imm, reg_rd1, reg_rd2, ALUResult,
    output [6:0] opcode, funct7, 
    output [4:0] rd, rs1, rs2,
    output [2:0] funct3,
    output RegWrite, Zero
    );
    
    wire PCSrc, ALUSrc, MemWrite, MemRead, Branch;
    wire [1:0] ResultSrc, ALUOp;
    wire [3:0] ALUSel;
    wire [31:0] SrcB, WriteData, dmem_rd, next_pc;
    
    assign SrcB = ALUSrc ? imm : reg_rd2;
    
    PC pc_inst(.clk(clk), .rst(rst), .pc_next(next_pc), .pc_out(pc_out));
    
    imem imem_inst(.address(pc_out), .instr(instr));
    
    decode decode_inst(.instr(instr), .opcode(opcode), .funct7(funct7), .rd(rd), 
    .rs1(rs1), .rs2(rs2), .funct3(funct3), .imm(imm));
    
    regFile reg_inst(.clk(clk), .we(RegWrite), .ra1(rs1), .ra2(rs2), .wa(rd), 
    .wd(WriteData), .rd1(reg_rd1), .rd2(reg_rd2));
    
    control contorl_inst(.opcode(opcode), .funct3(funct3), .funct7b5(instr[30]), 
    .zero(Zero), .PCSrc(PCSrc), .RegWrite(RegWrite), .ALUSrc(ALUSrc), .MemWrite(MemWrite),
    .MemRead(MemRead), .Branch(Branch), .ResultSrc(ResultSrc), .ALUOp(ALUOp));
    
    ALU alu_inst(.A(reg_rd1), .B(SrcB), .sel(ALUSel), .ALU_out(ALUResult), .Zero(Zero));
    
    ALUControl aluCon_inst(.funct7b5(instr[30]), .funct3(funct3), .ALUOp(ALUOp), .ALUSel(ALUSel));
    
    dmem dmem_inst(.clk(clk), .MemWrite(MemWrite), .address(ALUResult), .wd(reg_rd2), .rd(dmem_rd));
    
    assign WriteData = ResultSrc[0] ? dmem_rd : ALUResult;
    
    assign next_pc = PCSrc ? (pc_out + imm) : (pc_out + 32'd4);
    
endmodule
