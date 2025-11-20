# Praktikum EL3011 Arsitektur Sistem Komputer 
# Modul        : 1
# Percobaan    : 1 (Tugas Pendahuluan) 
# Tanggal      : 4 November 2025 
# Kelompok     :  
# Rombongan    :  
# Nama (NIM) 1 : Muammar Qadafi (13223094) 
# Nama (NIM) 2 : Muhammad Falih Rosyidi (13223095) 
# Nama File    : soal3.s 
# Deskripsi    : Assembly dari tugas pendahuluan no 3 mengenai sum dari i pada looop  <= 10
.text
.globl main
main:
    addi t0, x0, 1       # i = 1
    add  t1, x0, x0      # sum = 0
    addi t2, x0, 11      # limit = 11 (i < 11)

loop:
    add  t1, t1, t0      # sum += i
    addi t0, t0, 1       # i++
    blt  t0, t2, loop    # while (i < 11)

    # exit program
    addi a0, x0, 0       # return 0