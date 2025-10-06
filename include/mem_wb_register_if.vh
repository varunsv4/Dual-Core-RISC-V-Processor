/*
  MEM/WB Register Interface
*/

`ifndef MEM_WB_REGISTER_IF_VH
`define MEM_WB_REGISTER_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface mem_wb_register_if;
    // import types
    import cpu_types_pkg::*;

    word_t pc_MEM, dmem_out, alu_out_MEM, imm_MEM, pc_WB, dmem_out_WB, alu_out_WB, imm_WB;
    logic [4:0] wsel_MEM, wsel_WB;
    logic MemtoReg_MEM, RegWr_MEM, MemtoReg_WB, RegWr_WB;
    logic [1:0] WriteSrc_MEM, WriteSrc_WB, dcache_active, pipeline_ctrl;

    // MEM/WB register ports
    modport memwb (
        input pc_MEM, dmem_out, alu_out_MEM, imm_MEM, wsel_MEM, MemtoReg_MEM, RegWr_MEM, WriteSrc_MEM, pipeline_ctrl,
        output pc_WB, dmem_out_WB, alu_out_WB, imm_WB, wsel_WB, MemtoReg_WB, RegWr_WB, WriteSrc_WB
    );
endinterface

`endif // MEM_WB_REGISTER_IF_VH