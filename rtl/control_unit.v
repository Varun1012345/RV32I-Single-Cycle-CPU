module control_unit (
    input  wire [6:0] opcode,
    input  wire [2:0] funct3,
    input  wire       funct7_bit30,

    output reg        reg_write,
    output reg        alu_src,
    output reg        mem_write,
    output reg        mem_read,
    output reg        mem_to_reg,
    output reg        branch,
    output reg        jump,
    output reg        jalr,
    output reg        auipc,
    output reg  [3:0] alu_control,
    output reg  [2:0] imm_type
);

    always @(*) begin

        // Default control signals
        reg_write  = 1'b0;
        alu_src    = 1'b0;
        mem_write  = 1'b0;
        mem_read   = 1'b0;
        mem_to_reg = 1'b0;
        branch     = 1'b0;
        jump       = 1'b0;
        jalr       = 1'b0;
        auipc      = 1'b0;
        alu_control = 4'b0000;
        imm_type    = 3'b000;

        case (opcode)

            // ADD and SUB
            7'b0110011: begin
                if (funct3 == 3'b000) begin
                    if (funct7_bit30 == 1'b1)
                        alu_control = 4'b0001; // SUB
                    else
                        alu_control = 4'b0000; // ADD

                    reg_write = 1'b1;
                end
            end

            // ADDI
            7'b0010011: begin
                if (funct3 == 3'b000) begin
                    reg_write = 1'b1;
                    alu_src   = 1'b1;
                    alu_control = 4'b0000;
                    imm_type  = 3'b000;
                end
            end

            // LW
            7'b0000011: begin
                if (funct3 == 3'b010) begin
                    reg_write   = 1'b1;
                    alu_src     = 1'b1;
                    mem_read    = 1'b1;
                    mem_to_reg  = 1'b1;
                    imm_type    = 3'b000;
                    alu_control = 4'b0000;
                end
            end

            // SW
            7'b0100011: begin
                if (funct3 == 3'b010) begin
                    alu_src     = 1'b1;
                    mem_write   = 1'b1;
                    imm_type    = 3'b001;
                    alu_control = 4'b0000;
                end
            end

            // BEQ
            7'b1100011: begin
                if (funct3 == 3'b000) begin
                    branch      = 1'b1;
                    imm_type    = 3'b010;
                    alu_control = 4'b0001;
                end
            end

            // LUI
            7'b0110111: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
                imm_type  = 3'b011;
            end

            // AUIPC
            7'b0010111: begin
                reg_write = 1'b1;
                auipc     = 1'b1;
                imm_type  = 3'b011;
            end

            // JAL
            7'b1101111: begin
                reg_write = 1'b1;
                jump      = 1'b1;
                imm_type  = 3'b100;
            end

            // JALR
            7'b1100111: begin
                if (funct3 == 3'b000) begin
                    reg_write = 1'b1;
                    jalr      = 1'b1;
                    alu_src   = 1'b1;
                    imm_type  = 3'b000;
                end
            end

            default: begin
                // All control signals remain at default values
            end

        endcase
    end

endmodule