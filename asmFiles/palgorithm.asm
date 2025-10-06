#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------

#----------------------------------------------------------
# Core 1 Init: Producer
#----------------------------------------------------------
  org 0x0000
  li sp, 0xFFFC         # core 1 stack    
  jal     mainc1        # core 1 main program
  halt

#----------------------------------------------------------
# Core 1 Main: Producer
#----------------------------------------------------------

mainc1:
  push ra
  li s11, stack_pointer
  li s3, 0                        # loop variable
  li s4, 256                      # how many times to loop
  li s5, 0xbeef                   # will store produced number. is hard-coded seed at start
  
  produce_loop:
    beq s3, s4, exitc1            # loop condition
    mv a2, s5                     # move previous produced number to arg2
    jal crc32                     # jump to crc subroutine
    mv s5, a0                     # put produced number in saved register

    li a0, lock_var        # move lock to argument register
    jal lock                      # try to acquire the lock

    # ----------------------- #
    # critical code segment:      # push produced number to shared stack
    lw s10, 0(s11)
    addi s10, s10, -4
    sw s5, 0(s10)
    sw s10, 0(s11)
    # ----------------------- #

    li a0, lock_var       # move lock to argument register
    jal unlock

    addi s3, s3, 1
    j produce_loop
  
  exitc1:
    and t1, s5, t0                # put bottom 16 bits of produced number in temp register
    
    pop ra
    ret

#----------------------------------------------------------
# Core 2 Init: Consumer
#----------------------------------------------------------
  org 0x0200
  li sp, 0x7FFC                 # core 2 stack          
  jal     mainc2                # core 2 main program
  halt

#----------------------------------------------------------
# Core 2 Main: Consumer
#----------------------------------------------------------

mainc2:
  push ra
  li s11, stack_pointer    # s11 = location of stack pointer
  li s3, 0                        # loop variable
  li s4, 256                      # how many times to loop
  li s5, 0                        # sum of produced numbers
  li s6, 0x7FFFFFFF               # current min
  li s7, 0                        # current max
  
  consume_loop:
    beq s3, s4, exitc2            # loop condition
    li t0, 0x4ffc
    lw s10, 0(s11)
    beq s10, t0, consume_loop

    li a0, lock_var        # move lock to argument register
    jal lock                      # try to acquire the lock

    # ----------------------- #
    # critical code segment:      # push produced number to shared stack
    lw s10, 0(s11)                # value of stack pointer
    lw s8, 0(s10)
    sw $0, 0(s10)             # this is overwriting an instruction
    addi s10, s10, 4
    sw s10, 0(s11)                # update stack pointer stored in memory
    addi s3, s3, 1
    # ----------------------- #
  release_lock:
    li a0, lock_var        # move lock to argument register
    jal unlock

    li t0, 0xffff                 # set up bit mask
    and s9, s8, t0                # put bottom 16 bits of produced number in temp register

    add s5, s5, s9                # add produced number to sum

    li t1, 1
    beq s3, t1, first_min
    mv a2, s6                     # move current min to arg2
    j calc_min

  first_min:
    mv a2, s9                     # move produced number to arg2
  
  calc_min:
    mv a3, s9                     # move produced number to arg3
    jal min                       # jump to min subroutine
    mv s6, a0                     # min result becomes new min

    mv a2, s7                     # move current max to arg2
    mv a3, s9                     # move produced number to arg3
    jal max                       # jump to max subroutine
    mv s7, a0                     # max result becomes new max


    j consume_loop
  
  exitc2:
    mv a2, s5                     # move sum to arg2
    mv a3, s4                     # move number of produced numbers to arg3
    jal divide                # jump to divide subroutine
    mv t0, a0                    # move avg to saved register

    pop ra
    ret


