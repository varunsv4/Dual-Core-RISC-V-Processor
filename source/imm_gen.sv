// // interface include
// `include "imm_gen_if.vh"

// // all types
// `include "cpu_types_pkg.vh"

// module imm_gen (
//     imm_gen_if.gen igif
// );

// // type import
// import cpu_types_pkg::*;

// opcode_t opcode;
// word_t instr;

// assign instr = igif.instruction;
// assign opcode = opcode_t'(instr[6:0]);

// always_comb begin
//     // different immediate generation based on instruction opcode
//     igif.imm = '0;
    
//     casez(opcode)
//         RTYPE, HALT: igif.imm = '0;
//         ITYPE, ITYPE_LW, JALR: igif.imm = {{20{instr[31]}}, instr[31:20]};
//         STYPE: igif.imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};
//         BTYPE: igif.imm = {{18{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
//         JAL: igif.imm = {{19{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
//         LUI, AUIPC: igif.imm = {instr[31:12], {12{1'b0}}};
//     endcase
// end
// endmodule

`include "imm_gen_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module imm_gen (
    imm_gen_if.gen igif
);

always_comb begin
    igif.imm = '0;
    if ((igif.instruction[6:0] == ITYPE) || (igif.instruction[6:0] == ITYPE_LW) || (igif.instruction[6:0] == JALR)) begin
        igif.imm = 32'(signed'(igif.instruction[31:20]));
    end
    else if (igif.instruction[6:0] == STYPE) begin
        igif.imm = 32'(signed'({igif.instruction[31:25], igif.instruction[11:7]}));
    end
    else if (igif.instruction[6:0] == BTYPE) begin
        igif.imm = 32'(signed'({igif.instruction[31], igif.instruction[7], igif.instruction[30:25], igif.instruction[11:8], 1'b0}));
    end
    else if (igif.instruction[6:0] == JAL) begin
        igif.imm = 32'(signed'({igif.instruction[31], igif.instruction[19:12], igif.instruction[20], igif.instruction[30:21], 1'b0}));
    end
    else if ((igif.instruction[6:0] == LUI) || (igif.instruction[6:0] == AUIPC)) begin
        igif.imm = 32'(signed'({igif.instruction[31:12], 12'b0}));
    end
end

endmodule