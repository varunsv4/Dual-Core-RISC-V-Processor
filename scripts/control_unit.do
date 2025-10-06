onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_unit_tb/DUT/CLK
add wave -noupdate -color Magenta /control_unit_tb/DUT/nRST
add wave -noupdate -color Yellow /control_unit_tb/DUT/next_halt
add wave -noupdate -color Cyan /control_unit_tb/DUT/instr
add wave -noupdate -color Orange /control_unit_tb/DUT/opcode
add wave -noupdate -expand -group CUIF /control_unit_tb/cuif/instruction
add wave -noupdate -expand -group CUIF -color Magenta /control_unit_tb/cuif/ihit
add wave -noupdate -expand -group CUIF -color Yellow /control_unit_tb/cuif/zero
add wave -noupdate -expand -group CUIF -color Cyan /control_unit_tb/cuif/negative
add wave -noupdate -expand -group CUIF -color Orange /control_unit_tb/cuif/PCSrc
add wave -noupdate -expand -group CUIF /control_unit_tb/cuif/ALUOp
add wave -noupdate -expand -group CUIF -color Magenta /control_unit_tb/cuif/ALUSrc
add wave -noupdate -expand -group CUIF -color Yellow /control_unit_tb/cuif/ALUSrcPC
add wave -noupdate -expand -group CUIF -color Cyan /control_unit_tb/cuif/MemWr
add wave -noupdate -expand -group CUIF -color Orange /control_unit_tb/cuif/MemRead
add wave -noupdate -expand -group CUIF /control_unit_tb/cuif/MemtoReg
add wave -noupdate -expand -group CUIF -color Magenta /control_unit_tb/cuif/RegWr
add wave -noupdate -expand -group CUIF -color Yellow /control_unit_tb/cuif/WriteSrc
add wave -noupdate -expand -group CUIF -color Cyan /control_unit_tb/cuif/PCWait
add wave -noupdate -expand -group CUIF -color Orange /control_unit_tb/cuif/RselSrc
add wave -noupdate -expand -group CUIF /control_unit_tb/cuif/halt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
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
WaveRestoreZoom {0 ns} {820 ns}
