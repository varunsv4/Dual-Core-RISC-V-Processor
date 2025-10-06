

// all interfaces
`include "datapath_cache_if.vh"
`include "program_counter_if.vh"
`include "register_file_if.vh"
`include "alu_if.vh"
`include "control_unit_if.vh"
`include "imm_gen_if.vh"
`include "forwarding_unit_if.vh"
`include "hazard_unit_if.vh"
`include "if_id_register_if.vh"
`include "id_ex_register_if.vh"
`include "ex_mem_register_if.vh"
`include "mem_wb_register_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath #(
  parameter PC_INIT=0
  ) (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // // pc init
  // parameter PC_INIT = 0;


  // ======================================================
  // Interfaces
  // ======================================================
  program_counter_if pcif ();
  register_file_if rfif ();
  alu_if aluif ();
  control_unit_if cuif ();
  imm_gen_if igif ();
  forwarding_unit_if fuif ();
  hazard_unit_if huif ();
  if_id_register_if ifidif ();
  id_ex_register_if idexif ();
  ex_mem_register_if exmemif ();
  mem_wb_register_if memwbif ();


  // ======================================================
  // Modules
  // ======================================================
  program_counter #(.PC_INIT(PC_INIT)) PC (CLK, nRST, pcif);
  register_file REGF (CLK, nRST, rfif);
  alu ALU (aluif);
  control_unit CTRL (cuif);
  imm_gen IMM (igif);
  forwarding_unit FRWD (fuif);
  hazard_unit HZRD (huif);


  // ======================================================
  // Register Stages
  // ======================================================
  if_id_register IFID (CLK, nRST, ifidif);
  id_ex_register IDEX (CLK, nRST, idexif);
  ex_mem_register EXMEM (CLK, nRST, exmemif);
  mem_wb_register MEMWB (CLK, nRST, memwbif);
  

  // ======================================================
  // ASSIGNMENTS
  // ======================================================

  // Get instruction from datapath_cache_if
  word_t instr;
  assign instr = dpif.imemload;

  word_t busA, busB;
  word_t wdat, ALUSrc_mux_out, MemtoReg_mux_out;

  logic pipeline_ctrl, dmem_out_mux_ctrl;

  // Muxes
  assign ALUSrc_mux_out = idexif.ALUSrc_EX ? idexif.imm_EX : busB;
  assign MemtoReg_mux_out = memwbif.MemtoReg_WB ? memwbif.dmem_out_WB : memwbif.alu_out_WB;

  // Pipeline Control Signal
  assign pipeline_ctrl = dpif.ihit && (dpif.dhit || !(exmemif.MemRead_MEM || exmemif.MemWr_MEM));

  // IF/ID Register Inputs
  assign ifidif.Write_IF_ID = huif.Write_IF_ID;
  assign ifidif.pc = pcif.pc;
  assign ifidif.instr = instr;
  assign ifidif.flush_IF_ID = pcif.flush_IF_ID;
  assign ifidif.j_en = pcif.j_en;
  assign ifidif.b_en = pcif.b_en;
  assign ifidif.pipeline_ctrl = pipeline_ctrl;

  // ID/EX Register Inputs
  assign idexif.pc_ID = ifidif.pc_ID;
  assign idexif.instr_ID = ifidif.instr_ID;
  assign idexif.rdat1 = rfif.rdat1;
  assign idexif.rdat2 = rfif.rdat2;
  assign idexif.imm = igif.imm;
  assign idexif.j_en_ID = huif.ctrlFlush ? 0 : ifidif.j_en_ID;
  assign idexif.b_en_ID = huif.ctrlFlush ? 0 : ifidif.b_en_ID;
  assign idexif.wsel = huif.ctrlFlush ? 0 : ifidif.instr_ID[11:7];
  assign idexif.rs1 = ifidif.instr_ID[19:15];
  assign idexif.rs2 = ifidif.instr_ID[24:20];
  assign idexif.flush_ID_EX = pcif.flush_ID_EX;
  assign idexif.ALUOp = huif.ctrlFlush ? aluop_t'(0) : cuif.ALUOp;
  assign idexif.ALUSrc = huif.ctrlFlush ? 0 : cuif.ALUSrc;
  assign idexif.MemWr = huif.ctrlFlush ? 0 : cuif.MemWr;
  assign idexif.MemRead = huif.ctrlFlush ? 0 : cuif.MemRead;
  assign idexif.MemtoReg = huif.ctrlFlush ? 0 : cuif.MemtoReg;
  assign idexif.RegWr = huif.ctrlFlush ? 0 : cuif.RegWr;
  assign idexif.WriteSrc = huif.ctrlFlush ? 0 : cuif.WriteSrc;
  assign idexif.is_halt = cuif.is_halt;
  assign idexif.pipeline_ctrl = pipeline_ctrl;
  assign idexif.datomic = huif.ctrlFlush ? 0 : cuif.datomic;

  // EX/MEM Register Inputs
  assign exmemif.pc_EX = idexif.pc_EX;
  assign exmemif.instr_EX = idexif.instr_EX;
  assign exmemif.alu_out = aluif.portout;
  assign exmemif.busB = busB;
  assign exmemif.imm_EX = idexif.imm_EX;
  assign exmemif.dmemload = dpif.dmemload;
  assign exmemif.dhit = dpif.dhit;
  assign exmemif.flush_EX_MEM = pcif.flush_EX_MEM;
  assign exmemif.b_en_EX = idexif.b_en_EX;
  assign exmemif.zero = aluif.zero;
  assign exmemif.wsel_EX = idexif.wsel_EX;
  assign exmemif.MemWr_EX = idexif.MemWr_EX;
  assign exmemif.MemRead_EX = idexif.MemRead_EX;
  assign exmemif.MemtoReg_EX = idexif.MemtoReg_EX;
  assign exmemif.RegWr_EX = idexif.RegWr_EX;
  assign exmemif.WriteSrc_EX = idexif.WriteSrc_EX;
  assign exmemif.is_halt_EX = idexif.is_halt_EX;
  assign exmemif.pipeline_ctrl = pipeline_ctrl;
  assign exmemif.datomic_EX = idexif.datomic_EX;

  // MEM/WB Register Inputs
  assign memwbif.pc_MEM = exmemif.pc_MEM;
  assign memwbif.dmem_out = dmem_out_mux_ctrl ? exmemif.dmem_out_reg : dpif.dmemload;
  assign memwbif.alu_out_MEM = exmemif.alu_out_MEM;
  assign memwbif.imm_MEM = exmemif.imm_MEM;
  assign memwbif.wsel_MEM = exmemif.wsel_MEM;
  assign memwbif.MemtoReg_MEM = exmemif.MemtoReg_MEM;
  assign memwbif.RegWr_MEM = exmemif.RegWr_MEM;
  assign memwbif.WriteSrc_MEM = exmemif.WriteSrc_MEM;
  assign memwbif.pipeline_ctrl = pipeline_ctrl;

  // Program Counter Inputs
  assign pcif.PCWrite = huif.PCWrite;
  assign pcif.instr = instr;
  assign pcif.instr_EX = idexif.instr_EX;
  assign pcif.instr_MEM = exmemif.instr_MEM;
  assign pcif.pc_EX = idexif.pc_EX;
  assign pcif.pc_MEM = exmemif.pc_MEM;
  assign pcif.imm_EX = idexif.imm_EX;
  assign pcif.imm_MEM = exmemif.imm_MEM;
  assign pcif.rdat1_EX = busA;
  assign pcif.b_en_MEM = exmemif.b_en_MEM;
  assign pcif.j_en_EX = idexif.j_en_EX;
  assign pcif.zero_MEM = exmemif.zero_MEM;
  assign pcif.pipeline_ctrl = pipeline_ctrl;


  // Register Files Inputs
  assign rfif.WEN = memwbif.RegWr_WB;
  assign rfif.wsel = memwbif.wsel_WB;
  assign rfif.rsel1 = ifidif.instr_ID[19:15];
  assign rfif.rsel2 = ifidif.instr_ID[24:20];
  assign rfif.wdat = wdat;


  // ALU Inputs
  assign aluif.aluop = idexif.ALUOp_EX;
  assign aluif.porta = busA;
  assign aluif.portb = ALUSrc_mux_out;


  // Control Unit Inputs
  assign cuif.instruction = ifidif.instr_ID;


  // Imm Gen Inputs
  assign igif.instruction = ifidif.instr_ID;


  // Forwarding Unit Inputs
  assign fuif.rs1_EX = idexif.rs1_EX;
  assign fuif.rs2_EX = idexif.rs2_EX;
  assign fuif.wsel_MEM = exmemif.wsel_MEM;
  assign fuif.wsel_WB = memwbif.wsel_WB;
  assign fuif.RegWr_MEM = exmemif.RegWr_MEM;
  assign fuif.RegWr_WB = memwbif.RegWr_WB;


  // Hazard Unit Inputs
  assign huif.MemRead_EX = idexif.MemRead_EX || idexif.datomic_EX;
  assign huif.wsel_EX = idexif.wsel_EX;
  assign huif.rsel1_ID = ifidif.instr_ID[19:15];
  assign huif.rsel2_ID = ifidif.instr_ID[24:20];


  // Datapath Outputs
  assign dpif.halt = exmemif.is_halt_MEM && !exmemif.b_en_MEM;
  assign dpif.imemREN = 1;
  assign dpif.imemaddr = pcif.pc;
  assign dpif.dmemREN = exmemif.MemRead_MEM;
  assign dpif.dmemWEN = exmemif.MemWr_MEM;
  assign dpif.dmemstore = exmemif.busB_MEM;
  assign dpif.dmemaddr = exmemif.alu_out_MEM;
  assign dpif.datomic = exmemif.datomic_MEM;


  // ======================================================
  // COMBINATIONAL LOGIC
  // ======================================================

  // dmem_out mux
  always_comb begin
    if(dpif.ihit && dpif.dhit)
      dmem_out_mux_ctrl = 0;
    else
      dmem_out_mux_ctrl = 1;
  end

  // Write Back Logic
  always_comb begin
    wdat = 32'd0;

    casez(memwbif.WriteSrc_WB)
      0: wdat = MemtoReg_mux_out;
      1: wdat = memwbif.imm_WB;
      2: wdat = memwbif.pc_WB + 4;
      3: wdat = memwbif.pc_WB + memwbif.imm_WB;
    endcase
  end

  // ForwardA Mux
  always_comb begin
    busA = 32'd0;

    casez(fuif.ForwardA)
      0: busA = idexif.rdat1_EX;
      1: begin
        casez(exmemif.WriteSrc_MEM)
          0: busA = exmemif.alu_out_MEM;
          1: busA = exmemif.imm_MEM;
          2: busA = exmemif.pc_MEM + 4;
          3: busA = exmemif.pc_MEM + exmemif.imm_MEM;
        endcase
      end 
      2: busA = wdat;
    endcase
  end

  // ForwardB Mux
  always_comb begin
    busB = 32'd0;

    casez(fuif.ForwardB)
      0: busB = idexif.rdat2_EX;
      1: begin
        casez(exmemif.WriteSrc_MEM)
          0: busB = exmemif.alu_out_MEM;
          1: busB = exmemif.imm_MEM;
          2: busB = exmemif.pc_MEM + 4;
          3: busB = exmemif.pc_MEM + exmemif.imm_MEM;
        endcase
      end
      2: busB = wdat;
    endcase
  end

endmodule
