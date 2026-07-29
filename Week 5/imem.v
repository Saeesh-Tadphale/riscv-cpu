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
            
        mem[0] = 32'h00500093; 
        mem[1] = 32'h00300113; 
        mem[2] = 32'h002081B3; 
        mem[3] = 32'h0031A023; 
        mem[4] = 32'h0001A203; 
    end
    
endmodule
