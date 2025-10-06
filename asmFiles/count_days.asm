#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#--------------------------------------
# Multiply Algorithm
#--------------------------------------
  org 0x0000
  
  li $sp, 0xFFFC

  li $5, 21
  li $6, 5
  li $31, 2005

  push $5
  push $6
  push $31

count_days:

  pop $18
  pop $19
  pop $20

  li $5, 2000
  sub $18, $18, $5

  li $6, 365
  push $6
  push $18

  jal $1, mult_subroutine
  pop $18

  li $7, 1
  sub $19, $19, $7
  li $5, 30
  push $5
  push $19

  jal $1, mult_subroutine
  pop $19

  add $5, $18, $19
  add $5, $5, $20

  halt


mult_subroutine:
  lw $5, 0($sp)          // Load unsigned word #1 from stack
  lw $6, 4($sp)          // Load unsigned word #2 from stack
  addi $sp, $sp, 8        // Adjust stack
  li $7, 0              // Loop counter
  li $28, 0             // Sum variable

  loop:
    beq $7, $5, exit
    add $28, $28, $6
    addi $7, $7, 1
    j loop
  exit:
    addi $sp, $sp, -4
    sw $28, 0(sp)
    jalr $0, 0($1)
