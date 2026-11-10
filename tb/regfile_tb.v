module regfile_tb;

    reg         clk;
    reg         we;

    reg  [4:0]  rs1;
    reg  [4:0]  rs2;
    reg  [4:0]  rd;

    reg  [31:0] wd;

    wire [31:0] rd1;
    wire [31:0] rd2;

    regfile dut (
        .clk(clk),
        .we(we),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2)
);
    initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    // Initialize signals
    we  = 0;
    rs1 = 0;
    rs2 = 0;
    rd  = 0;
    wd  = 0;

    #10;

    // Write 25 into x5
    we = 1;
    rd = 5;
    wd = 25;

    #10;

    // Write 40 into x7
    rd = 7;
    wd = 40;

    #10;

    // Disable writing and select both registers
    we  = 0;
    rs1 = 5;
    rs2 = 7;

    #1;

    // Display both read outputs
$display("Register read test: rd1 = %d, rd2 = %d", rd1, rd2);

// Attempt to write 99 into x0
we = 1;
rd = 0;
wd = 99;

#10;

// Disable writing and select x0
we  = 0;
rs1 = 0;

#1;

// Display x0 read result
$display("x0 read test: rd1 = %d", rd1);

$finish;
end
endmodule