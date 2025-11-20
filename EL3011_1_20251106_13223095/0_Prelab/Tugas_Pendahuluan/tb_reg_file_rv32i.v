// Modul        : 1
// Percobaan    : TP 
// Tanggal      : 4 November 2025 
// Kelompok     :  
// Rombongan    :  
// Nama (NIM) 1 : Muammar Qadafi (13223094)
// Nama (NIM) 2 : Muhammad Falih Rosyidi (13223095) 
// Nama File    : tb_reg_file_rv32i.v 
// Deskripsi    : Testbench Register file RV32I, 32x32, 2 read ports, 1 write port. 
// x0 selalu 0; write @posedge, read @negedge  
// Testbench untuk reg_file_rv32i
// Deskripsi:
// 1. Menulis ke x1, x2, x3, x4
// 2. Mencoba menulis ke x0 (untuk verifikasi write-ignore)
// 3. Membaca x0-x9
// 4. Self-checking: membandingkan hasil baca dengan expected
// 5. Melaporkan PASS atau FAIL

`timescale 1ns/1ps
`include "../Tugas4/reg_file_rv32i.v"

module tb_reg_file_rv32i;
reg clock;

// Input ke DUT
reg        cu_rdwrite;    // write enable dari CU
reg [4:0]  rs1_addr;      // alamat baca port 1
reg [4:0]  rs2_addr;      // alamat baca port 2
reg [4:0]  rd_addr;       // alamat tulis (write-back)
reg [31:0] rd_in;         // data tulis (write-back data)

// Output dari DUT
wire [31:0] rs1;           // data baca port 1
wire [31:0] rs2;           // data baca port 2

// Sinyal Internal Testbench
integer fail_flag; // Penanda jika ada kegagalan
reg [31:0] expected_values [0:9]; // Array untuk menyimpan nilai yang diharapkan

// Instansiasi DUT 
reg_file_rv32i DUT (
    .clock(clock), .cu_rdwrite(cu_rdwrite),
    .rs1_addr(rs1_addr), .rs2_addr(rs2_addr),
    .rd_addr(rd_addr), .rd_in(rd_in),
    .rs1(rs1), .rs2(rs2)
);

// Clock Generator
localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clock = ~clock;

// VCD Dump untuk GTKWave
initial begin
    $dumpfile("tb_reg_file_rv32i.vcd");
    $dumpvars(0, tb_reg_file_rv32i);
end

// SIMULASI UTAMA
initial begin
    // 1. Inisialisasi Sinyal
    clock = 0;
    cu_rdwrite = 0;
    rs1_addr = 5'b0;
    rs2_addr = 5'b0;
    rd_addr = 5'b0;
    rd_in = 32'b0;
    fail_flag = 0; // Set flag ke 0 (belum gagal)

    // Inisialisasi nilai yang diharapkan
    expected_values[0] = 0; // x0 selalu 0
    // Nilai yang kita tulis
    expected_values[1] = 32'h11;
    expected_values[2] = 32'h22;
    expected_values[3] = 32'h33;
    expected_values[4] = 32'h44;
    // Register lain (x5-x9) harus 0 (nilai inisialisasi DUT)
    expected_values[5] = 32'h0;
    expected_values[6] = 32'h0;
    expected_values[7] = 32'h0;
    expected_values[8] = 32'h0;
    expected_values[9] = 32'h0;

    #CLK_PERIOD; // Tunggu 1 siklus

    cu_rdwrite = 1;
    // Mulai menulis
    // Tulis x1
    @(posedge clock);
    rd_addr = 1;
    rd_in = expected_values[1];
    #1;
    // Tulis x2
    @(posedge clock);
    rd_addr = 2;
    rd_in = expected_values[2];
    #1;
    // Tulis x3
    @(posedge clock);
    cu_rdwrite = 1;
    rd_addr = 3;
    rd_in = expected_values[3];
    #1;
    // Tulis x4
    @(posedge clock);
    cu_rdwrite = 1;
    rd_addr = 4;
    rd_in = expected_values[4];
    #1;

    // Tes tambahan: Coba tulis ke x0 (seharusnya diabaikan oleh DUT)
    @(posedge clock);
    cu_rdwrite = 1;
    rd_addr = 0;
    rd_in = 32'hDEADBEEF;
    #1;

    @(posedge clock);
    cu_rdwrite = 0; // Matikan write enable setelah selesai
    rd_addr = 5'bx; // Set ke 'x' untuk deteksi bug
    rd_in   = 32'bx;
    #CLK_PERIOD;

    // 3. Fase Baca & Verifikasi
    @(posedge clock);
    rs1_addr = 0;
    rs2_addr = 1;
    @(negedge clock);
    #1;
    if (rs1 !== expected_values[0]) fail_flag = 1;
    if (rs2 !== expected_values[1]) fail_flag = 1;

    @(posedge clock);
    rs1_addr = 2;
    rs2_addr = 3;
    @(negedge clock);
    #1;
    if (rs1 !== expected_values[2]) fail_flag = 1;
    if (rs2 !== expected_values[3]) fail_flag = 1;

    @(posedge clock);
    rs1_addr = 4;
    rs2_addr = 5;
    @(negedge clock);
    #1;
    if (rs1 !== expected_values[4]) fail_flag = 1;
    if (rs2 !== expected_values[5]) fail_flag = 1;

    @(posedge clock);
    rs1_addr = 6;
    rs2_addr = 7;
    @(negedge clock);
    #1;
    if (rs1 !== expected_values[6]) fail_flag = 1;
    if (rs2 !== expected_values[7]) fail_flag = 1;
    
    @(posedge clock);
    rs1_addr = 8;
    rs2_addr = 9;
    @(negedge clock);
    #1;
    if (rs1 !== expected_values[8]) fail_flag = 1;
    if (rs2 !== expected_values[9]) fail_flag = 1;

    #CLK_PERIOD;

    // Laporan Hasil Akhir
    if (fail_flag == 0) $display("--- HASIL: SEMUA TES PASS! ---");
    else $display("--- HASIL: ADA TES YANG FAIL! ---");

    $finish;
end

endmodule
