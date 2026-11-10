`timescale 1ns/1ps

module instruction_memory_tb;

reg [31:0] address;
wire [31:0] instruction;

// Instantiate instruction memory
instruction_memory uut (
    .address(address),
    .instruction(instruction)
);

initial begin

    // Test 1: First instruction
    address = 32'h00000000;
    #10;

    if (instruction == 32'h00A00093)
        $display("PASS: Instruction at address 0x00");
    else
        $display("FAIL: Instruction at address 0x00");

    // Test 2: Second instruction
    address = 32'h00000004;
    #10;

    if (instruction == 32'h01400113)
        $display("PASS: Instruction at address 0x04");
    else
        $display("FAIL: Instruction at address 0x04");

    // Test 3: Third instruction
    address = 32'h00000008;
    #10;

    if (instruction == 32'h002081B3)
        $display("PASS: Instruction at address 0x08");
    else
        $display("FAIL: Instruction at address 0x08");

    // Test 4: Fourth instruction
    address = 32'h0000000C;
    #10;

    if (instruction == 32'h40110233)
        $display("PASS: Instruction at address 0x0C");
    else
        $display("FAIL: Instruction at address 0x0C");

    $display("Instruction memory tests completed.");
    $finish;

end

endmodule
