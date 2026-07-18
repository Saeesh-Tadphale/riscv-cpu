`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2026 05:22:48 PM
// Design Name: 
// Module Name: regFile
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


module regFile(
    input [4:0] ra1, ra2, //reading address
    input [4:0] wa, //write address
    input [31:0] wd, //write destination
    input we, clk, //write enable and clock signal
    output [31:0] rd1, rd2 //reading desitination
    );
    
    reg [31:0] regs [31:0];
    
    assign rd1 = (ra1 != 5'b0) ? regs[ra1] : 32'b0;
    assign rd2 = (ra2 != 5'b0) ? regs[ra2] : 32'b0;
    
    always @(posedge clk) begin
        if(we && wa != 5'b0)
            regs[wa] <= wd;
    end
        
endmodule
