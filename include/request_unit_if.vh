/*
  Request Unit Interface
*/

`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
    // import types
    import cpu_types_pkg::*;

    logic ihit, dhit, MemWrite, MemRead, is_halted;
    logic imemREN, dmemREN, dmemWEN;

    // request unit ports
    modport ru (
        input ihit, dhit, MemWrite, MemRead, is_halted,
        output imemREN, dmemREN, dmemWEN
    );
endinterface

`endif // REQUEST_UNIT_IF_VH