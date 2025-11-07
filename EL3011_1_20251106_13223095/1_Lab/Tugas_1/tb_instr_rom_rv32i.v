`include "instr_rom_rv32i.v"

module tb_instr_rom_rv32i;
reg clk;
reg rst_n;
reg [31:0] ADDR;
wire [31:0] INSTR;


tb_instr_rom_rv32i DUT (
    .clock(clk), .reset(rst_n),
    .ADDR(ADDR), .INSTR(INSTR)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
end

initial begin
    $dumpfile("tb_instr_rom_rv32i.vcd");
    $dumpvars(0, tb_instr_rom_rv32i);
    // Inisialisasi
    rst_n = 0;
    ADDR = 32'd0;
    @(posedge clk);
    ADDR = 32'd4;
    @(posedge clk);
    ADDR = 32'd8;
    @(posedge clk);
    ADDR = 32'd12;
    @(posedge clk);
    ADDR = 32'd16;
    @(posedge clk);
    ADDR = 32'd20;
    @(posedge clk);
    ADDR = 32'd24;
    @(posedge clk);
    ADDR = 32'd28;
    @(posedge clk);
    $finish(2);
end

endmodule