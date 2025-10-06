#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#--------------------------------------
# BLTU TAKEN TEST
#--------------------------------------
org 0x0000

li $5, -7
li $6, -8
bltu $5, $6, bltu_taken       // Branch if less than (unsigned)
li $5, 9        // branch not taken
sw $5, 100($0)
j end_test

bltu_taken:

li $5, 1        // branch taken
sw $5, 100($0)

end_test:
halt
