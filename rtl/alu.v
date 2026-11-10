module alu (
    input  wire [31:0] a,
    input  wire [31:0] b,
    input  wire [3:0]  alu_control,
    output reg  [31:0] result
);

    always @(*) begin
        case (alu_control)

            4'b0000: result = a + b;  // ADD
            4'b0001: result = a - b;  // SUB
            4'b0010: result = a & b;  // AND
            4'b0011: result = a | b;  // OR

            // Signed comparison
            4'b0100: begin
                if ($signed(a) < $signed(b))
                    result = 32'd1;
                else
                    result = 32'd0;
            end

            default: result = 32'd0;

        endcase
    end

endmodule
