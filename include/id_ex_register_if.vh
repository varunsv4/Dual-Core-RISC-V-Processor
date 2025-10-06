/*
  ID/EX Register Interface
*/

`ifndef ID_EX_REGISTER_IF_VH
`define ID_EX_REGISTER_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface id_ex_register_if;
    // import types
    import cpu_types_pkg::*;

    word_t pc_ID, instr_ID, rdat1, rdat2, imm, pc_EX, instr_EX, rdat1_EX, rdat2_EX, imm_EX;
    logic flush_ID_EX, j_en_ID, b_en_ID, j_en_EX, b_en_EX;
    logic [4:0] wsel, rs1, rs2, wsel_EX, rs1_EX, rs2_EX;
    aluop_t ALUOp, ALUOp_EX;
    logic ALUSrc, MemWr, MemRead, MemtoReg, RegWr, ALUSrc_EX, MemWr_EX, MemRead_EX, MemtoReg_EX, RegWr_EX;
    logic [1:0] WriteSrc, WriteSrc_EX;
    logic is_halt, is_halt_EX, pipeline_ctrl, datomic, datomic_EX;

    // ID/EX register ports
    modport idex (
        input pc_ID, instr_ID, rdat1, rdat2, imm, j_en_ID, b_en_ID, wsel, rs1, rs2, flush_ID_EX, ALUOp, ALUSrc, MemWr, MemRead, MemtoReg, RegWr, WriteSrc, is_halt, pipeline_ctrl, datomic,
        output pc_EX, instr_EX, rdat1_EX, rdat2_EX, imm_EX, j_en_EX, b_en_EX, wsel_EX, rs1_EX, rs2_EX, ALUOp_EX, ALUSrc_EX, MemWr_EX, MemRead_EX, MemtoReg_EX, RegWr_EX, WriteSrc_EX, is_halt_EX, datomic_EX
    );
endinterface

`endif // ID_EX_REGISTER_IF_VH