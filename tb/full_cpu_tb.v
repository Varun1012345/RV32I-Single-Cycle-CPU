`timescale 1ns/1ps
module full_cpu_tb;

    reg clk;
    reg reset;

    wire [31:0] debug_pc;
    wire [31:0] debug_instruction;
    wire [31:0] debug_alu_result;

    rv32i_single_cycle dut (
        .clk(clk),
        .reset(reset),
        .debug_pc(debug_pc),
        .debug_instruction(debug_instruction),
        .debug_alu_result(debug_alu_result)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        #10;
        reset = 0;

        repeat (30)begin
            @(posedge clk);
            #1;
            $display("PC=%h  INSTRUCTION=%h  ALU_RESULT=%h",
                     debug_pc, debug_instruction, debug_alu_result);
        end

        $display("Post-synthesis functional simulation completed.");
        $finish;
    end

endmodule
