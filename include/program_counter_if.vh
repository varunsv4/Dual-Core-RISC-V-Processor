/*
  Program Counter Interface
*/

`ifndef PROGRAM_COUNTER_IF_VH
`define PROGRAM_COUNTER_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface program_counter_if;
    // import types
    import cpu_types_pkg::*;

    logic PCWrite;
    word_t instr, instr_EX, instr_MEM, pc, pc_EX, pc_MEM, imm_EX, imm_MEM, rdat1_EX;
    logic j_en, b_en, flush_IF_ID, flush_ID_EX, flush_EX_MEM, b_en_MEM, j_en_EX, zero_MEM, pipeline_ctrl;

    // program counter ports
    modport pcr (
        input PCWrite, instr, instr_EX, instr_MEM, pc_EX, pc_MEM, imm_EX, imm_MEM, rdat1_EX, b_en_MEM, j_en_EX, zero_MEM, pipeline_ctrl,
        output pc, j_en, b_en, flush_IF_ID, flush_ID_EX, flush_EX_MEM
    );
endinterface

`endif // PROGRAM_COUNTER_IF_VH