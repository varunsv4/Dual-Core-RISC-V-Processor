#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#--------------------------------------
# BGEU NOT TAKEN TEST
#--------------------------------------
org 0x0000

li $5, 7
li $6, -8
bgeu $5, $6, bgeu_taken       // Branch if greater than or equal to (unsigned)
li $5, 1        // branch not taken
sw $5, 100($0)
j end_test

bgeu_taken:

li $5, 9        // branch taken
sw $5, 100($0)

end_test:
halt
