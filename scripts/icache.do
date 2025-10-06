onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /icache_tb/CLK
add wave -noupdate /icache_tb/nRST
add wave -noupdate -expand -group DCIF -divider INPUTS
add wave -noupdate -expand -group DCIF /icache_tb/DUT/dcif/imemREN
add wave -noupdate -expand -group DCIF -color Magenta /icache_tb/DUT/dcif/imemaddr
add wave -noupdate -expand -group DCIF -divider OUTPUTS
add wave -noupdate -expand -group DCIF -color Orange /icache_tb/DUT/dcif/ihit
add wave -noupdate -expand -group DCIF -color Cyan /icache_tb/DUT/dcif/imemload
add wave -noupdate -expand -group CIF -divider INPUTS
add wave -noupdate -expand -group CIF -color Gold /icache_tb/DUT/cif/iwait
add wave -noupdate -expand -group CIF /icache_tb/DUT/cif/iload
add wave -noupdate -expand -group CIF -divider OUTPUTS
add wave -noupdate -expand -group CIF -color Magenta /icache_tb/DUT/cif/iREN
add wave -noupdate -expand -group CIF -color Orange /icache_tb/DUT/cif/iaddr
add wave -noupdate -expand -group DUT -color Cyan /icache_tb/DUT/CLK
add wave -noupdate -expand -group DUT -color Yellow /icache_tb/DUT/nRST
add wave -noupdate -expand -group DUT /icache_tb/DUT/state
add wave -noupdate -expand -group DUT -color Magenta /icache_tb/DUT/next_state
add wave -noupdate -expand -group DUT -color Orange /icache_tb/DUT/icache
add wave -noupdate -expand -group DUT -color Cyan /icache_tb/DUT/next_icache
add wave -noupdate -expand -group DUT -color Yellow /icache_tb/DUT/addr
add wave -noupdate -expand -group DUT /icache_tb/DUT/next_iREN
add wave -noupdate -expand -group DUT -color Magenta /icache_tb/DUT/next_iaddr
add wave -noupdate -color Orange /icache_tb/PROG/#ublk#502948#35/test_name
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {146 ns} 0}
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
WaveRestoreZoom {0 ns} {179 ns}
