`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2026 03:48:56 PM
// Design Name: 
// Module Name: firstProj
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


module and_or_gates(
    input  [15:0] sw,   // 16 switches
    output [15:0] led   // 16 LEDs
    );
    //AND Gates
    assign led[0]  = sw[0]  & sw[1];
    assign led[1]  = sw[2]  & sw[3];
    assign led[2]  = sw[4]  & sw[5];
    assign led[3]  = sw[6]  & sw[7];
    assign led[4]  = sw[8]  & sw[9];
    assign led[5]  = sw[10] & sw[11];
    assign led[6]  = sw[12] & sw[13];
    assign led[7]  = sw[14] & sw[15];
    
    //OR Gates
    assign led[8]  = sw[0]  | sw[1];
    assign led[9]  = sw[2]  | sw[3];
    assign led[10] = sw[4]  | sw[5];
    assign led[11] = sw[6]  | sw[7];
    assign led[12] = sw[8]  | sw[9];
    assign led[13] = sw[10] | sw[11];
    assign led[14] = sw[12] | sw[13];
    assign led[15] = sw[14] | sw[15];

endmodule
