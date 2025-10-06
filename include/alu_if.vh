/*
  Arithmetic Logic Unit interface
*/
`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
    // import types
    import cpu_types_pkg::*;

    aluop_t aluop;
    word_t porta, portb, portout;
    logic negative, overflow, zero;

    // alu ports
    modport alu (
        input   aluop, porta, portb,
        output  negative, portout, overflow, zero
    );
    // alu tb
    modport tb (
        input   negative, portout, overflow, zero,
        output  aluop, porta, portb
    );
endinterface

`endif //ALU_IF_VH
