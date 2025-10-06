/*
  Control Unit Interface
*/

`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
    // import types
    import cpu_types_pkg::*;

    word_t instruction;
    aluop_t ALUOp;
    logic ALUSrc, MemWr, MemRead, MemtoReg, RegWr, is_halt, datomic;
    logic [1:0] WriteSrc;

    // control unit ports
    modport ctrl (
        input instruction,
        output ALUOp, ALUSrc, MemWr, MemRead, MemtoReg, RegWr, WriteSrc, is_halt, datomic
    );
endinterface

`endif // CONTROL_UNIT_IF_VH