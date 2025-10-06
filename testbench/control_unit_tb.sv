/*
  Control Unit Test Bench
*/

// mapped needs these
`include "control_unit_if.vh"

// all types
`include "cpu_types_pkg.vh"

// import types
import cpu_types_pkg::*;

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module control_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interfaces
  control_unit_if cuif ();

  // test program
  test PROG (CLK, nRST, cuif);

  // DUT
`ifndef MAPPED
  control_unit DUT(CLK, nRST, cuif);
`else
  control_unit DUT(
    .\CLK (CLK),
    .\nRST (nRST),
    .\cuif.instruction (cuif.instruction),
    .\cuif.ihit (cuif.ihit),
    .\cuif.zero (cuif.zero),
    .\cuif.PCSrc (cuif.PCSrc),
    .\cuif.ALUOp (cuif.ALUOp),
    .\cuif.ALUSrc (cuif.ALUSrc),
    .\cuif.ALUSrcPC (cuif.ALUSrcPC),
    .\cuif.MemWr (cuif.MemWr),
    .\cuif.MemRead (cuif.MemRead),
    .\cuif.MemtoReg (cuif.MemtoReg),
    .\cuif.RegWr (cuif.RegWr),
    .\cuif.WriteSrc (cuif.WriteSrc),
    .\cuif.WriteSrc2 (cuif.WriteSrc2),
    .\cuif.PCWait (cuif.PCWait),
    .\cuif.halt (cuif.halt)
  );
