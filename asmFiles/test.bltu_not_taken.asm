#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#--------------------------------------
# BLTU NOT TAKEN TEST
#--------------------------------------
org 0x0000

li $5, -8
li $6, -7
bltu $5, $6, bltu_taken       // Branch if less than (unsigned)
li $5, 1        // branch not taken
sw $5, 100($0)
j end_test

bltu_taken:

li $5, 9        // branch taken
sw $5, 100($0)

end_test:
halt
