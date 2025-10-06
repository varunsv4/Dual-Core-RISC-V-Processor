// interface include
`include "control_unit_if.vh"

// all types
`include "cpu_types_pkg.vh"

module control_unit (
    control_unit_if.ctrl cuif
);

// type import
import cpu_types_pkg::*;

word_t instr;
opcode_t opcode;

assign instr = cuif.instruction;
assign opcode = opcode_t'(instr[6:0]);

// Control Signal Logic
always_comb begin
    cuif.ALUSrc = 1;
    cuif.ALUOp = aluop_t'(4'hf);
    cuif.MemWr = 0;
    cuif.MemRead = 0;
    cuif.MemtoReg = 0;
    cuif.RegWr = 0;
    cuif.WriteSrc = 0;
    cuif.is_halt = 0;
    cuif.datomic = 0;

    // Do nothing if PC is halted
    if(!cuif.is_halt) begin
        // Terminate PC execution on HALT
        if(opcode == HALT) begin
            cuif.is_halt = 1;
        end
        // Regular operation if not HALT
        else begin
            
            if (opcode == LR_SC)
                cuif.datomic = 1; 

            // ALUSrc

            if((opcode == RTYPE) || (opcode == BTYPE))
                cuif.ALUSrc = 0;
            

            // ALUOp

            if(opcode == RTYPE) begin
                casez(instr[14:12])
                    SLL: cuif.ALUOp = ALU_SLL;
                    SRL_SRA: begin
                        if(instr[31:25] == 0)
                            cuif.ALUOp = ALU_SRL;
                        else
                            cuif.ALUOp = ALU_SRA;
                    end
                    ADD_SUB: begin
                        if(instr[31:30] == 0)
                            cuif.ALUOp = ALU_ADD;
                        else
                            cuif.ALUOp = ALU_SUB;
                    end
                    AND: cuif.ALUOp = ALU_AND;
                    OR: cuif.ALUOp = ALU_OR;
                    XOR: cuif.ALUOp = ALU_XOR;
                    SLT: cuif.ALUOp = ALU_SLT;
                    SLTU: cuif.ALUOp = ALU_SLTU;
                endcase
            end
            else if(opcode == ITYPE) begin
                casez(instr[14:12])
                    ADDI: cuif.ALUOp = ALU_ADD;
                    XORI: cuif.ALUOp = ALU_XOR;
                    ORI: cuif.ALUOp = ALU_OR;
                    ANDI: cuif.ALUOp = ALU_AND;
                    SLLI: cuif.ALUOp = ALU_SLL;
                    SRLI_SRAI: begin
                        if(instr[31:25] == 0)
                            cuif.ALUOp = ALU_SRL;
                        else
                            cuif.ALUOp = ALU_SRA;
                    end
                    SLTI: cuif.ALUOp = ALU_SLT;
                    SLTIU: cuif.ALUOp = ALU_SLTU;
                endcase
            end
            else if((opcode == ITYPE_LW) || (opcode == JALR) || (opcode == STYPE)
                 || (opcode == AUIPC) || (opcode == LR_SC))
                cuif.ALUOp = ALU_ADD;
            else if(opcode == BTYPE) begin
                if((instr[14:12] == BLTU) || (instr[14:12] ==  BGEU))
                    cuif.ALUOp = ALU_SLTU;
                else if((instr[14:12] == BLT) || (instr[14:12] == BGE))
                    cuif.ALUOp = ALU_SLT;
                else
                    cuif.ALUOp = ALU_SUB;
            end


            // MemWr

            if((opcode == STYPE) || ((opcode == LR_SC) && (instr[31:27] == 5'd3)))
                cuif.MemWr = 1;
            

            // MemRead

            if((opcode == ITYPE_LW) || ((opcode == LR_SC) && (instr[31:27] == 5'd2)))
                cuif.MemRead = 1;
            

            // MemtoReg

            if((opcode == ITYPE_LW) || (opcode == LR_SC))
                cuif.MemtoReg = 1;

            
            // RegWr

            if((opcode == STYPE) || (opcode == BTYPE))
                cuif.RegWr = 0;
            else begin
                cuif.RegWr = 1;
            end
            

            // WriteSrc

            if((opcode == JALR) || (opcode == JAL))
                cuif.WriteSrc = 2'b10;
            else if(opcode == LUI)
                cuif.WriteSrc = 2'b01;
            else if(opcode == AUIPC)
                cuif.WriteSrc = 2'b11;
            
        end
    end
end

endmodule