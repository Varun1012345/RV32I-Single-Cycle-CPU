module data_memory (
input  wire        clk,
input  wire        mem_read,
input  wire        mem_write,
input  wire [31:0] address,
input  wire [31:0] write_data,
output wire [31:0] read_data
);

// Memory containing 256 words of 32 bits each
reg [31:0] memory [0:255];

// Write data on the rising edge of the clock
always @(posedge clk) begin
    if (mem_write) begin
        memory[address[9:2]] <= write_data;
    end
end

// Read data combinationally
assign read_data = mem_read
                 ? memory[address[9:2]]
                 : 32'b0;

endmodule
