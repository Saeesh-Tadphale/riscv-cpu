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
    output [31:0] pc_out, instr, imm, reg_rd1, reg_rd2,
    output [6:0] opcode, funct7, 
    output [4:0] rd, rs1, rs2,
    output [2:0] funct3
    );
    
    PC pc_inst(.clk(clk), .rst(rst), .pc_out(pc_out));
    imem imem_inst(.address(pc_out), .instr(instr));
    decode decode_inst(.instr(instr), .opcode(opcode), .funct7(funct7), .rd(rd), .rs1(rs1), .rs2(rs2), .funct3(funct3), .imm(imm));
    regFile reg_inst(.clk(clk), .we(1'b0), .ra1(rs1), .ra2(rs2), .wa(5'b0), .wd(32'b0), .rd1(reg_rd1), .rd2(reg_rd2));
endmodule
