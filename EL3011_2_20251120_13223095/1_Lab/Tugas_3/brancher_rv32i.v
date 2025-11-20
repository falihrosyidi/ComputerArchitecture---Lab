// Praktikum EL3011 Arsitektur Sistem Komputer
// Modul        : 2
// Percobaan    : 3
// Tanggal      : 20 Novemember 2025
// Nama (NIM) 1 : Muhammad Nabil Raihan (13223014)
// Nama (NIM) 2 : Muhammad Falih Rosyidi (13223095)
// Nama File    : brancher_rv32i.v 
// Deskripsi    : Brancher 32-bit RISC-V (RV32I)

module brancher_rv32i( 
    input wire        [31:0] PCnew,         // PC+4 seperti biasa dari 4-adder 
    input wire        [31:0] ALUout,        // PC+imm dari ALU 
    input wire signed [31:0] in1,           // Nilai di rs1 
    input wire signed [31:0] in2,           // Nilai di rs2 
    input wire               cu_branch,     // Enable branch 
    input wire        [2:0]  cu_branchtype, // BEQ  = 3'b000, BGE = 3'b001, 
                                            // BGEU = 3'b010, BLT = 3'b011, 
                                            // BLTU = 3'b100, BNE = 3'b101 

    output reg [31:0] PCin 
); 

    always @ (*) begin 
        if (cu_branch) begin 
            case (cu_branchtype) 
                3'b000:  // BEQ 
                    PCin <= (in1 == in2) ? ALUout : PCnew; 
                3'b001:  // BGE 
                    PCin <= (in1 >= in2) ? ALUout : PCnew; 
                3'b010:  // BGEU 
                    PCin <= ($unsigned(in1) >= $unsigned(in2)) ? ALUout : PCnew; 
                3'b011:  // BLT 
                    PCin <= (in1 < in2) ? ALUout : PCnew;  
                3'b100:  // BLTU 
                    PCin <= ($unsigned(in1) < $unsigned(in2)) ? ALUout : PCnew;  
                3'b101:  // BNE 
                    PCin <= (in1 != in2) ? ALUout : PCnew; 
                default: 
                    PCin <= PCnew; 
            endcase 
        end 
        else 
            PCin <= PCnew; 
    end 
endmodule 