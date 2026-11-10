module full_cpu_tb;

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

        // --------------------------------
        // Initialize instruction memory
        // --------------------------------

        dut.instr_mem.memory[0]  = 32'h00500093; // ADDI x1,x0,5
        dut.instr_mem.memory[1]  = 32'h00308113; // ADDI x2,x1,3
        dut.instr_mem.memory[2]  = 32'h002081B3; // ADD x3,x1,x2
        dut.instr_mem.memory[3]  = 32'h40208233; // SUB x4,x1,x2
        dut.instr_mem.memory[4]  = 32'h00402023; // SW x4,0(x0)
        dut.instr_mem.memory[5]  = 32'h00002283; // LW x5,0(x0)

        dut.instr_mem.memory[6]  = 32'h00528463; // BEQ x5,x5,+8
        dut.instr_mem.memory[7]  = 32'h06300313; // ADDI x6,x0,99 (skipped)

        dut.instr_mem.memory[8]  = 32'h000013B7; // LUI x7,1
        dut.instr_mem.memory[9]  = 32'h00000417; // AUIPC x8,0

        dut.instr_mem.memory[10] = 32'h008004EF; // JAL x9,+8
        dut.instr_mem.memory[11] = 32'h06300313; // ADDI x6,x0,99 (skipped)

        dut.instr_mem.memory[12] = 32'h04000593; // ADDI x11,x0,64
        dut.instr_mem.memory[13] = 32'h00058567; // JALR x10,0(x11)

        dut.instr_mem.memory[14] = 32'h04D00313; // ADDI x6,x0,77 (skipped)
        dut.instr_mem.memory[15] = 32'h00000013; // NOP

        dut.instr_mem.memory[16] = 32'h00700613; // ADDI x12,x0,7

        // --------------------------------
        // Release reset
        // --------------------------------

        #10;
        reset = 0;

        // Wait for the program to execute
        repeat (17) @(posedge clk);
        #1;

        // --------------------------------
        // Verification
        // --------------------------------

        $display("\n========== CPU VERIFICATION ==========");

        if (dut.registers.registers[1] == 5)
            $display("ADDI: PASS");
        else
            $display("ADDI: FAIL");

        if (dut.registers.registers[3] == 13)
            $display("ADD: PASS");
        else
            $display("ADD: FAIL");

        if (dut.registers.registers[4] == 32'hFFFFFFFD)
            $display("SUB: PASS");
        else
            $display("SUB: FAIL");

        if (dut.data_mem.memory[0] == 32'hFFFFFFFD)
            $display("SW: PASS");
        else
            $display("SW: FAIL");

        if (dut.registers.registers[5] == 32'hFFFFFFFD)
            $display("LW: PASS");
        else
            $display("LW: FAIL");

        if (dut.registers.registers[6] == 0)
            $display("BEQ: PASS");
        else
            $display("BEQ: FAIL");

        if (dut.registers.registers[7] == 32'h00001000)
            $display("LUI: PASS");
        else
            $display("LUI: FAIL");

        if (dut.registers.registers[8] == 36)
            $display("AUIPC: PASS");
        else
            $display("AUIPC: FAIL");

        if (dut.registers.registers[9] == 44)
            $display("JAL: PASS");
        else
            $display("JAL: FAIL");

        if (dut.registers.registers[10] == 56)
            $display("JALR: PASS");
        else
            $display("JALR: FAIL");

        if (dut.registers.registers[12] == 7)
            $display("JUMP TARGET: PASS");
        else
            $display("JUMP TARGET: FAIL");

        $display("======================================\n");

        $finish;
    end

endmodule