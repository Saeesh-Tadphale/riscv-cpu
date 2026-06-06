`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2026 05:32:09 PM
// Design Name: 
// Module Name: reg_TB
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


module reg_TB;

    //inputs
    reg [4:0] ra1;
    reg [4:0] ra2;
    reg [4:0] wa;
    reg [31:0] wd;
    reg  we;
    reg  clk;
    
    //outputs
    wire [31:0] rd1;
    wire [31:0] rd2;
    
    integer i;
    
    initial clk = 0; 
    always #5 clk = ~clk;
    
    regFile tb(.ra1(ra1), .ra2(ra2), .wa(wa), .wd(wd), .we(we), .clk(clk), .rd1(rd1), .rd2(rd2));
    
    //Tests
    initial begin
    
    //Basic Read Write Tests
    $display("Baisc Read and Write Tests.");
    
    //Test 1: write 42 onto x1 and read it back. 
    we = 1; wa = 5'd1; wd = 32'd42;
    @(posedge clk); #1;
    we = 0; ra1 = 5'd1; #10;
    $display("TEST 1: write 42 to x1. Expected: 42. Got: %0d", rd1);
    
    //Test 2: write different values for x1 and x2, verrify they dont intefere with eachother
    we = 1; wa = 5'd1; wd = 32'd100;
    @(posedge clk); #1;
    we = 1; wa = 5'd2; wd = 32'd200;
    @(posedge clk); #1;
    we = 0;
    ra1 = 5'd1; ra2 = 5'd2; #10;
    $display("TEST 2a: x1 independent of x2. Expected: 100. Got: %0d", rd1);
    $display("TEST 2b: x2 independent of x1. Expected: 200. Got: %0d", rd2);
    
    //x0 Hardwired rule
    $display("Group 2: x0 hardwired to 0.");
    
    //Test 3: read x0 without writing
    ra1 = 5'd0; #10;
    $display("TEST 3: read x0 unwritten. Expected: 0. Got: %0d", rd1);
    
    //Test 4: write 999 to x0
    we = 1; wa = 5'd0; wd = 32'd999;
    @(posedge clk); #1
    we = 0; ra1 = 5'd0; #10
    $display("TEST 4: write 999 to x0. Expected 0, Got: %0d", rd1);
    
    //TEST 5: x0 on ra3 while reading from the real register on ra1
    ra1 = 5'd1; ra2 = 5'd0; #10
    $display("TEST 5a: x1 while ra2 = x0. Expected 100, Got: %0d", rd1);
    $display("TEST 5b: rd2 while ra2 = x0. Expected 0, Got: %0d", rd2);
    
    //Group 3: Write Enable
    $display("Group 3: Write Enable");
    
    //TEST 6: Write Enable = 0, write ignored
    we = 0; wa = 5'd3; wd =32'd999;
    @(posedge clk); #1
    ra1 = 5'd3; #10
    $display("Test 6: we = 0, write ignored. Expected: 0, Got: %0d", rd1);
    
    //TEST 7: Write Enabled = 1, write succedes. Then gets write gets disabled, value should stay the same.
    we = 1; wa = 5'd3; wd = 32'd77;
    @(posedge clk); #1
    we = 0; ra1 = 5'd3; #10
    $display("TEST 7a: we = 1, write succeeds. Expected: 77, Got: %0d", rd1);
    we = 0; wa = 5'd3; wd = 32'd999;
    @(posedge clk); #1
    ra1 = 5'd3; #10
    $display("TEST 7b: we = 0, value persists. Expected: 77, Got %0d", rd1);
    
    //Group 4: Simltaneous Dual Read
    $display("Group 4: Simltaneous Dual Read");
    
    //TEST 8: write to x5 and x12, read both simltaneously
    we = 1; wa = 5'd5; wd = 32'd55;
    @(posedge clk); #1 
    wa = 5'd12; wd = 5'd120;
    @(posedge clk); #1
    we = 0;
    ra1 = 5'd5; ra2 = 5'd12; #10
    $display("TEST 8a: dual read x5. Expected: 55, Got: %0d", rd1);
    $display("TEST 8b: dual read x12. Expected: 120, Got: %0d", rd2);
    
    //TEST 9: ra1 and ra2 point to same register
    ra1 = 5'd5; ra2 = 5'd5; #10
    $display("TEST 9: ra1 = ra2 = x5. Expected: 55, Got rd1: %0d, Got rd2: %0d", rd1, rd2);
    
    //Group 5: All 31 Registers Using a Loop
    $display("Group 5: All 31 Registers Using a Loop");
    
    //populating registers
    we = 1;
    for(i = 1; i < 32; i = i + 1)begin
        wa = i; wd = i*10;
        @(posedge clk); #1;
    end
    we = 0;
    
    for(i = 1; i < 32; i = i + 1)begin 
        ra1 = i; #10
        $display("TEST 10: x%0d = %0d (expected %0d) %s", i, rd1, i*10, (rd1 == i*10) ? "PASS" : "FAIL");
    end
    
    //Group 6: Boundary Adresses
    $display("Group 6: Boundary Adresses");
    
    //TEST 11: write to x1
    we = 1; wa = 5'd1; wd = 32'd111;
    @(posedge clk); #1
    we = 0; ra1 = 5'd1; #10
    $display("TEST 11: x1, lowest possible writable address. Expected: 111, Got: %0d", rd1);
    
    //TEST 12: write to x31
    we = 1; wa = 5'd31; wd = 32'd311;
    @(posedge clk); #1
    we = 0; ra1 = 5'd31; #10
    $display("TEST 12: x31, highest possible writable address. Expected: 311, Got: %0d", rd1);
    
    //Group 7: Edge Case Data Values
    $display("Group 7: Edge Case Data Values");
    
    //TEST 13: all zeros
    we = 1; wa =5'd8; wd = 32'h00000000;
    @(posedge clk)#1
    we = 0; ra1 = 5'd8; #10
    $display("TEST 13: All zeros. Expected: 00000000, Got: %h", rd1);
    
    //TEST 14: all ones
    we = 1; wa =5'd9; wd = 32'hFFFFFFFF;
    @(posedge clk)#1
    we = 0; ra1 = 5'd9; #10
    $display("TEST 14: All ones. Expected: ffffffff, Got: %h", rd1);
    
    //TEST 15: Only MSB set
    we = 1; wa =5'd10; wd = 32'h80000000;
    @(posedge clk)#1
    we = 0; ra1 = 5'd10; #10
    $display("TEST 15: Only MSB. Expected: 80000000, Got: %h", rd1);
    
    //TEST 16: Only LSB set
    we = 1; wa =5'd11; wd = 32'h00000001;
    @(posedge clk)#1
    we = 0; ra1 = 5'd11; #10
    $display("TEST 13: ONly LSB. Expected: 00000001, Got: %h", rd1);
    
    $display("All Tests complete.");
    $finish;
    end
endmodule
