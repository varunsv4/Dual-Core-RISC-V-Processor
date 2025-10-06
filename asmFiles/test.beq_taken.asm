#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#--------------------------------------
# BEQ TAKEN TEST
#--------------------------------------
org 0x0000

li $5, 7
li $6, 7
beq $5, $6, beq_taken       // Branch if equal
li $5, 9        // branch not taken
sw $5, 100($0)
j end_test

beq_taken:

li $5, 1        // branch taken
sw $5, 100($0)

end_test:
halt
