module instruction_memory (
    input  wire [31:0] address,
    output wire [31:0] instruction
);

    reg [31:0] memory [0:255];

    initial begin
        $readmemh("program.mem", memory);
    end

    assign instruction = memory[address[9:2]];

endmodule