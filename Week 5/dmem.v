`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2026 04:24:28 PM
// Design Name: 
// Module Name: dmem
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


module dmem(
    input clk, MemWrite, 
    input [31:0] address, wd,
    output [31:0] rd
    );
    
    reg [31:0] mem [63:0];
    integer i;
    assign rd = mem[address[7:2]];
    
    always @(posedge clk) begin
        if(MemWrite)
            mem[address[7:2]] <= wd;
    end 
    
    initial begin  
        for(i = 0; i < 64; i = i + 1)
            mem[i] = 32'h00000000; 
    end
    
endmodule
