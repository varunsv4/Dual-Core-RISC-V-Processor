/*
  Hazard Unit Interface
*/

`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
    // import types
    import cpu_types_pkg::*;

    logic MemRead_EX;
    logic [4:0] wsel_EX, rsel1_ID, rsel2_ID;
    logic ctrlFlush, PCWrite, Write_IF_ID;

    modport hu (
        input MemRead_EX, wsel_EX, rsel1_ID, rsel2_ID,
        output ctrlFlush, PCWrite, Write_IF_ID
    );
    modport tb (
        output MemRead_EX, wsel_EX, rsel1_ID, rsel2_ID,
        input ctrlFlush, PCWrite, Write_IF_ID
    );
endinterface

`endif // HAZARD_UNIT_IF_VH