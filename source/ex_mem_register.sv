// interface include
`include "ex_mem_register_if.vh"

// all types
`include "cpu_types_pkg.vh"

module ex_mem_register (
    input CLK, nRST,
    ex_mem_register_if.exmem exmemif
);

// type import
import cpu_types_pkg::*;

word_t next_pc_MEM, next_instr_MEM, next_alu_out_MEM, next_busB_MEM, next_imm_MEM, dmem_out_reg, next_dmem_out_reg;
logic next_b_en_MEM, next_zero_MEM;
logic [4:0] next_wsel_MEM;
logic next_MemWr_MEM, next_MemRead_MEM, next_MemtoReg_MEM, next_RegWr_MEM;
logic [1:0] next_WriteSrc_MEM;
logic next_is_halt_MEM, next_datomic_MEM;

// EX/MEM Register
always_ff @(posedge CLK, negedge nRST) begin
    if(!nRST) begin
        exmemif.pc_MEM <= 0;
        exmemif.instr_MEM <= 0;
        exmemif.alu_out_MEM <= 0;
        exmemif.busB_MEM <= 0;
        exmemif.imm_MEM <= 0;
        exmemif.b_en_MEM <= 0;
        exmemif.zero_MEM <= 0;
        exmemif.wsel_MEM <= 0;
        exmemif.MemWr_MEM <= 0;
        exmemif.MemRead_MEM <= 0;
        exmemif.MemtoReg_MEM <= 0;
        exmemif.RegWr_MEM <= 0;
        exmemif.WriteSrc_MEM <= 0;
        exmemif.is_halt_MEM <= 0;
        exmemif.dmem_out_reg <= 0;
        exmemif.datomic_MEM <= 0;
    end
    else begin
        if(exmemif.flush_EX_MEM && exmemif.pipeline_ctrl) begin
            exmemif.pc_MEM <= 0;
            exmemif.instr_MEM <= 0;
            exmemif.alu_out_MEM <= 0;
            exmemif.busB_MEM <= 0;
            exmemif.imm_MEM <= 0;
            exmemif.b_en_MEM <= 0;
            exmemif.zero_MEM <= 0;
            exmemif.wsel_MEM <= 0;
            exmemif.MemWr_MEM <= 0;
            exmemif.MemRead_MEM <= 0;
            exmemif.MemtoReg_MEM <= 0;
            exmemif.RegWr_MEM <= 0;
            exmemif.WriteSrc_MEM <= 0;
            exmemif.is_halt_MEM <= 0;
            exmemif.dmem_out_reg <= 0;
            exmemif.datomic_MEM <= 0;
        end
        else begin
            exmemif.pc_MEM <= next_pc_MEM;
            exmemif.instr_MEM <= next_instr_MEM;
            exmemif.alu_out_MEM <= next_alu_out_MEM;
            exmemif.busB_MEM <= next_busB_MEM;
            exmemif.imm_MEM <= next_imm_MEM;
            exmemif.b_en_MEM <= next_b_en_MEM;
            exmemif.zero_MEM <= next_zero_MEM;
            exmemif.wsel_MEM <= next_wsel_MEM;
            exmemif.MemWr_MEM <= next_MemWr_MEM;
            exmemif.MemRead_MEM <= next_MemRead_MEM;
            exmemif.MemtoReg_MEM <= next_MemtoReg_MEM;
            exmemif.RegWr_MEM <= next_RegWr_MEM;
            exmemif.WriteSrc_MEM <= next_WriteSrc_MEM;
            exmemif.is_halt_MEM <= next_is_halt_MEM;
            exmemif.dmem_out_reg <= next_dmem_out_reg;
            exmemif.datomic_MEM <= next_datomic_MEM;
        end
    end
end


// Next Logic
always_comb begin
    next_pc_MEM = exmemif.pc_MEM;
    next_instr_MEM = exmemif.instr_MEM;
    next_alu_out_MEM = exmemif.alu_out_MEM;
    next_busB_MEM = exmemif.busB_MEM;
    next_imm_MEM = exmemif.imm_MEM;
    next_b_en_MEM = exmemif.b_en_MEM;
    next_zero_MEM = exmemif.zero_MEM;
    next_wsel_MEM = exmemif.wsel_MEM;
    next_MemWr_MEM = exmemif.MemWr_MEM;
    next_MemRead_MEM = exmemif.MemRead_MEM;
    next_MemtoReg_MEM = exmemif.MemtoReg_MEM;
    next_RegWr_MEM = exmemif.RegWr_MEM;
    next_WriteSrc_MEM = exmemif.WriteSrc_MEM;
    next_is_halt_MEM = exmemif.is_halt_MEM;
    next_dmem_out_reg = exmemif.dmem_out_reg;
    next_datomic_MEM = exmemif.datomic_MEM;

    if(exmemif.pipeline_ctrl) begin
        next_pc_MEM = exmemif.pc_EX;
        next_instr_MEM = exmemif.instr_EX;
        next_alu_out_MEM = exmemif.alu_out;
        next_busB_MEM = exmemif.busB;
        next_imm_MEM = exmemif.imm_EX;
        next_b_en_MEM = exmemif.b_en_EX;
        next_zero_MEM = exmemif.zero;
        next_wsel_MEM = exmemif.wsel_EX;
        next_MemWr_MEM = exmemif.MemWr_EX;
        next_MemRead_MEM = exmemif.MemRead_EX;
        next_MemtoReg_MEM = exmemif.MemtoReg_EX;
        next_RegWr_MEM = exmemif.RegWr_EX;
        next_WriteSrc_MEM = exmemif.WriteSrc_EX;
        next_is_halt_MEM = exmemif.is_halt_EX;
        next_datomic_MEM = exmemif.datomic_EX;
    end
    else if(exmemif.dhit && !exmemif.pipeline_ctrl) begin
        next_MemWr_MEM = 0;
        next_MemRead_MEM = 0;
        next_dmem_out_reg = exmemif.dmemload;
    end
end

endmodule