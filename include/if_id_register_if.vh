/*
  IF/ID Register Interface
*/

`ifndef IF_ID_REGISTER_IF_VH
`define IF_ID_REGISTER_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface if_id_register_if;
    // import types
    import cpu_types_pkg::*;

    logic Write_IF_ID;
    word_t pc, instr, pc_ID, instr_ID;
    logic flush_IF_ID, j_en, b_en, j_en_ID, b_en_ID, pipeline_ctrl;

    // IF/ID register ports
    modport ifid (
        input Write_IF_ID, pc, instr, flush_IF_ID, j_en, b_en, pipeline_ctrl,
        output pc_ID, instr_ID, j_en_ID, b_en_ID
    );
endinterface

`endif // IF_ID_REGISTER_IF_VH