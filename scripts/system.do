onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CLK
add wave -noupdate /system_tb/DUT/nRST
add wave -noupdate /system_tb/DUT/CPU/DP0/pcif/pc
add wave -noupdate /system_tb/DUT/CPU/DP0/PC/next_pc
add wave -noupdate /system_tb/DUT/CPU/DP1/pcif/pc
add wave -noupdate /system_tb/DUT/CPU/DP1/PC/next_pc
add wave -noupdate /system_tb/DUT/CPU/DP0/REGF/regs
add wave -noupdate /system_tb/DUT/CPU/DP1/REGF/regs
add wave -noupdate -expand -group DCIF0 /system_tb/DUT/CPU/dcif0/halt
add wave -noupdate -expand -group DCIF0 /system_tb/DUT/CPU/dcif0/ihit
add wave -noupdate -expand -group DCIF0 /system_tb/DUT/CPU/dcif0/imemREN
add wave -noupdate -expand -group DCIF0 /system_tb/DUT/CPU/dcif0/imemload
add wave -noupdate -expand -group DCIF0 /system_tb/DUT/CPU/dcif0/imemaddr
add wave -noupdate -expand -group DCIF0 /system_tb/DUT/CPU/dcif0/dhit
add wave -noupdate -expand -group DCIF0 /system_tb/DUT/CPU/dcif0/datomic
add wave -noupdate -expand -group DCIF0 /system_tb/DUT/CPU/dcif0/dmemREN
add wave -noupdate -expand -group DCIF0 /system_tb/DUT/CPU/dcif0/dmemWEN
add wave -noupdate -expand -group DCIF0 /system_tb/DUT/CPU/dcif0/flushed
add wave -noupdate -expand -group DCIF0 /system_tb/DUT/CPU/dcif0/dmemload
add wave -noupdate -expand -group DCIF0 /system_tb/DUT/CPU/dcif0/dmemstore
add wave -noupdate -expand -group DCIF0 /system_tb/DUT/CPU/dcif0/dmemaddr
add wave -noupdate -expand -group DCIF1 /system_tb/DUT/CPU/dcif1/halt
add wave -noupdate -expand -group DCIF1 /system_tb/DUT/CPU/dcif1/ihit
add wave -noupdate -expand -group DCIF1 /system_tb/DUT/CPU/dcif1/imemREN
add wave -noupdate -expand -group DCIF1 /system_tb/DUT/CPU/dcif1/imemload
add wave -noupdate -expand -group DCIF1 /system_tb/DUT/CPU/dcif1/imemaddr
add wave -noupdate -expand -group DCIF1 /system_tb/DUT/CPU/dcif1/dhit
add wave -noupdate -expand -group DCIF1 /system_tb/DUT/CPU/dcif1/datomic
add wave -noupdate -expand -group DCIF1 /system_tb/DUT/CPU/dcif1/dmemREN
add wave -noupdate -expand -group DCIF1 /system_tb/DUT/CPU/dcif1/dmemWEN
add wave -noupdate -expand -group DCIF1 /system_tb/DUT/CPU/dcif1/flushed
add wave -noupdate -expand -group DCIF1 /system_tb/DUT/CPU/dcif1/dmemload
add wave -noupdate -expand -group DCIF1 /system_tb/DUT/CPU/dcif1/dmemstore
add wave -noupdate -expand -group DCIF1 /system_tb/DUT/CPU/dcif1/dmemaddr
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -expand -group CCIF -expand /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -expand -group CCIF -expand /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/ccwait
add wave -noupdate -expand -group CCIF -expand /system_tb/DUT/CPU/ccif/ccinv
add wave -noupdate -expand -group CCIF -expand /system_tb/DUT/CPU/ccif/ccwrite
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/cctrans
add wave -noupdate -expand -group CCIF -expand /system_tb/DUT/CPU/ccif/ccsnoopaddr
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -expand -group CCIF /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/CLK
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/nRST
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/hitcount
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/n_hitcount
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/misscount
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/n_misscount
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/flushcount
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/n_flushcount
add wave -noupdate -expand -group DCACHE0 -expand -subitemconfig {{/system_tb/DUT/CPU/CM0/DCACHE/way0[0]} -expand} /system_tb/DUT/CPU/CM0/DCACHE/way0
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/n_way0
add wave -noupdate -expand -group DCACHE0 -expand /system_tb/DUT/CPU/CM0/DCACHE/way1
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/n_way1
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/addr
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoopaddr
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/tag
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/idx
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/blkoff
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/bytoff
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/sel0
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/sel1
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/hit
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/dirty
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/dirtyflush
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/selblock
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/data
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/rused
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/n_rused
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/n_dREN
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/n_dWEN
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/n_daddr
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/n_dstore
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/ccway0
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/ccway1
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/state
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/n_state
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/sc_valid
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/resvalid
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/resset
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/CLK
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/nRST
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/hitcount
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/n_hitcount
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/misscount
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/n_misscount
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/flushcount
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/n_flushcount
add wave -noupdate -expand -group DCACHE1 -expand -subitemconfig {{/system_tb/DUT/CPU/CM1/DCACHE/way0[0]} -expand} /system_tb/DUT/CPU/CM1/DCACHE/way0
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/n_way0
add wave -noupdate -expand -group DCACHE1 -expand /system_tb/DUT/CPU/CM1/DCACHE/way1
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/n_way1
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/addr
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoopaddr
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/tag
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/idx
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/blkoff
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/bytoff
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/sel0
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/sel1
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/hit
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/dirty
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/dirtyflush
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/selblock
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/data
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/rused
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/n_rused
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/n_dREN
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/n_dWEN
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/n_daddr
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/n_dstore
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/ccway0
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/ccway1
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/state
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/n_state
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/cif/ccwait
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/cif/ccinv
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/cif/ccwrite
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/cif/cctrans
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/cif/ccsnoopaddr
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/sc_valid
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/resvalid
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/resset
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP0/aluif/aluop
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP0/aluif/porta
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP0/aluif/portb
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP0/aluif/portout
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP0/aluif/negative
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP0/aluif/overflow
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP0/aluif/zero
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/pc_EX
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/instr_EX
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/alu_out
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/busB
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/imm_EX
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/pc_MEM
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/instr_MEM
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/alu_out_MEM
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/busB_MEM
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/imm_MEM
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/dmemload
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/dmem_out_reg
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/dhit
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/flush_EX_MEM
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/b_en_EX
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/zero
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/b_en_MEM
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/zero_MEM
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/wsel_EX
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/wsel_MEM
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/MemWr_EX
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/MemRead_EX
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/MemtoReg_EX
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/RegWr_EX
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/MemWr_MEM
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/MemRead_MEM
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/MemtoReg_MEM
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/RegWr_MEM
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/WriteSrc_EX
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/WriteSrc_MEM
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/is_halt_EX
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/is_halt_MEM
add wave -noupdate -expand -group EXMEMIF0 /system_tb/DUT/CPU/DP0/exmemif/pipeline_ctrl
add wave -noupdate /system_tb/DUT/CPU/DP0/busB
add wave -noupdate /system_tb/DUT/CPU/DP0/busA
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/pc_MEM
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/dmem_out
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/alu_out_MEM
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/imm_MEM
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/pc_WB
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/dmem_out_WB
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/alu_out_WB
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/imm_WB
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/wsel_MEM
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/wsel_WB
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/MemtoReg_MEM
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/RegWr_MEM
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/MemtoReg_WB
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/RegWr_WB
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/WriteSrc_MEM
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/WriteSrc_WB
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/dcache_active
add wave -noupdate -expand -group MEMWB0 /system_tb/DUT/CPU/DP0/memwbif/pipeline_ctrl
add wave -noupdate -expand -group FUIF0 /system_tb/DUT/CPU/DP0/fuif/rs1_EX
add wave -noupdate -expand -group FUIF0 /system_tb/DUT/CPU/DP0/fuif/rs2_EX
add wave -noupdate -expand -group FUIF0 /system_tb/DUT/CPU/DP0/fuif/wsel_MEM
add wave -noupdate -expand -group FUIF0 /system_tb/DUT/CPU/DP0/fuif/wsel_WB
add wave -noupdate -expand -group FUIF0 /system_tb/DUT/CPU/DP0/fuif/RegWr_MEM
add wave -noupdate -expand -group FUIF0 /system_tb/DUT/CPU/DP0/fuif/RegWr_WB
add wave -noupdate -expand -group FUIF0 /system_tb/DUT/CPU/DP0/fuif/ForwardA
add wave -noupdate -expand -group FUIF0 /system_tb/DUT/CPU/DP0/fuif/ForwardB
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/pc_ID
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/instr_ID
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/rdat1
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/rdat2
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/imm
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/pc_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/instr_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/rdat1_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/rdat2_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/imm_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/flush_ID_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/j_en_ID
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/b_en_ID
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/j_en_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/b_en_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/wsel
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/rs1
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/rs2
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/wsel_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/rs1_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/rs2_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/ALUOp
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/ALUOp_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/ALUSrc
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/MemWr
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/MemRead
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/MemtoReg
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/RegWr
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/ALUSrc_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/MemWr_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/MemRead_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/MemtoReg_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/RegWr_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/WriteSrc
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/WriteSrc_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/is_halt
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/is_halt_EX
add wave -noupdate -expand -group IDEXIF0 /system_tb/DUT/CPU/DP0/idexif/pipeline_ctrl
add wave -noupdate /system_tb/DUT/CPU/DP0/wdat
add wave -noupdate -expand -group {Mem Control} /system_tb/DUT/CPU/CC/CLK
add wave -noupdate -expand -group {Mem Control} /system_tb/DUT/CPU/CC/nRST
add wave -noupdate -expand -group {Mem Control} /system_tb/DUT/CPU/CC/state
add wave -noupdate -expand -group {Mem Control} /system_tb/DUT/CPU/CC/next_state
add wave -noupdate -expand -group {Mem Control} /system_tb/DUT/CPU/CC/core
add wave -noupdate -expand -group {Mem Control} /system_tb/DUT/CPU/CC/next_core
add wave -noupdate -expand -group {Mem Control} /system_tb/DUT/CPU/CC/lrc
add wave -noupdate -expand -group {Mem Control} /system_tb/DUT/CPU/CC/next_lrc
add wave -noupdate -expand -group {Mem Control} /system_tb/DUT/CPU/CC/reg_ccsnoopaddr
add wave -noupdate -expand -group {Mem Control} /system_tb/DUT/CPU/CC/next_reg_ccsnoopaddr
add wave -noupdate -expand -group {Mem Control} /system_tb/DUT/CPU/CC/reg_ccinv
add wave -noupdate -expand -group {Mem Control} /system_tb/DUT/CPU/CC/next_reg_ccinv
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/PCWrite
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/instr
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/instr_EX
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/instr_MEM
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/pc
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/pc_EX
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/pc_MEM
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/imm_EX
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/imm_MEM
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/rdat1_EX
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/j_en
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/b_en
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/flush_IF_ID
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/flush_ID_EX
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/flush_EX_MEM
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/b_en_MEM
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/j_en_EX
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/zero_MEM
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/pcif/pipeline_ctrl
add wave -noupdate -expand -group PCIF0 /system_tb/DUT/CPU/DP0/PC/branch_type_MEM
add wave -noupdate /system_tb/DUT/CPU/DP1/exmemif/instr_MEM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {526663688 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 221
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
WaveRestoreZoom {525614740 ps} {528089140 ps}
