// interface include
`include "program_counter_if.vh"

// all types
`include "cpu_types_pkg.vh"

module program_counter # (
    parameter PC_INIT=0
    ) (
    input CLK, nRST,
    program_counter_if.pcr pcif
);

// type import
import cpu_types_pkg::*;

word_t next_pc;
opcode_t opcode_IF, opcode_EX;
funct3_b_t branch_type_MEM;

// PC Register
always_ff @(posedge CLK, negedge nRST) begin
    if(!nRST)
        pcif.pc <= PC_INIT;
    else begin
        if(pcif.pipeline_ctrl)
            pcif.pc <= next_pc;
        else
            pcif.pc <= pcif.pc;
    end
end

assign opcode_IF = opcode_t'(pcif.instr[6:0]);
assign opcode_EX = opcode_t'(pcif.instr_EX[6:0]);
assign branch_type_MEM = funct3_b_t'(pcif.instr_MEM[14:12]);

// PC Next State Logic
always_comb begin
    next_pc = pcif.pc;

    pcif.j_en = 0;
    pcif.b_en = 0;
    pcif.flush_IF_ID = 0;
    pcif.flush_ID_EX = 0;
    pcif.flush_EX_MEM = 0;

    if(pcif.pipeline_ctrl && !pcif.PCWrite) begin
        casez(opcode_IF)
            LR_SC, RTYPE, ITYPE, ITYPE_LW, STYPE, LUI, AUIPC: next_pc = pcif.pc + 4;
            JALR, JAL: begin
                pcif.j_en = 1;
                //next_pc = pcif.pc + 4;
            end
            BTYPE: begin
                next_pc = pcif.pc + 4;
                pcif.b_en = 1;
            end
        endcase
    end

    if(pcif.b_en_MEM) begin
        if(pcif.zero_MEM) begin
            if((branch_type_MEM == BEQ) || (branch_type_MEM == BGE) || (branch_type_MEM == BGEU)) begin
                pcif.flush_IF_ID = 1;
                pcif.flush_ID_EX = 1;
                pcif.flush_EX_MEM = 1;
                next_pc = pcif.pc_MEM + pcif.imm_MEM;
            end
        end
        else begin
            if((branch_type_MEM == BNE) || (branch_type_MEM == BLT) || (branch_type_MEM == BLTU)) begin
                pcif.flush_IF_ID = 1;
                pcif.flush_ID_EX = 1;
                pcif.flush_EX_MEM = 1;
                next_pc = pcif.pc_MEM + pcif.imm_MEM;
            end
        end
    end
    else if(pcif.j_en_EX && !pcif.PCWrite) begin
        pcif.flush_IF_ID = 1;
        pcif.flush_ID_EX = 1;
        if(opcode_EX == JALR)
            next_pc = pcif.rdat1_EX + pcif.imm_EX;
        else
            next_pc = pcif.pc_EX + pcif.imm_EX;
    end
end

endmodule