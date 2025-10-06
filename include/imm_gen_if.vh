/*
  Immediate Generator Interface
*/

`ifndef IMM_GEN_IF_VH
`define IMM_GEN_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface imm_gen_if;
    // import types
    import cpu_types_pkg::*;

    word_t instruction, imm;

    // imm gen ports
    modport gen (
        input instruction,
        output imm
    );
endinterface

`endif // IMM_GEN_IF_VH