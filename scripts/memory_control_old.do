onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory_control_tb/CLK
add wave -noupdate /memory_control_tb/nRST
add wave -noupdate -expand -group CCIF -divider INPUT
add wave -noupdate -expand -group CCIF /memory_control_tb/DUT/ccif/iREN
add wave -noupdate -expand -group CCIF -color Magenta /memory_control_tb/DUT/ccif/dREN
add wave -noupdate -expand -group CCIF -color Yellow /memory_control_tb/DUT/ccif/dWEN
add wave -noupdate -expand -group CCIF -color Cyan /memory_control_tb/DUT/ccif/dstore
add wave -noupdate -expand -group CCIF -color Orange /memory_control_tb/DUT/ccif/iaddr
add wave -noupdate -expand -group CCIF /memory_control_tb/DUT/ccif/daddr
add wave -noupdate -expand -group CCIF -color Magenta /memory_control_tb/DUT/ccif/ramload
add wave -noupdate -expand -group CCIF -color Yellow /memory_control_tb/DUT/ccif/ramstate
add wave -noupdate -expand -group CCIF -divider OUTPUT
add wave -noupdate -expand -group CCIF -color Cyan /memory_control_tb/DUT/ccif/iwait
add wave -noupdate -expand -group CCIF -color Orange /memory_control_tb/DUT/ccif/dwait
add wave -noupdate -expand -group CCIF /memory_control_tb/DUT/ccif/iload
add wave -noupdate -expand -group CCIF -color Magenta /memory_control_tb/DUT/ccif/dload
add wave -noupdate -expand -group CCIF -color Yellow /memory_control_tb/DUT/ccif/ramstore
add wave -noupdate -expand -group CCIF -color Cyan /memory_control_tb/DUT/ccif/ramaddr
add wave -noupdate -expand -group CCIF -color Orange /memory_control_tb/DUT/ccif/ramWEN
add wave -noupdate -expand -group CCIF /memory_control_tb/DUT/ccif/ramREN
add wave -noupdate -expand -group CCIF -divider {DONT'T CARE}
add wave -noupdate -expand -group CCIF /memory_control_tb/DUT/ccif/ccwait
add wave -noupdate -expand -group CCIF /memory_control_tb/DUT/ccif/ccinv
add wave -noupdate -expand -group CCIF /memory_control_tb/DUT/ccif/ccwrite
add wave -noupdate -expand -group CCIF /memory_control_tb/DUT/ccif/cctrans
add wave -noupdate -expand -group CCIF /memory_control_tb/DUT/ccif/ccsnoopaddr
add wave -noupdate -expand -group RAMIF -divider INPUT
add wave -noupdate -expand -group RAMIF /memory_control_tb/ramif/ramaddr
add wave -noupdate -expand -group RAMIF -color Magenta /memory_control_tb/ramif/ramstore
add wave -noupdate -expand -group RAMIF -color Yellow /memory_control_tb/ramif/ramREN
add wave -noupdate -expand -group RAMIF -color Cyan /memory_control_tb/ramif/ramWEN
add wave -noupdate -expand -group RAMIF -divider OUTPUT
add wave -noupdate -expand -group RAMIF -color Orange /memory_control_tb/ramif/ramstate
add wave -noupdate -expand -group RAMIF /memory_control_tb/ramif/ramload
add wave -noupdate -expand -group RAMIF -divider {DON'T CARE}
add wave -noupdate -expand -group RAMIF /memory_control_tb/ramif/memaddr
add wave -noupdate -expand -group RAMIF /memory_control_tb/ramif/memstore
add wave -noupdate -expand -group RAMIF /memory_control_tb/ramif/memREN
add wave -noupdate -expand -group RAMIF /memory_control_tb/ramif/memWEN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {113293 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {136 ns}
