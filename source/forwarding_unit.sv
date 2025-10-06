// interface include
`include "forwarding_unit_if.vh"

// all types
`include "cpu_types_pkg.vh"

module forwarding_unit (
    forwarding_unit_if.frwd fuif
);

// type import
import cpu_types_pkg::*;

always_comb begin

    fuif.ForwardA = 2'b00;
    fuif.ForwardB = 2'b00;

    if(fuif.RegWr_MEM && (fuif.wsel_MEM != 0)) begin
        if(fuif.wsel_MEM == fuif.rs1_EX)
            fuif.ForwardA = 2'b01;
        if(fuif.wsel_MEM == fuif.rs2_EX)
            fuif.ForwardB = 2'b01;
    end
    
    if((fuif.wsel_MEM != fuif.wsel_WB) && fuif.RegWr_WB && (fuif.wsel_WB != 0)) begin
        if(fuif.wsel_WB == fuif.rs1_EX)
            fuif.ForwardA = 2'b10;
        if(fuif.wsel_WB == fuif.rs2_EX)
            fuif.ForwardB = 2'b10;
    end
end

endmodule