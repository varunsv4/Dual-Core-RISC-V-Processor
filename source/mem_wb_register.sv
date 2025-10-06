// interface include
`include "mem_wb_register_if.vh"

// all types
`include "cpu_types_pkg.vh"

module mem_wb_register (
    input CLK, nRST,
    mem_wb_register_if.memwb memwbif
);

// type import
import cpu_types_pkg::*;

word_t next_pc_WB, next_dmem_out_WB, next_alu_out_WB, next_imm_WB;
logic [4:0] next_wsel_WB;
logic next_MemtoReg_WB, next_RegWr_WB;
logic [1:0] next_WriteSrc_WB;

// MEM/WB Register
always_ff @(posedge CLK, negedge nRST) begin
    if(!nRST) begin
        memwbif.pc_WB <= 0;
        memwbif.dmem_out_WB <= 0;
        memwbif.alu_out_WB <= 0;
        memwbif.imm_WB <= 0;
        memwbif.wsel_WB <= 0;
        memwbif.MemtoReg_WB <= 0;
        memwbif.RegWr_WB <= 0;
        memwbif.WriteSrc_WB <= 0;
    end
    else begin
        memwbif.pc_WB <= next_pc_WB;
        memwbif.dmem_out_WB <= next_dmem_out_WB;
        memwbif.alu_out_WB <= next_alu_out_WB;
        memwbif.imm_WB <= next_imm_WB;
        memwbif.wsel_WB <= next_wsel_WB;
        memwbif.MemtoReg_WB <= next_MemtoReg_WB;
        memwbif.RegWr_WB <= next_RegWr_WB;
        memwbif.WriteSrc_WB <= next_WriteSrc_WB;
    end
end


// Next Logic
always_comb begin
    next_pc_WB = memwbif.pc_WB;
    next_dmem_out_WB = memwbif.dmem_out_WB;
    next_alu_out_WB = memwbif.alu_out_WB;
    next_imm_WB = memwbif.imm_WB;
    next_wsel_WB = memwbif.wsel_WB;
    next_MemtoReg_WB = memwbif.MemtoReg_WB;
    next_RegWr_WB = memwbif.RegWr_WB;
    next_WriteSrc_WB = memwbif.WriteSrc_WB;

    if(memwbif.pipeline_ctrl) begin
        next_pc_WB = memwbif.pc_MEM;
        next_dmem_out_WB = memwbif.dmem_out;
        next_alu_out_WB = memwbif.alu_out_MEM;
        next_imm_WB = memwbif.imm_MEM;
        next_wsel_WB = memwbif.wsel_MEM;
        next_MemtoReg_WB = memwbif.MemtoReg_MEM;
        next_RegWr_WB = memwbif.RegWr_MEM;
        next_WriteSrc_WB = memwbif.WriteSrc_MEM;
    end
end

endmodule