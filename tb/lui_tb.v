module lui_tb;

    reg clk;
    reg reset;

    rv32i_single_cycle dut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        reset = 1;

        #10;
        reset = 0;

        // Execute LUI instruction
        dut.instr_mem.memory[0] = 32'h123450B7;
        // LUI x1, 0x12345

        repeat (2) @(posedge clk);
        #1;

        if (dut.registers.registers[1] == 32'h12345000)
            $display("PASS: LUI instruction working correctly");
        else
            $display("FAIL: Expected 12345000, Got %h",
                     dut.registers.registers[1]);

        $finish;

    end

endmodule