`endif

endmodule

program test(
  input logic CLK, 
  output logic nRST,
  control_unit_if.ctrl cuif_tb
);
parameter PERIOD = 10;

initial begin

  nRST = 1;
  #(PERIOD);

  nRST = 0;
  #(PERIOD * 2);

  nRST = 1;
  #(PERIOD);

  @(posedge CLK)


  // TEST 1: RTYPE (add x5, x6, x7)

  cuif.instruction = 32'h007302B3;
  cuif.ihit = 1;
  cuif.zero = 0;

  #(PERIOD);

  if(cuif_tb.PCSrc != 0)
    $display("TEST1: incorrect 'PCSrc'");
  if(cuif_tb.ALUOp != ALU_ADD)
    $display("TEST1: incorrect 'ALUOp'");
  if(cuif_tb.ALUSrc != 0)
    $display("TEST1: incorrect 'ALUSrc'");
  if(cuif_tb.ALUSrcPC != 0)
    $display("TEST1: incorrect 'ALUSrcPC'");
  if(cuif_tb.MemWr != 0)
    $display("TEST1: incorrect 'MemWr'");
  if(cuif_tb.MemRead != 0)
    $display("TEST1: incorrect 'MemRead'");
  if(cuif_tb.MemtoReg != 0)
    $display("TEST1: incorrect 'MemtoReg'");
  if(cuif_tb.RegWr != 1)
    $display("TEST1: incorrect 'RegWr'");
  if(cuif_tb.WriteSrc != 0)
    $display("TEST1: incorrect 'WriteSrc'");
  if(cuif_tb.PCWait != 0)
    $display("TEST1: incorrect 'PCWait'");
  if(cuif_tb.WriteSrc2 != 0)
    $display("TEST1: incorrect 'WriteSrc2'");
  if(cuif_tb.halt != 0)
    $display("TEST1: incorrect 'halt'");

  #(PERIOD);
  
  
  // TEST 2: ITYPE (xori x5, x6, 15)

  cuif.instruction = 32'h00F34293;
  cuif.ihit = 0;
  cuif.zero = 0;

  #(PERIOD);

  if(cuif_tb.PCSrc != 0)
    $display("TEST2: incorrect 'PCSrc'");
  if(cuif_tb.ALUOp != ALU_XOR)
    $display("TEST2: incorrect 'ALUOp'");
  if(cuif_tb.ALUSrc != 1)
    $display("TEST2: incorrect 'ALUSrc'");
  if(cuif_tb.ALUSrcPC != 0)
    $display("TEST2: incorrect 'ALUSrcPC'");
  if(cuif_tb.MemWr != 0)
    $display("TEST2: incorrect 'MemWr'");
  if(cuif_tb.MemRead != 0)
    $display("TEST2: incorrect 'MemRead'");
  if(cuif_tb.MemtoReg != 0)
    $display("TEST2: incorrect 'MemtoReg'");
  if(cuif_tb.RegWr != 1)
    $display("TEST2: incorrect 'RegWr'");
  if(cuif_tb.WriteSrc != 0)
    $display("TEST2: incorrect 'WriteSrc'");
  if(cuif_tb.PCWait != 1)
    $display("TEST2: incorrect 'PCWait'");
  if(cuif_tb.WriteSrc2 != 0)
    $display("TEST2: incorrect 'WriteSrc2'");
  if(cuif_tb.halt != 0)
    $display("TEST2: incorrect 'halt'");

  #(PERIOD);


  // TEST 3: ITYPE_LW (lw x5, 0(x6))

  cuif.instruction = 32'h00032283;
  cuif.ihit = 1;
  cuif.zero = 0;

  #(PERIOD);

  if(cuif_tb.PCSrc != 0)
    $display("TEST3: incorrect 'PCSrc'");
  if(cuif_tb.ALUOp != ALU_ADD)
    $display("TEST3: incorrect 'ALUOp'");
  if(cuif_tb.ALUSrc != 1)
    $display("TEST3: incorrect 'ALUSrc'");
  if(cuif_tb.ALUSrcPC != 0)
    $display("TEST3: incorrect 'ALUSrcPC'");
  if(cuif_tb.MemWr != 0)
    $display("TEST3: incorrect 'MemWr'");
  if(cuif_tb.MemRead != 1)
    $display("TEST3: incorrect 'MemRead'");
  if(cuif_tb.MemtoReg != 1)
    $display("TEST3: incorrect 'MemtoReg'");
  if(cuif_tb.RegWr != 1)
    $display("TEST3: incorrect 'RegWr'");
  if(cuif_tb.WriteSrc != 0)
    $display("TEST3: incorrect 'WriteSrc'");
  if(cuif_tb.PCWait != 0)
    $display("TEST3: incorrect 'PCWait'");
  if(cuif_tb.WriteSrc2 != 0)
    $display("TEST3: incorrect 'WriteSrc2'");
  if(cuif_tb.halt != 0)
    $display("TEST3: incorrect 'halt'");

  #(PERIOD);


  // TEST 4: JALR (jalr x1, x5, 0)

  cuif.instruction = 32'h000280E7;
  cuif.ihit = 1;
  cuif.zero = 0;

  #(PERIOD);

  if(cuif_tb.PCSrc != 2)
    $display("TEST4: incorrect 'PCSrc'");
  if(cuif_tb.ALUOp != ALU_ADD)
    $display("TEST4: incorrect 'ALUOp'");
  if(cuif_tb.ALUSrc != 1)
    $display("TEST4: incorrect 'ALUSrc'");
  if(cuif_tb.ALUSrcPC != 0)
    $display("TEST4: incorrect 'ALUSrcPC'");
  if(cuif_tb.MemWr != 0)
    $display("TEST4: incorrect 'MemWr'");
  if(cuif_tb.MemRead != 0)
    $display("TEST4: incorrect 'MemRead'");
  if(cuif_tb.MemtoReg != 0)
    $display("TEST4: incorrect 'MemtoReg'");
  if(cuif_tb.RegWr != 1)
    $display("TEST4: incorrect 'RegWr'");
  if(cuif_tb.WriteSrc != 1)
    $display("TEST4: incorrect 'WriteSrc'");
  if(cuif_tb.PCWait != 0)
    $display("TEST4: incorrect 'PCWait'");
  if(cuif_tb.WriteSrc2 != 0)
    $display("TEST4: incorrect 'WriteSrc2'");
  if(cuif_tb.halt != 0)
    $display("TEST4: incorrect 'halt'");

  #(PERIOD);


  // TEST 5: STYPE (sw x6, 0(x5))

  cuif.instruction = 32'h0062A023;
  cuif.ihit = 0;
  cuif.zero = 0;

  #(PERIOD);

  if(cuif_tb.PCSrc != 0)
    $display("TEST5: incorrect 'PCSrc'");
  if(cuif_tb.ALUOp != ALU_ADD)
    $display("TEST5: incorrect 'ALUOp'");
  if(cuif_tb.ALUSrc != 1)
    $display("TEST5: incorrect 'ALUSrc'");
  if(cuif_tb.ALUSrcPC != 0)
    $display("TEST5: incorrect 'ALUSrcPC'");
  if(cuif_tb.MemWr != 1)
    $display("TEST5: incorrect 'MemWr'");
  if(cuif_tb.MemRead != 0)
    $display("TEST5: incorrect 'MemRead'");
  if(cuif_tb.MemtoReg != 0)
    $display("TEST5: incorrect 'MemtoReg'");
  if(cuif_tb.RegWr != 0)
    $display("TEST5: incorrect 'RegWr'");
  if(cuif_tb.WriteSrc != 0)
    $display("TEST5: incorrect 'WriteSrc'");
  if(cuif_tb.PCWait != 1)
    $display("TEST5: incorrect 'PCWait'");
  if(cuif_tb.WriteSrc2 != 0)
    $display("TEST5: incorrect 'WriteSrc2'");
  if(cuif_tb.halt != 0)
    $display("TEST5: incorrect 'halt'");

  #(PERIOD);


  // TEST 6: BTYPE (blt x5, x6, 0)

  cuif.instruction = 32'h0062C063;
  cuif.ihit = 0;
  cuif.zero = 1;

  #(PERIOD);

  if(cuif_tb.PCSrc != 1)
    $display("TEST6: incorrect 'PCSrc'");
  if(cuif_tb.ALUOp != ALU_SLT)
    $display("TEST6: incorrect 'ALUOp'");
  if(cuif_tb.ALUSrc != 0)
    $display("TEST6: incorrect 'ALUSrc'");
  if(cuif_tb.ALUSrcPC != 0)
    $display("TEST6: incorrect 'ALUSrcPC'");
  if(cuif_tb.MemWr != 0)
    $display("TEST6: incorrect 'MemWr'");
  if(cuif_tb.MemRead != 0)
    $display("TEST6: incorrect 'MemRead'");
  if(cuif_tb.MemtoReg != 0)
    $display("TEST6: incorrect 'MemtoReg'");
  if(cuif_tb.RegWr != 0)
    $display("TEST6: incorrect 'RegWr'");
  if(cuif_tb.WriteSrc != 0)
    $display("TEST6: incorrect 'WriteSrc'");
  if(cuif_tb.PCWait != 1)
    $display("TEST6: incorrect 'PCWait'");
  if(cuif_tb.WriteSrc2 != 0)
    $display("TEST6: incorrect 'WriteSrc2'");
  if(cuif_tb.halt != 0)
    $display("TEST6: incorrect 'halt'");

  #(PERIOD);

  
  // TEST 7: JAL (jal x1, 20)

  cuif.instruction = 32'h014000EF;
  cuif.ihit = 1;
  cuif.zero = 1;

  #(PERIOD);

  if(cuif_tb.PCSrc != 1)
    $display("TEST7: incorrect 'PCSrc'");
  if(cuif_tb.ALUOp != 4'hf)
    $display("TEST7: incorrect ALUOp'");
  if(cuif_tb.ALUSrc != 1)
    $display("TEST7: incorrect 'ALUSrc'");
  if(cuif_tb.ALUSrcPC != 0)
    $display("TEST7: incorrect 'ALUSrcPC'");
  if(cuif_tb.MemWr != 0)
    $display("TEST7: incorrect 'MemWr'");
  if(cuif_tb.MemRead != 0)
    $display("TEST7: incorrect 'MemRead'");
  if(cuif_tb.MemtoReg != 0)
    $display("TEST7: incorrect 'MemtoReg'");
  if(cuif_tb.RegWr != 1)
    $display("TEST7: incorrect 'RegWr'");
  if(cuif_tb.WriteSrc != 1)
    $display("TEST7: incorrect 'WriteSrc'");
  if(cuif_tb.PCWait != 0)
    $display("TEST7: incorrect 'PCWait'");
  if(cuif_tb.WriteSrc2 != 0)
    $display("TEST7: incorrect 'WriteSrc2'");
  if(cuif_tb.halt != 0)
    $display("TEST7: incorrect 'halt'");

  #(PERIOD);
  

  // TEST 8: LUI

  cuif.instruction = 32'h000012B7;
  cuif.ihit = 0;
  cuif.zero = 0;

  #(PERIOD);

  if(cuif_tb.PCSrc != 0)
    $display("TEST8: incorrect 'PCSrc'");
  if(cuif_tb.ALUOp != ALU_ADD)
    $display("TEST8: incorrect ALUOp'");
  if(cuif_tb.ALUSrc != 1)
    $display("TEST8: incorrect 'ALUSrc'");
  if(cuif_tb.ALUSrcPC != 0)
    $display("TEST8: incorrect 'ALUSrcPC'");
  if(cuif_tb.MemWr != 0)
    $display("TEST8: incorrect 'MemWr'");
  if(cuif_tb.MemRead != 0)
    $display("TEST8: incorrect 'MemRead'");
  if(cuif_tb.MemtoReg != 0)
    $display("TEST8: incorrect 'MemtoReg'");
  if(cuif_tb.RegWr != 1)
    $display("TEST8: incorrect 'RegWr'");
  if(cuif_tb.WriteSrc != 0)
    $display("TEST8: incorrect 'WriteSrc'");
  if(cuif_tb.PCWait != 1)
    $display("TEST8: incorrect 'PCWait'");
  if(cuif_tb.WriteSrc2 != 1)
    $display("TEST8: incorrect 'WriteSrc2'");
  if(cuif_tb.halt != 0)
    $display("TEST8: incorrect 'halt'");

  #(PERIOD);

  
  // TEST 9: AUIPC

  cuif.instruction = 32'h00000297;
  cuif.ihit = 0;
  cuif.zero = 0;

  #(PERIOD);

  if(cuif_tb.PCSrc != 0)
    $display("TEST9: incorrect 'PCSrc'");
  if(cuif_tb.ALUOp != ALU_ADD)
    $display("TEST9: incorrect ALUOp'");
  if(cuif_tb.ALUSrc != 1)
    $display("TEST9: incorrect 'ALUSrc'");
  if(cuif_tb.ALUSrcPC != 1)
    $display("TEST9: incorrect 'ALUSrcPC'");
  if(cuif_tb.MemWr != 0)
    $display("TEST9: incorrect 'MemWr'");
  if(cuif_tb.MemRead != 0)
    $display("TEST9: incorrect 'MemRead'");
  if(cuif_tb.MemtoReg != 0)
    $display("TEST9: incorrect 'MemtoReg'");
  if(cuif_tb.RegWr != 1)
    $display("TEST9: incorrect 'RegWr'");
  if(cuif_tb.WriteSrc != 0)
    $display("TEST9: incorrect 'WriteSrc'");
  if(cuif_tb.PCWait != 1)
    $display("TEST9: incorrect 'PCWait'");
  if(cuif_tb.WriteSrc2 != 0)
    $display("TEST9: incorrect 'WriteSrc2'");
  if(cuif_tb.halt != 0)
    $display("TEST9: incorrect 'halt'");

  #(PERIOD);

  
  // TEST 10: HALT

  cuif.instruction = 32'hffffffff;
  cuif.ihit = 0;
  cuif.zero = 0;

  #(PERIOD);

  if(cuif_tb.PCSrc != 0)
    $display("TEST10: incorrect 'PCSrc'");
  if(cuif_tb.ALUOp != 4'hf)
    $display("TEST10: incorrect ALUOp'");
  if(cuif_tb.ALUSrc != 1)
    $display("TEST10: incorrect 'ALUSrc'");
  if(cuif_tb.ALUSrcPC != 0)
    $display("TEST10: incorrect 'ALUSrcPC'");
  if(cuif_tb.MemWr != 0)
    $display("TEST10: incorrect 'MemWr'");
  if(cuif_tb.MemRead != 0)
    $display("TEST10: incorrect 'MemRead'");
  if(cuif_tb.MemtoReg != 0)
    $display("TEST10: incorrect 'MemtoReg'");
  if(cuif_tb.RegWr != 0)
    $display("TEST10: incorrect 'RegWr'");
  if(cuif_tb.WriteSrc != 0)
    $display("TEST10: incorrect 'WriteSrc'");
  if(cuif_tb.PCWait != 1)
    $display("TEST10: incorrect 'PCWait'");
  if(cuif_tb.WriteSrc2 != 0)
    $display("TEST10: incorrect 'WriteSrc2'");
  if(cuif_tb.halt != 1)
    $display("TEST10: incorrect 'halt'");

  #(PERIOD);

end
endprogram