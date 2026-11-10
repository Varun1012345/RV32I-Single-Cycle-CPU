`timescale 1ns/1ps

module alu_tb;

    reg  [31:0] a;
    reg  [31:0] b;
    reg  [3:0]  alu_control;
    wire [31:0] result;

    integer errors;

    // Instantiate the ALU
    alu dut (
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .result(result)
    );

    initial begin

        errors = 0;

        // Test 1: ADD
        a = 32'd10;
        b = 32'd20;
        alu_control = 4'b0000;
        #10;

        if (result !== 32'd30) begin
            $display("FAIL: ADD");
            errors = errors + 1;
        end
        else begin
            $display("PASS: ADD");
        end

        // Test 2: SUB
        a = 32'd20;
        b = 32'd5;
        alu_control = 4'b0001;
        #10;

        if (result !== 32'd15) begin
            $display("FAIL: SUB");
            errors = errors + 1;
        end
        else begin
            $display("PASS: SUB");
        end

        // Test 3: AND
        a = 32'h0000000A;
        b = 32'h0000000C;
        alu_control = 4'b0010;
        #10;

        if (result !== 32'h00000008) begin
            $display("FAIL: AND");
            errors = errors + 1;
        end
        else begin
            $display("PASS: AND");
        end

        // Test 4: OR
        a = 32'h0000000A;
        b = 32'h0000000C;
        alu_control = 4'b0011;
        #10;

        if (result !== 32'h0000000E) begin
            $display("FAIL: OR");
            errors = errors + 1;
        end
        else begin
            $display("PASS: OR");
        end

        // Test 5: SLT, -1 < 1
        a = 32'hFFFFFFFF;
        b = 32'd1;
        alu_control = 4'b0100;
        #10;

        if (result !== 32'd1) begin
            $display("FAIL: SLT (-1 < 1)");
            errors = errors + 1;
        end
        else begin
            $display("PASS: SLT (-1 < 1)");
        end

        // Test 6: SLT, 5 < -2
        a = 32'd5;
        b = 32'hFFFFFFFE;
        alu_control = 4'b0100;
        #10;

        if (result !== 32'd0) begin
            $display("FAIL: SLT (5 < -2)");
            errors = errors + 1;
        end
        else begin
            $display("PASS: SLT (5 < -2)");
        end

        // Test 7: Unsupported operation
        a = 32'd10;
        b = 32'd20;
        alu_control = 4'b1111;
        #10;

        if (result !== 32'd0) begin
            $display("FAIL: DEFAULT");
            errors = errors + 1;
        end
        else begin
            $display("PASS: DEFAULT");
        end

        // Final summary
        $display("----------------------------");

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d", errors);

        $finish;

    end

endmodule