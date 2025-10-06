#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#--------------------------------------
# BNE TAKEN TEST
#--------------------------------------
org 0x0000

li $5, 7
li $6, 8
bne $5, $6, bne_taken       // Branch if not equal
li $5, 9        // branch not taken
sw $5, 100($0)
j end_test

bne_taken:

li $5, 1        // branch taken
sw $5, 100($0)

end_test:
halt
