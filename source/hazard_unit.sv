// interface include
`include "hazard_unit_if.vh"

// all types
`include "cpu_types_pkg.vh"

module hazard_unit (
    hazard_unit_if.hu huif
);

// type import
import cpu_types_pkg::*;

always_comb begin
    huif.ctrlFlush = 1'b0;
    huif.PCWrite = 1'b0;
    huif.Write_IF_ID = 1'b0;
    if ((huif.MemRead_EX) && ((huif.rsel1_ID == huif.wsel_EX) || (huif.rsel2_ID == huif.wsel_EX))) begin
        huif.ctrlFlush = 1'b1;
        huif.PCWrite = 1'b1;
        huif.Write_IF_ID = 1'b1;
    end
end
    
endmodule