`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2026 08:41:48 PM
// Design Name: 
// Module Name: imem
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

module imem(
    input [31:0] address,
    output [31:0] instr
    );
    
    reg [31:0] mem [0:63];
    integer i;
    assign instr = mem[address[7:2]];
    
    initial begin 
        for(i = 0; i < 64; i = i + 1)
            mem[i] = 32'h00000013;
            
        mem[0] = 32'h00100093; 
        mem[1] = 32'h00208133;
        mem[2] = 32'h00100093;
    end
    
endmodule
