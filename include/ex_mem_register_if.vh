/*
  EX/MEM Register Interface
*/

`ifndef EX_MEM_REGISTER_IF_VH
`define EX_MEM_REGISTER_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface ex_mem_register_if;
    // import types
    import cpu_types_pkg::*;

    word_t pc_EX, instr_EX, alu_out, busB, imm_EX, pc_MEM, instr_MEM, alu_out_MEM, busB_MEM, imm_MEM, dmemload, dmem_out_reg;
    logic dhit, flush_EX_MEM, b_en_EX, zero, b_en_MEM, zero_MEM;
    logic [4:0] wsel_EX, wsel_MEM;
    logic MemWr_EX, MemRead_EX, MemtoReg_EX, RegWr_EX, MemWr_MEM, MemRead_MEM, MemtoReg_MEM, RegWr_MEM;
    logic [1:0] WriteSrc_EX, WriteSrc_MEM;
    logic is_halt_EX, is_halt_MEM, pipeline_ctrl, datomic_EX, datomic_MEM;

    // EX/MEM register ports
    modport exmem (
        input pc_EX, instr_EX, alu_out, busB, imm_EX, dmemload, dhit, flush_EX_MEM, b_en_EX, zero, wsel_EX, MemWr_EX, MemRead_EX, MemtoReg_EX, RegWr_EX, WriteSrc_EX, is_halt_EX, pipeline_ctrl, datomic_EX,
        output pc_MEM, instr_MEM, alu_out_MEM, busB_MEM, imm_MEM, dmem_out_reg, b_en_MEM, zero_MEM, wsel_MEM, MemWr_MEM, MemRead_MEM, MemtoReg_MEM, RegWr_MEM, WriteSrc_MEM, is_halt_MEM, datomic_MEM
    );
endinterface

`endif // EX_MEM_REGISTER_IF_VH