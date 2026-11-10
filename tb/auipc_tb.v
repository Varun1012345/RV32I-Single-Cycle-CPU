module auipc_tb;

    reg clk;
    reg reset;

    rv32i_single_cycle dut (
        .clk(clk),
        .reset(reset)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        // Program instructions
        dut.instr_mem.memory[0] = 32'h00000013; // NOP
        dut.instr_mem.memory[1] = 32'h00000013; // NOP
        dut.instr_mem.memory[2] = 32'h12345297; // AUIPC x5, 0x12345

        #10;
        reset = 0;

        // Wait for AUIPC to execute
        repeat (3) @(posedge clk);
        #1;

        // Expected: PC + immediate = 8 + 0x12345000
        if (dut.registers.registers[5] == 32'h12345008)
            $display("AUIPC TEST PASSED");
        else begin
            $display("AUIPC TEST FAILED");
            $display("Expected: 0x12345008");
            $display("Actual:   %h", dut.registers.registers[5]);
        end

        $finish;
    end

endmodule