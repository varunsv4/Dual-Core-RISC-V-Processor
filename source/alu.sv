`include "alu_if.vh"

// all types
`include "cpu_types_pkg.vh"

module alu(
    alu_if.alu aluif
);

// import types
import cpu_types_pkg::*;

logic [32:0] temp_sum;

always_comb begin
    // Set default values
    temp_sum = '0;
    aluif.portout = '0;
    aluif.negative = 0;
    aluif.overflow = 0;
    aluif.zero = 0;

    // Execute opcode operation
    casez(aluif.aluop)
        ALU_SLL: aluif.portout = aluif.porta << aluif.portb[4:0];
        ALU_SRL: aluif.portout = aluif.porta >> aluif.portb[4:0];
        ALU_SRA: aluif.portout = signed'(aluif.porta) >>> unsigned'(aluif.portb[4:0]);
        ALU_ADD: begin
            temp_sum = aluif.porta + aluif.portb;
            aluif.portout = temp_sum[31:0];
            aluif.overflow = ~(aluif.porta[31] ^ aluif.portb[31]) & (aluif.portout[31] ^ aluif.porta[31]);
        end
        ALU_SUB: begin
            aluif.portout = aluif.porta - aluif.portb;
            aluif.overflow = (aluif.porta[31] ^ aluif.portb[31]) & (aluif.porta[31] ^ aluif.portout[31]);
        end
        ALU_AND: aluif.portout = aluif.porta & aluif.portb;
        ALU_OR: aluif.portout = aluif.porta | aluif.portb;
        ALU_XOR: aluif.portout = aluif.porta ^ aluif.portb;
        ALU_SLT: aluif.portout = (signed'(aluif.porta) < signed'(aluif.portb)) ? 1 : 0;
        ALU_SLTU: aluif.portout = (unsigned'(aluif.porta) < unsigned'(aluif.portb)) ? 1 : 0;
    endcase

    aluif.negative = aluif.portout[31];
    aluif.zero = (aluif.portout == 32'b0);
end

endmodule