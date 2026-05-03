`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2026 05:02:27 PM
// Design Name: 
// Module Name: fourBit_reg_tb
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


module fourBit_reg_tb;
    //inputs for TB
    reg clk;
    reg rst;
    reg en;
    reg [3:0] d; 
    
    //Output being observed by the TB
    wire [3:0] q; 
    
    //Instatiating the register
    fourbit_reg reg1 (.clk(clk), .en(en), .rst(rst), .d(d), .q(q));
    
    initial clk = 0;//start clk signal at 0
    always #5 clk = ~clk;//every 5ns make the value of the clk to its opposite, so if at 5ns clk = 1, clk now equals 0
    
    //Testing
    initial begin
        rst = 1; en = 0; d = 4'b0000; //setting initial values

        @(posedge clk); #1;//this waits till the next rising clock edge and then waits another ns. Makes sure TB is synchronized to the clk
        @(posedge clk); #1;
        rst = 0;
        //Test 1, enable off so register stores no memory
        en = 0; d = 4'b0011;
        @(posedge clk); #1;
        $display("Test 1: enable off so no memory stored. Expected: 0000. Got %b" , q);
        
        //Test 2, enable on, so register stores memory
        en = 1; d = 4'b0011;
        @(posedge clk); #1;
        $display("Test 2: enable on so memory is stored. Expected: 0011. Got %b", q);
        
        //Test 3, enable on, store 1010
        en = 1; d = 4'b1010;
        @(posedge clk); #1;
        $display("Test 3: enable on so memory is stored. Expected: 1010. Got %b", q);
        
        //Test 4, enable on, store 1110
        en = 1; d = 4'b1110;
        @(posedge clk); #1;
        $display("Test 4: enable on so memory is stored. Expected: 1110. Got %b", q);
        
        //Test 5, reset while enabled
        rst = 1; en = 1; d = 4'b0011;
        @(posedge clk); #1;
        $display("Test 5: enable on so memory is stored. Expected: 0000. Got %b", q);
        
        $display("Simulation complete!");
        $finish;
    end
    
endmodule
