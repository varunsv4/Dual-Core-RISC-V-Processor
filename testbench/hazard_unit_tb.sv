/*
  Hazard Unit Test Bench
*/

// mapped needs these
`include "hazard_unit_if.vh"

// all types
`include "cpu_types_pkg.vh"

// import types
import cpu_types_pkg::*;

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module hazard_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interfaces
  hazard_unit_if huif ();

  // test program
  test PROG (huif);

  // DUT
`ifndef MAPPED
  hazard_unit DUT(huif);
`else
  hazard_unit DUT(
    .\huif.MemRead_EX (huif.MemRead_EX),
    .\huif.wsel_EX (huif.wsel_WX),
    .\huif.rsel1_ID (huif.rsel1_ID),
    .\huif.rsel2_ID (huif.rsel2_ID),
    .\huif.ctrlFlush (huif.ctrlFlush),
    .\huif.PCWrite (huif.PCWrite),
    .\huif.Write_IF_ID (huif.Write_IF_ID)
  );
`endif

endmodule

program test(
  hazard_unit_if.hu huif_tb
);
parameter PERIOD = 10;

initial begin

  // TEST 1: No Load in EX

  huif_tb.MemRead_EX = 0;
  huif_tb.wsel_EX = 5'd5;
  huif_tb.rsel1_ID = 5'd5;
  huif_tb.rsel2_ID = 5'd6;

  #(PERIOD);

  if(huif_tb.ctrlFlush != 0)
    $display("TEST1: incorrect 'ctrlFlush'");
  if(huif_tb.PCWrite != 0)
    $display("TEST1: incorrect 'PCWrite'");
  if(huif_tb.Write_IF_ID != 0)
    $display("TEST1: incorrect 'Write_IF_ID'");

  #(PERIOD);


  // TEST 2: Load in EX but no wsel_EX match

  huif_tb.MemRead_EX = 1;
  huif_tb.wsel_EX = 5'd7;
  huif_tb.rsel1_ID = 5'd5;
  huif_tb.rsel2_ID = 5'd6;

  #(PERIOD);

  if(huif_tb.ctrlFlush != 0)
    $display("TEST2: incorrect 'ctrlFlush'");
  if(huif_tb.PCWrite != 0)
    $display("TEST2: incorrect 'PCWrite'");
  if(huif_tb.Write_IF_ID != 0)
    $display("TEST2: incorrect 'Write_IF_ID'");

  #(PERIOD);


  // TEST 3: Load in EX and wsel_EX matches rsel1_ID

  huif_tb.MemRead_EX = 1;
  huif_tb.wsel_EX = 5'd7;
  huif_tb.rsel1_ID = 5'd7;
  huif_tb.rsel2_ID = 5'd6;

  #(PERIOD);

  if(huif_tb.ctrlFlush != 1)
    $display("TEST3: incorrect 'ctrlFlush'");
  if(huif_tb.PCWrite != 1)
    $display("TEST3: incorrect 'PCWrite'");
  if(huif_tb.Write_IF_ID != 1)
    $display("TEST3: incorrect 'Write_IF_ID'");

  #(PERIOD);


  // TEST 4: Load in EX and wsel_EX matches rsel2_ID

  huif_tb.MemRead_EX = 1;
  huif_tb.wsel_EX = 5'd7;
  huif_tb.rsel1_ID = 5'd5;
  huif_tb.rsel2_ID = 5'd7;

  #(PERIOD);

  if(huif_tb.ctrlFlush != 1)
    $display("TEST4: incorrect 'ctrlFlush'");
  if(huif_tb.PCWrite != 1)
    $display("TEST4: incorrect 'PCWrite'");
  if(huif_tb.Write_IF_ID != 1)
    $display("TEST4: incorrect 'Write_IF_ID'");
    
end
endprogram