`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2026 08:37:58 PM
// Design Name: 
// Module Name: PC
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


module PC(
    input clk, rst, 
    output [31:0] pc_out
    );
    
    wire [31:0] pc_next; 
    
    assign pc_next = pc_out + 32'd4;
    
    fourbit_reg #(32) pc_reg(
        .clk(clk),
        .rst(rst),
        .en(1'b1), 
        .d(pc_next), 
        .q(pc_out)
    );
endmodule
