// interface include
`include "if_id_register_if.vh"

// all types
`include "cpu_types_pkg.vh"

module if_id_register (
    input CLK, nRST,
    if_id_register_if.ifid ifidif
);

// type import
import cpu_types_pkg::*;

word_t next_pc_ID, next_instr_ID;
logic next_j_en_ID, next_b_en_ID;

// IF/ID Register
always_ff @(posedge CLK, negedge nRST) begin
    if(!nRST) begin
        ifidif.pc_ID <= 0;
        ifidif.instr_ID <= 0;
        ifidif.j_en_ID <= 0;
        ifidif.b_en_ID <= 0;
    end
    else begin
        if(ifidif.flush_IF_ID && ifidif.pipeline_ctrl) begin
            ifidif.pc_ID <= 0;
            ifidif.instr_ID <= 0;
            ifidif.j_en_ID <= 0;
            ifidif.b_en_ID <= 0;
        end
        else begin
            ifidif.pc_ID <= next_pc_ID;
            ifidif.instr_ID <= next_instr_ID;
            ifidif.j_en_ID <= next_j_en_ID;
            ifidif.b_en_ID <= next_b_en_ID;
        end
    end
end


// Next Logic
always_comb begin
    next_pc_ID = ifidif.pc_ID;
    next_instr_ID = ifidif.instr_ID;
    next_j_en_ID = ifidif.j_en_ID;
    next_b_en_ID = ifidif.b_en_ID;

    if(ifidif.pipeline_ctrl && !ifidif.Write_IF_ID) begin
        next_pc_ID = ifidif.pc;
        next_instr_ID = ifidif.instr;
        next_j_en_ID = ifidif.j_en;
        next_b_en_ID = ifidif.b_en;
    end
end

endmodule