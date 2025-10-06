#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#--------------------------------------
# Multiply Algorithm
#--------------------------------------
  org 0x0000

  li $sp, 0xFFFC

  addi $sp, $sp, -8

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
    halt

org 0xFFF4
cfw 3

org 0xFFF8
cfw 7




  
