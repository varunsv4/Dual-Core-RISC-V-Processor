onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group DUT /request_unit_tb/DUT/CLK
add wave -noupdate -expand -group DUT -color Magenta /request_unit_tb/DUT/nRST
add wave -noupdate -expand -group DUT -color Yellow /request_unit_tb/DUT/next_imemREN
add wave -noupdate -expand -group DUT -color Cyan /request_unit_tb/DUT/next_dmemREN
add wave -noupdate -expand -group DUT -color Orange /request_unit_tb/DUT/next_dmemWEN
add wave -noupdate -expand -group RUIF /request_unit_tb/ruif/ihit
add wave -noupdate -expand -group RUIF -color Magenta /request_unit_tb/ruif/dhit
add wave -noupdate -expand -group RUIF -color Yellow /request_unit_tb/ruif/MemWrite
add wave -noupdate -expand -group RUIF -color Cyan /request_unit_tb/ruif/MemRead
add wave -noupdate -expand -group RUIF -color Orange /request_unit_tb/ruif/is_halted
add wave -noupdate -expand -group RUIF /request_unit_tb/ruif/imemREN
add wave -noupdate -expand -group RUIF -color Magenta /request_unit_tb/ruif/dmemREN
add wave -noupdate -expand -group RUIF -color Yellow /request_unit_tb/ruif/dmemWEN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {73 ns} 0}
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
WaveRestoreZoom {0 ns} {713 ns}
