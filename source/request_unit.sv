// interface include
`include "request_unit_if.vh"

// all types
`include "cpu_types_pkg.vh"

module request_unit (
    input CLK, nRST,
    request_unit_if.ru ruif
);

// type import
import cpu_types_pkg::*;

logic next_imemREN, next_dmemREN, next_dmemWEN;

// Output Signals Registers
always_ff @(posedge CLK, negedge nRST) begin
    if(!nRST) begin
        ruif.imemREN <= 1;
        ruif.dmemREN <= 0;
        ruif.dmemWEN <= 0;
    end
    else begin
        ruif.imemREN <= next_imemREN;
        ruif.dmemREN <= next_dmemREN;
        ruif.dmemWEN <= next_dmemWEN;
    end
end

// Output Signals Next State Logic
always_comb begin
    next_imemREN = !ruif.is_halted;
    next_dmemREN = ruif.dmemREN;
    next_dmemWEN = ruif.dmemWEN;

    if(ruif.ihit) begin
        next_dmemWEN = ruif.MemWrite;
        next_dmemREN = ruif.MemRead;
    end

    if(ruif.dhit) begin
        if(ruif.dmemWEN)
            next_dmemWEN = 0;
        else if(ruif.dmemREN)
            next_dmemREN = 0;
    end
end

endmodule