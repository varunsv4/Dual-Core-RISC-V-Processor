onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /forwarding_unit_tb/CLK
add wave -noupdate /forwarding_unit_tb/nRST
add wave -noupdate /forwarding_unit_tb/fuif/rs1_EX
add wave -noupdate /forwarding_unit_tb/fuif/rs2_EX
add wave -noupdate /forwarding_unit_tb/fuif/wsel_MEM
add wave -noupdate /forwarding_unit_tb/fuif/wsel_WB
add wave -noupdate /forwarding_unit_tb/fuif/RegWr_MEM
add wave -noupdate /forwarding_unit_tb/fuif/RegWr_WB
add wave -noupdate /forwarding_unit_tb/fuif/ForwardA
add wave -noupdate /forwarding_unit_tb/fuif/ForwardB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4634 ns} 0}
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
WaveRestoreZoom {0 ns} {8 us}