#----------------------------------------------------------
# Shared Lock Functions
#----------------------------------------------------------
# pass in an address to lock function in argument register 0
# returns when lock is available
lock:
acquire:
  lr.w    t0, (a0)              # load lock location
  bne     t0, zero, acquire     # wait on lock to be open
  li      t1, 1
  sc.w    t2, t1, (a0)
  bne     t2, zero, lock        # if sc.w failed, retry (In case of SC failure, rd gets written 1 (!= 0))
  ret

# pass in an address to unlock function in argument register 0
# returns after freeing lock
unlock:
  sw      zero, 0(a0)           # exclusive writer safe to clear the lock
  ret


#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#REGISTERS
#ra $1 Return address
#sp $2 Stack pointer
#gp $3 Global pointer
#tp $4 Thread pointer
#t0-2 $5-7 temps
#s0/fp $8 Saved/frame pointer
#s1 $9 Saved register
#$a0-1 $10-11 Fn args/return values
#$a2-7 $12-17 Fn args
#$s2-11 $18-27 Saved registers
#$t3-6 $28-31 Temporaries

# USAGE random0 = crc(seed), random1 = crc(random0)
#       randomN = crc(randomN-1)
#------------------------------------------------------
# $a0 = crc32($a2)
crc32:
  lui $t1, 0x04C11
   ori $t1, $t1, 0x7B7
   addi $t1, $t1, 0x600
   or $t2, $0, $0
   ori $t3, $0, 32
 
l1:
  slt $t4, $t2, $t3
   beq $t4, $0, l2
 
  ori $t5, $0, 31
   srl $t4, $a2, $t5
   ori $t5, $0, 1
   sll $a2,$a2,$t5
   beq $t4, $0, l3
   xor $a2, $a2, $t1
 l3:
  addi $t2, $t2, 1
   j l1
l2:
  or $a0, $a2, $0
   jr $1




#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------

# a2 = Numerator
# a3 = Denominator
# a0 = Quotient
# a1 = Remainder

#-divide(N=$a2,D=$a3) returns (Q=$a0,R=$a1)--------
divide:               # setup frame
  push  $1           # saved return address
   or    $a0, $0, $0   # Quotient v0=0
   or    $a1, $0, $a2  # Remainder t2=N=a0
   beq   $0, $a3, divrtn # test zero D
   slt   $t0, $a3, $0  # test neg D
   bne   $t0, $0, divdneg
   slt   $t0, $a2, $0  # test neg N
   bne   $t0, $0, divnneg
 divloop:
  slt   $t0, $a1, $a3 # while R >= D
   bne   $t0, $0, divrtn
   addi $a0, $a0, 1   # Q = Q + 1
   sub  $a1, $a1, $a3 # R = R - D
   j     divloop
divnneg:
  sub  $a2, $0, $a2  # negate N
   jal   divide        # call divide
  sub  $a0, $0, $a0  # negate Q
   beq   $a1, $0, divrtn
   addi $a0, $a0, -1  # return -Q-1
   j     divrtn
divdneg:
  sub  $a2, $0, $a3  # negate D
   jal   divide        # call divide
  sub  $a0, $0, $a0  # negate Q
 divrtn:
   pop $1
   jr  $1
#-divide--------------------------------------------




#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
# a2 = a
# a3 = b
# a0 = result

#-max (a2=a,a3=b) returns a0=max(a,b)--------------
max:
  push  $1
   or    $a0, $0, $a2
   slt   $t0, $a2, $a3
   beq   $t0, $0, maxrtn
   or    $a0, $0, $a3
 maxrtn:
   pop   $1
   jr    $1
 #--------------------------------------------------

#-min (a0=a,a1=b) returns v0=min(a,b)--------------
min:
  push  $1
   or    $a0, $0, $a2
   slt   $t0, $a3, $a2
   beq   $t0, $0, minrtn
   or    $a0, $0, $a3
 minrtn:
   pop   $1
   jr    $1
 #--------------------------------------------------



#----------------------------------------------------------
# Shared Data Segment
#----------------------------------------------------------
org 0x800
lock_var:
  cfw 0x0     # lock starts unlocked, should end unlocked

org 0x804
stack_pointer:
cfw 0x4FFC
