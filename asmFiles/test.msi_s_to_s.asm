#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------

#CORE 0
org 0x0000
  li $5, 1500       // 0x000005dc, idx = 3, tag = 0x28, binary = 0101 1101 1100
  lw $6, 0($5)      // Core 0: I -> S for idx 3 way 0
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  lw $7, 0($5)      // Core 0: S -> S for idx 3 way 1  ||||  Core 1: S -> S for idx 3 way 1
  addi $0, $0, 0
  halt
  

#CORE 1
org 0x0200
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  li $5, 1500       // 0x000005dc, idx = 3, tag = 0x28, binary = 0101 1101 1100
  lw $6, 0($5)      // Core 1: I -> S for idx 3 way 1  ||||  Core 0: S -> S for idx 3 way 1
  addi $0, $0, 0
  addi $0, $0, 0
  addi $0, $0, 0
  halt



org 0x05DC
cfw 16
