#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#--------------------------------------
# BLT NOT TAKEN TEST
#--------------------------------------
org 0x0000

li $5, 7
li $6, 7
blt $5, $6, blt_taken       // Branch if less than
li $5, 1        // branch not taken
sw $5, 100($0)
j end_test

blt_taken:

li $5, 9        // branch taken
sw $5, 100($0)

end_test:
halt
