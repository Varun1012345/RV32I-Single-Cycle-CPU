`timescale 1ns/1ps

module data_memory_tb;

reg clk;
reg mem_read;
reg mem_write;
reg [31:0] address;
reg [31:0] write_data;

wire [31:0] read_data;

// Instantiate Data Memory
data_memory uut (
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(address),
    .write_data(write_data),
    .read_data(read_data)
);

// Generate a clock with a 10 ns period
always #5 clk = ~clk;

initial begin

    // Initialize inputs
    clk = 1'b0;
    mem_read = 1'b0;
    mem_write = 1'b0;
    address = 32'd0;
    write_data = 32'd0;

    // Test 1: Write 42 to address 0
    @(negedge clk);
    address = 32'd0;
    write_data = 32'd42;
    mem_write = 1'b1;

    @(posedge clk);
    #1;

    mem_write = 1'b0;

    // Test 2: Read address 0
    mem_read = 1'b1;
    #1;

    if (read_data == 32'd42)
        $display("PASS: Read value 42 from address 0");
    else
        $display("FAIL: Read value 42 from address 0");

    // Test 3: Write 100 to address 4
    @(negedge clk);
    address = 32'd4;
    write_data = 32'd100;
    mem_write = 1'b1;
    mem_read = 1'b0;

    @(posedge clk);
    #1;

    mem_write = 1'b0;

    // Test 4: Read address 4
    mem_read = 1'b1;
    #1;

    if (read_data == 32'd100)
        $display("PASS: Read value 100 from address 4");
    else
        $display("FAIL: Read value 100 from address 4");

    // Test 5: Disable memory read
    mem_read = 1'b0;
    #1;

    if (read_data == 32'd0)
        $display("PASS: Read output is zero when disabled");
    else
        $display("FAIL: Read output is zero when disabled");

    $display("Data memory tests completed.");
    $finish;

end

endmodule
