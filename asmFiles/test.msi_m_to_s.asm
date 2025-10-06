#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------

#CORE 0
org 0x0000
  li $5, 16
  li $6, 1500       // 0x000005dc, idx = 3, tag = 0x28, binary = 0101 1101 1100
  sw $5, 0($6)      // CORE 1: I -> M for idx 3 way 1
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  halt
  

#CORE 1
org 0x0200
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  li $5, 1500       // 0x000005dc, idx = 3, tag = 0x28, binary = 0101 1101 1100
  lw $6, 0($5)      // Core 0: I -> S for idx 3 way 1  ||||  Core 1: M -> S for idx3 way 1
  addi $0, $0, 0
  addi $0, $0, 0
  halt
