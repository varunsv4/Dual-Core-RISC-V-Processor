onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/PROG/#ublk#502948#73/test_name
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -expand -group DCIF -divider INPUTS
add wave -noupdate -expand -group DCIF /dcache_tb/DUT/dcif/halt
add wave -noupdate -expand -group DCIF /dcache_tb/DUT/dcif/dmemREN
add wave -noupdate -expand -group DCIF /dcache_tb/DUT/dcif/dmemWEN
add wave -noupdate -expand -group DCIF /dcache_tb/DUT/dcif/dmemstore
add wave -noupdate -expand -group DCIF /dcache_tb/DUT/dcif/dmemaddr
add wave -noupdate -expand -group DCIF -divider OUTPUTS
add wave -noupdate -expand -group DCIF /dcache_tb/DUT/dcif/dhit
add wave -noupdate -expand -group DCIF /dcache_tb/DUT/dcif/dmemload
add wave -noupdate -expand -group DCIF /dcache_tb/DUT/dcif/flushed
add wave -noupdate -expand -group CIF -divider INPUTS
add wave -noupdate -expand -group CIF /dcache_tb/DUT/cif/dwait
add wave -noupdate -expand -group CIF /dcache_tb/DUT/cif/dload
add wave -noupdate -expand -group CIF /dcache_tb/DUT/cif/ccwait
add wave -noupdate -expand -group CIF /dcache_tb/DUT/cif/ccinv
add wave -noupdate -expand -group CIF /dcache_tb/DUT/cif/ccsnoopaddr
add wave -noupdate -expand -group CIF -divider OUTPUTS
add wave -noupdate -expand -group CIF /dcache_tb/DUT/cif/dREN
add wave -noupdate -expand -group CIF /dcache_tb/DUT/cif/dWEN
add wave -noupdate -expand -group CIF /dcache_tb/DUT/cif/daddr
add wave -noupdate -expand -group CIF /dcache_tb/DUT/cif/dstore
add wave -noupdate -expand -group CIF /dcache_tb/DUT/cif/ccwrite
add wave -noupdate -expand -group CIF /dcache_tb/DUT/cif/cctrans
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/CLK
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/nRST
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/hitcount
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/n_hitcount
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/misscount
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/n_misscount
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/flushcount
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/n_flushcount
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/way0
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/n_way0
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/way1
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/n_way1
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/addr
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/snoopaddr
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/tag
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/idx
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/blkoff
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/bytoff
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/sel0
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/sel1
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/hit
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/dirty
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/dirtyflush
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/selblock
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/data
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/rused
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/n_rused
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/n_dREN
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/n_dWEN
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/n_daddr
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/n_dstore
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/ccway0
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/ccway1
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/state
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/n_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {78 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 263
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
WaveRestoreZoom {0 ns} {457 ns}
