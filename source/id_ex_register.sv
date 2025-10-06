// interface include
`include "id_ex_register_if.vh"

// all types
`include "cpu_types_pkg.vh"

module id_ex_register (
    input CLK, nRST,
    id_ex_register_if.idex idexif
);

// type import
import cpu_types_pkg::*;

word_t next_pc_EX, next_instr_EX, next_rdat1_EX, next_rdat2_EX, next_imm_EX;
logic next_j_en_EX, next_b_en_EX;
logic [4:0] next_wsel_EX, next_rs1_EX, next_rs2_EX;
aluop_t next_ALUOp_EX;
logic next_ALUSrc_EX, next_MemWr_EX, next_MemRead_EX, next_MemtoReg_EX, next_RegWr_EX;
logic [2:0] next_WriteSrc_EX;
logic next_is_halt_EX, next_datomic_EX;

// ID/EX Register
always_ff @(posedge CLK, negedge nRST) begin
    if(!nRST) begin
        idexif.pc_EX <= 0;
        idexif.instr_EX <= 0;
        idexif.rdat1_EX <= 0;
        idexif.rdat2_EX <= 0;
        idexif.imm_EX <= 0;
        idexif.j_en_EX <= 0;
        idexif.b_en_EX <= 0;
        idexif.wsel_EX <= 0;
        idexif.rs1_EX <= 0;
        idexif.rs2_EX <= 0;
        idexif.ALUOp_EX <= aluop_t'(0);
        idexif.ALUSrc_EX <= 0;
        idexif.MemWr_EX <= 0;
        idexif.MemRead_EX <= 0;
        idexif.MemtoReg_EX <= 0;
        idexif.RegWr_EX <= 0;
        idexif.WriteSrc_EX <= 0;
        idexif.is_halt_EX <= 0;
        idexif.datomic_EX <= 0;
    end
    else begin
        if(idexif.flush_ID_EX && idexif.pipeline_ctrl) begin
            idexif.pc_EX <= 0;
            idexif.instr_EX <= 0;
            idexif.rdat1_EX <= 0;
            idexif.rdat2_EX <= 0;
            idexif.imm_EX <= 0;
            idexif.j_en_EX <= 0;
            idexif.b_en_EX <= 0;
            idexif.wsel_EX <= 0;
            idexif.rs1_EX <= 0;
            idexif.rs2_EX <= 0;
            idexif.ALUOp_EX <= aluop_t'(0);
            idexif.ALUSrc_EX <= 0;
            idexif.MemWr_EX <= 0;
            idexif.MemRead_EX <= 0;
            idexif.MemtoReg_EX <= 0;
            idexif.RegWr_EX <= 0;
            idexif.WriteSrc_EX <= 0;
            idexif.is_halt_EX <= 0;
            idexif.datomic_EX <= 0; 
        end
        else begin
            idexif.pc_EX <= next_pc_EX;
            idexif.instr_EX <= next_instr_EX;
            idexif.rdat1_EX <= next_rdat1_EX;
            idexif.rdat2_EX <= next_rdat2_EX;
            idexif.imm_EX <= next_imm_EX;
            idexif.j_en_EX <= next_j_en_EX;
            idexif.b_en_EX <= next_b_en_EX;
            idexif.wsel_EX <= next_wsel_EX;
            idexif.rs1_EX <= next_rs1_EX;
            idexif.rs2_EX <= next_rs2_EX;
            idexif.ALUOp_EX <= next_ALUOp_EX;
            idexif.ALUSrc_EX <= next_ALUSrc_EX;
            idexif.MemWr_EX <= next_MemWr_EX;
            idexif.MemRead_EX <= next_MemRead_EX;
            idexif.MemtoReg_EX <= next_MemtoReg_EX;
            idexif.RegWr_EX <= next_RegWr_EX;
            idexif.WriteSrc_EX <= next_WriteSrc_EX;
            idexif.is_halt_EX <= next_is_halt_EX;
            idexif.datomic_EX <= next_datomic_EX;
        end
    end
end


// Next Logic
always_comb begin
    next_pc_EX = idexif.pc_EX;
    next_instr_EX = idexif.instr_EX;
    next_rdat1_EX = idexif.rdat1_EX;
    next_rdat2_EX = idexif.rdat2_EX;
    next_imm_EX = idexif.imm_EX;
    next_j_en_EX = idexif.j_en_EX;
    next_b_en_EX = idexif.b_en_EX;
    next_wsel_EX = idexif.wsel_EX;
    next_rs1_EX = idexif.rs1_EX;
    next_rs2_EX = idexif.rs2_EX;
    next_ALUOp_EX = idexif.ALUOp_EX;
    next_ALUSrc_EX = idexif.ALUSrc_EX;
    next_MemWr_EX = idexif.MemWr_EX;
    next_MemRead_EX = idexif.MemRead_EX;
    next_MemtoReg_EX = idexif.MemtoReg_EX;
    next_RegWr_EX = idexif.RegWr_EX;
    next_WriteSrc_EX = idexif.WriteSrc_EX;
    next_is_halt_EX = idexif.is_halt_EX;
    next_datomic_EX = idexif.datomic_EX;

    if(idexif.pipeline_ctrl) begin
        next_pc_EX = idexif.pc_ID;
        next_instr_EX = idexif.instr_ID;
        next_rdat1_EX = idexif.rdat1;
        next_rdat2_EX = idexif.rdat2;
        next_imm_EX = idexif.imm;
        next_j_en_EX = idexif.j_en_ID;
        next_b_en_EX = idexif.b_en_ID;
        next_wsel_EX = idexif.wsel;
        next_rs1_EX = idexif.rs1;
        next_rs2_EX = idexif.rs2;
        next_ALUOp_EX = idexif.ALUOp;
        next_ALUSrc_EX = idexif.ALUSrc;
        next_MemWr_EX = idexif.MemWr;
        next_MemRead_EX = idexif.MemRead;
        next_MemtoReg_EX = idexif.MemtoReg;
        next_RegWr_EX = idexif.RegWr;
        next_WriteSrc_EX = idexif.WriteSrc;
        next_is_halt_EX = idexif.is_halt;
        next_datomic_EX = idexif.datomic;
    end
end

endmodule