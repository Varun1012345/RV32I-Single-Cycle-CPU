`timescale 1ns/1ps

module rv32i_single_cycle_tb;

    reg clk;
    reg reset;

    // Instantiate the CPU
    rv32i_single_cycle dut (
        .clk(clk),
        .reset(reset)
    );

    // Clock: 10 ns period
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Apply reset and run the CPU
    initial begin
    reset = 1'b1;

    #12;
    reset = 1'b0;

    // Execute six instructions
    repeat (4) @(posedge clk);

    #1;

    $display("------ JALR VERIFICATION ------");

$display("x1 = %0d", dut.registers.registers[1]);
$display("x2 = %0d", dut.registers.registers[2]);
$display("x3 = %0d", dut.registers.registers[3]);

if (dut.registers.registers[1] == 24 &&
    dut.registers.registers[2] == 12 &&
    dut.registers.registers[3] == 5 &&
    dut.registers.registers[4] == 42) begin
    $display("PASS: JALR verification successful.");
end
else begin
    $display("FAIL: JALR verification failed.");
end

    $finish;
end

endmodule
