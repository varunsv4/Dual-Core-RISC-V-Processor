#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#--------------------------------------
# BGE TAKEN TEST
#--------------------------------------
org 0x0000

li $5, 7
li $6, 7
bge $5, $6, bge_taken       // Branch if greater than or equal to
li $5, 9        // branch not taken
sw $5, 100($0)
j end_test

bge_taken:

li $5, 1        // branch taken
sw $5, 100($0)

end_test:
halt
