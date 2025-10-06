org 0x0000

ori   $4,$0,0xF0
lw    $11,0($4)
add $12, $11, $11
sw $12, 0($4)
halt
