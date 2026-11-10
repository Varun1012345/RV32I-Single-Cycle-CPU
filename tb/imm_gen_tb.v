`timescale 1ns / 1ps

module imm_gen_tb;

    reg  [31:0] instruction;
    reg  [2:0]  imm_type;
    wire [31:0] immediate;

    // Instantiate the immediate generator
    imm_gen uut (
        .instruction(instruction),
        .imm_type(imm_type),
        .immediate(immediate)
    );

    initial begin

        // Test 1: I-type immediate
        instruction = 32'h00A10293;
        imm_type = 3'b000;
        #10;
        $display("I-type: immediate = %0d", $signed(immediate));

        // Test 2: S-type immediate (+12)
        instruction = 32'h00512623;
        imm_type = 3'b001;
        #10;
        $display("S-type: immediate = %0d", $signed(immediate));

        // Test 3: B-type immediate
        instruction = 32'h00628863;
        imm_type = 3'b010;
        #10;
        $display("B-type: immediate = %0d", $signed(immediate));

        // Test 4: U-type immediate
        instruction = 32'h123452B7;
        imm_type = 3'b011;
        #10;
        $display("U-type: immediate = 0x%h", immediate);

        // Test 5: J-type immediate
        instruction = 32'h064000EF;
        imm_type = 3'b100;
        #10;
        $display("J-type: immediate = %0d", $signed(immediate));

        $finish;

    end

endmodule