`timescale 1ns/1ps

module pc_tb;
reg clk;
reg reset;
reg [31:0] next_pc;

wire [31:0] current_pc;

// Instantiate the PC
pc uut (
    .clk(clk),
    .reset(reset),
    .next_pc(next_pc),
    .current_pc(current_pc)
);

// Generate a clock with a 10 ns period
always #5 clk = ~clk;

initial begin

    // Initialize inputs
    clk = 1'b0;
    reset = 1'b1;
    next_pc = 32'd0;

    // Check reset
    #2;
    if (current_pc == 32'd0)
        $display("PASS: PC reset");
    else
        $display("FAIL: PC reset");

    // Release reset
    #3;
    reset = 1'b0;

    // Test first update
    next_pc = 32'd4;
    @(posedge clk);
    #1;
    if (current_pc == 32'd4)
        $display("PASS: PC updates to 4");
    else
        $display("FAIL: PC updates to 4");

    // Test second update
    next_pc = 32'd8;
    @(posedge clk);
    #1;
    if (current_pc == 32'd8)
        $display("PASS: PC updates to 8");
    else
        $display("FAIL: PC updates to 8");

    // Test jump to another address
    next_pc = 32'd100;
    @(posedge clk);
    #1;
    if (current_pc == 32'd100)
        $display("PASS: PC accepts a target address");
    else
        $display("FAIL: PC accepts a target address");

    $display("PC tests completed.");
    $finish;

end

endmodule
