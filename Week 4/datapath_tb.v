`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 04:07:01 PM
// Design Name: 
// Module Name: datapath_tb
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


module datapath_tb;
    reg clk, rst;
    wire [31:0] pc_out, instr, imm, reg_rd1, reg_rd2;
    wire [6:0] opcode, funct7;
    wire [4:0] rd, rs1, rs2;
    wire [2:0] funct3;
    
    datapath tb(.clk(clk), .rst(rst), 
    .pc_out(pc_out), .instr(instr), .imm(imm), .reg_rd1(reg_rd1),.reg_rd2(reg_rd2),
    .opcode(opcode), .funct7(funct7),
    .rd(rd), .rs1(rs1), .rs2(rs2),
    .funct3(funct3));

    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        //assert reset for first two cycles
        rst = 1;
        @(posedge clk); #1;
        @(posedge clk); #1;
        rst = 0; #1;
        $display("PC = %h, Instr = %h, OP = %b, Rd = %d, Rs1 = %d, Rs2 = %d, Imm = %d",
                pc_out, instr, opcode, rd, rs1, rs2, imm);
        //run for eight cycles and check outputs
        repeat(8) begin
            @(posedge clk); #1;
                $display("PC = %h, Instr = %h, OP = %b, Rd = %d, Rs1 = %d, Rs2 = %d, Imm = %d",
                pc_out, instr, opcode, rd, rs1, rs2, imm);
            end
        $finish;
   end
endmodule
