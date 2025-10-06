#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------

#CORE 0
org 0x0000
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  halt
  

#CORE 1
org 0x0200
  li $5, 16
  li $6, 1500       // 0x000005dc, idx = 3, tag = 0x28, binary = 0101 1101 1100
  sw $5, 0($6)      // I -> M for idx 3 way 0
  addi $0, $0, 0
  li $7, 32
  sw $7, 0($6)      // M -> M for idx 3 way 0
  addi $0, $0, 0
  addi $0, $0, 0
  lw $27, 0($6)      // M -> M for idx 3 way 0
  halt
