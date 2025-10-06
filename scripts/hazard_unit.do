onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hazard_unit_tb/CLK
add wave -noupdate /hazard_unit_tb/nRST
add wave -noupdate /hazard_unit_tb/DUT/huif/MemRead_EX
add wave -noupdate /hazard_unit_tb/DUT/huif/wsel_EX
add wave -noupdate /hazard_unit_tb/DUT/huif/rsel1_ID
add wave -noupdate /hazard_unit_tb/DUT/huif/rsel2_ID
add wave -noupdate /hazard_unit_tb/DUT/huif/ctrlFlush
add wave -noupdate /hazard_unit_tb/DUT/huif/PCWrite
add wave -noupdate /hazard_unit_tb/DUT/huif/Write_IF_ID
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {63 ns} 0}
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
WaveRestoreZoom {0 ns} {90 ns}
