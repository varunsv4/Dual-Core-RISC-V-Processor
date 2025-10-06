#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#--------------------------------------
# HALT TEST
#--------------------------------------
org 0x0000

li $5, 1
sw $5, 100($0)       // x5 stored in memory if halt is successful
halt                // execution should end after this instruction

li $6, 9
sw $6, 100($0)       // x6 stored to memory if halt fails
