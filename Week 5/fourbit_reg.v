`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2026 04:27:21 PM
// Design Name: 
// Module Name: fourbit_reg
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

//since this is using parameters, i could just change the name of this module to register.
module fourbit_reg #(parameter N = 4)(//N represents the number of registers for this instance, using this i can make any number of bit registers just by calling this module and changing the parameter. ex fourbit_reg(32) my_reg (.....)
    input clk,en, rst,
    input [N - 1:0] d,
    output [N - 1:0] q
    );
    
    reg [N - 1:0] q;
 
    always @(posedge clk) begin
        if (rst)       
            q <= {N{1'b0}};//does the same thing as q <= 4'b0000 as it replicates 1'b0 N times, where N is 4 in this case 
        else if (en)    
            q <= d;
    end
    
endmodule
