module rv32i_single_cycle (
    input wire clk,
    input wire reset
);

    // 1. Program Counter signals
    wire [31:0] current_pc;
    wire [31:0] next_pc;
    wire [31:0] pc_plus_4;

    // 2. Instruction signal
    wire [31:0] instruction;

    // 3. Instruction fields
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire funct7_bit30;

    // Control signals
    wire reg_write;
    wire alu_src;
    wire mem_write;
    wire mem_read;
    wire mem_to_reg;
    wire branch;
    wire jump;
    wire jalr;
    wire auipc;
    wire [3:0] alu_control;
    wire [2:0] imm_type;
    wire [31:0] immediate;

    // Register File signals
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] write_back_data;

    // ALU signals
    wire [31:0] alu_input_b;
    wire [31:0] alu_result;

    // Data Memory signals
    wire [31:0] memory_read_data;

    // 4. Extract fields from the instruction
    assign opcode       = instruction[6:0];
    assign rd           = instruction[11:7];
    assign funct3       = instruction[14:12];
    assign rs1          = instruction[19:15];
    assign rs2          = instruction[24:20];
    assign funct7_bit30 = instruction[30];

    // 5. Program Counter
    pc program_counter (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .current_pc(current_pc)
    );

    // 6. Instruction Memory
    instruction_memory instr_mem (
        .address(current_pc),
        .instruction(instruction)
    );
    // Control Unit
    control_unit control (
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
        .jalr(jalr),
        .auipc(auipc),
        .alu_control(alu_control),
        .imm_type(imm_type)
);
    // Immediate Generator
    imm_gen immediate_generator (
        .instruction(instruction),
        .imm_type(imm_type),
        .immediate(immediate)
);
    // Register File
    regfile registers (
        .clk(clk),
        .we(reg_write),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(write_back_data),
        .rd1(read_data1),
        .rd2(read_data2)
);
    // ALU input B multiplexer
    assign alu_input_b = alu_src ? immediate : read_data2;
    assign pc_plus_4 = current_pc + 32'd4;

    // ALU
    alu arithmetic_logic_unit (
        .a(read_data1),
        .b(alu_input_b),
        .alu_control(alu_control),
        .result(alu_result)
);

    // Data Memory
    data_memory data_mem (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(alu_result),
        .write_data(read_data2),
        .read_data(memory_read_data)
);
    
   // Next PC selection
   assign next_pc = jalr
                 ? {alu_result[31:1], 1'b0}
                 : jump
                   ? current_pc + immediate
                   : (branch && (alu_result == 32'd0))
                     ? current_pc + immediate
                     : pc_plus_4;
        
  // Write-back selection
   assign write_back_data = (jump || jalr)
                       ? pc_plus_4
                       : mem_to_reg
                         ? memory_read_data
                         : auipc
                           ? (current_pc + immediate)
                           : (opcode == 7'b0110111)
                             ? immediate
                             : alu_result;
endmodule