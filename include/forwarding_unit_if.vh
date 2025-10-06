/*
  Forwarding Unit Interface
*/

`ifndef FORWARDING_UNIT_IF_VH
`define FORWARDING_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface forwarding_unit_if;
    // import types
    import cpu_types_pkg::*;

    logic [4:0] rs1_EX, rs2_EX, wsel_MEM, wsel_WB;
    logic RegWr_MEM, RegWr_WB;
    logic [1:0] ForwardA, ForwardB;

    // forwarding unit ports
    modport frwd (
        input rs1_EX, rs2_EX, wsel_MEM, wsel_WB, RegWr_MEM, RegWr_WB,
        output ForwardA, ForwardB
    );

    modport tb (
        output rs1_EX, rs2_EX, wsel_MEM, wsel_WB, RegWr_MEM, RegWr_WB,
        input ForwardA, ForwardB
    );
endinterface

`endif // FORWARDING_UNIT_IF_VH