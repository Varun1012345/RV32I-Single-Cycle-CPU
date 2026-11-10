module imm_gen (
    input  wire [31:0] instruction,
    input  wire [2:0]  imm_type,
    output reg  [31:0] immediate
);

    always @(*) begin
        case (imm_type)

            3'b000: begin
                // I-type
                immediate = {{20{instruction[31]}},
                             instruction[31:20]};
            end

            3'b001: begin
                // S-type
                immediate = {{20{instruction[31]}},
                             instruction[31:25],
                             instruction[11:7]};
            end

            3'b010: begin
                // B-type
                immediate = {{19{instruction[31]}},
                             instruction[31],
                             instruction[7],
                             instruction[30:25],
                             instruction[11:8],
                             1'b0};
            end

            3'b011: begin
                // U-type
                immediate = {instruction[31:12], 12'b0};
            end

            3'b100: begin
                // J-type
                immediate = {{11{instruction[31]}},
                             instruction[31],
                             instruction[19:12],
                             instruction[20],
                             instruction[30:21],
                             1'b0};
            end

            default: begin
                immediate = 32'b0;
            end

        endcase
    end

endmodule