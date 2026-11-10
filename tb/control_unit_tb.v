`timescale 1ns/1ps

module control_unit_tb;

    reg [6:0] opcode;
    reg [2:0] funct3;
    reg       funct7_bit30;

    wire reg_write;
    wire alu_src;
    wire mem_write;
    wire mem_read;
    wire mem_to_reg;
    wire branch;
    wire jump;
    wire [3:0] alu_control;
    wire [2:0] imm_type;

    // Instantiate the control unit
    control_unit uut (
        .opcode(opcode),
        .funct3(funct3),
        .funct7_bit30(funct7_bit30),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .jump(jump),
        .alu_control(alu_control),
        .imm_type(imm_type)
    );

    initial begin

        // Test 1: ADD
        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7_bit30 = 1'b0;
        #10;

        if (reg_write == 1'b1 &&
            alu_src == 1'b0 &&
            alu_control == 4'b0000)
            $display("PASS: ADD");
        else
            $display("FAIL: ADD");

        // Test 2: SUB
        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7_bit30 = 1'b1;
        #10;

        if (reg_write == 1'b1 &&
            alu_control == 4'b0001)
            $display("PASS: SUB");
        else
            $display("FAIL: SUB");

        // Test 3: ADDI
        opcode = 7'b0010011;
        funct3 = 3'b000;
        funct7_bit30 = 1'b0;
        #10;

        if (reg_write == 1'b1 &&
            alu_src == 1'b1 &&
            imm_type == 3'b000 &&
            alu_control == 4'b0000)
            $display("PASS: ADDI");
        else
            $display("FAIL: ADDI");

        // Test 4: LOAD
        opcode = 7'b0000011;
        #10;

        if (reg_write == 1'b1 &&
            mem_read == 1'b1 &&
            mem_to_reg == 1'b1 &&
            alu_src == 1'b1)
            $display("PASS: LOAD");
        else
            $display("FAIL: LOAD");

        // Test 5: STORE
        opcode = 7'b0100011;
        #10;

        if (mem_write == 1'b1 &&
            reg_write == 1'b0 &&
            imm_type == 3'b001)
            $display("PASS: STORE");
        else
            $display("FAIL: STORE");

        // Test 6: BRANCH
        opcode = 7'b1100011;
        #10;

        if (branch == 1'b1 &&
            alu_control == 4'b0001 &&
            imm_type == 3'b010)
            $display("PASS: BRANCH");
        else
            $display("FAIL: BRANCH");

        // Test 7: LUI
        opcode = 7'b0110111;
        #10;

        if (reg_write == 1'b1 &&
            imm_type == 3'b011)
            $display("PASS: LUI control decode");
        else
            $display("FAIL: LUI control decode");

        // Test 8: JAL
        opcode = 7'b1101111;
        #10;

        if (reg_write == 1'b1 &&
            jump == 1'b1 &&
            imm_type == 3'b100)
            $display("PASS: JAL control decode");
        else
            $display("FAIL: JAL control decode");

        $display("Control unit tests completed.");
        $finish;

    end

endmodule