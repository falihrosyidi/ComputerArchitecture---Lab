// Praktikum EL3011 Arsitektur Sistem Komputer 
// Modul        : 1
// Percobaan    : 1 
// Tanggal      : 4 November 2025 
// Kelompok     :  
// Rombongan    :  
// Nama (NIM) 1 : Muammar Qadafi (13223094) 
// Nama (NIM) 2 : Muhammad Falih Rosyidi (13223094) 
// Nama File    : instr_rom_rv32i.v 
// Deskripsi    : Instruction ROM 32x32 Single-Cycle RISC-V (RV32I) 
module instr_rom_rv32i ( 
    input  wire [31:0] ADDR,   // byte address dari PC 
    input  wire        clock, 
    input  wire        reset, 
    output reg  [31:0] INSTR   // instruksi 32-bit 
); 
  // 32 word x 32-bit 
    reg [31:0] mem [0:31]; 
  // Word index = PC[6:2] (bit [1:0] = 2'b00) 
    wire [4:0] waddr = ADDR[6:2]; 

    integer i; 
    initial begin 
    // Default: semua NOP (addi x0,x0,0) 
    for (i = 0; i < 32; i = i + 1) mem[i] = 32'h00000013; 

    // Isi program (ganti sesuai dengan "Machine Code" dari Venus pada Tugas Pendahuluan nomor 3!): 
    mem[ 0] = 32'h00100293; // addi x5, x0, 1  
    mem[ 1] = 32'h00000333; // add  x6, x0, x0 
    mem[ 2] = 32'h00B00393; // addi x7, x0, 10 
    mem[ 3] = 32'h00530333; // add  x6, x6, x5 
    mem[ 4] = 32'h00128293; // addi x5, x5, 1 
    mem[ 5] = 32'hFE72CCE3; // addi x5, x7, -8
    mem[ 6] = 32'h00000513; // add  x6, x6, x5
    end 

  // Baca sinkron; reset keluarkan NOP 
    always @(posedge clock or posedge reset) begin 
    if (reset) INSTR <= 32'h00000013;   // NOP RV32I 
    else       INSTR <= mem[waddr]; 
    end 
endmodule 