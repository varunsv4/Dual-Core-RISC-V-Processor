/*
  Request Unit Test Bench
*/

// mapped needs these
`include "request_unit_if.vh"

// all types
`include "cpu_types_pkg.vh"

// import types
import cpu_types_pkg::*;

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module request_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interfaces
  request_unit_if ruif ();

  // test program
  test PROG (CLK, nRST, ruif);

  // DUT
`ifndef MAPPED
  request_unit DUT(CLK, nRST, ruif);
`else
  request_unit DUT(
    .\CLK (CLK),
    .\nRST (nRST),
    .\ruif.ihit (ruif.ihit),
    .\ruif.dhit (ruif.dhit),
    .\ruif.MemWrite (ruif.MemWrite),
    .\ruif.MemRead (ruif.MemRead),
    .\ruif.is_halted (ruif.is_halted),
    .\ruif.imemREN (ruif.imemREN),
    .\ruif.dmemREN (ruif.dmemREN),
    .\ruif.dmemWEN (ruif.dmemWEN)
  );
`endif

endmodule

program test(
  input logic CLK, 
  output logic nRST,
  request_unit_if.ru ruif_tb
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


  // TEST 1: nothing happens

  ruif.ihit = 0;
  ruif.dhit = 0;
  ruif.MemWrite = 0;
  ruif.MemRead = 0;
  ruif.is_halted = 0;

  #(PERIOD);

  if(ruif_tb.imemREN != 1)
    $display("TEST1: incorrect 'imemREN'");
  if(ruif_tb.dmemREN != 0)
    $display("TEST1: incorrect 'dmemREN'");
  if(ruif_tb.dmemWEN != 0)
    $display("TEST1: incorrect 'dmemWEN'");

  #(PERIOD);


  // TEST 2: want to write data

  ruif.ihit = 1;
  ruif.dhit = 0;
  ruif.MemWrite = 1;
  ruif.MemRead = 0;
  ruif.is_halted = 0;

  #(PERIOD);

  if(ruif_tb.imemREN != 1)
    $display("TEST2: incorrect 'imemREN'");
  if(ruif_tb.dmemREN != 0)
    $display("TEST2: incorrect 'dmemREN'");
  if(ruif_tb.dmemWEN != 1)
    $display("TEST2: incorrect 'dmemWEN'");

  #(PERIOD);


   // TEST 3: get dhit and no longer want to write

  ruif.ihit = 0;
  ruif.dhit = 1;
  ruif.MemWrite = 1;
  ruif.MemRead = 0;
  ruif.is_halted = 0;

  #(PERIOD);

  if(ruif_tb.imemREN != 1)
    $display("TEST3: incorrect 'imemREN'");
  if(ruif_tb.dmemREN != 0)
    $display("TEST3: incorrect 'dmemREN'");
  if(ruif_tb.dmemWEN != 0)
    $display("TEST3: incorrect 'dmemWEN'");

  #(PERIOD);


  // TEST 4: want to read data

  ruif.ihit = 1;
  ruif.dhit = 0;
  ruif.MemWrite = 0;
  ruif.MemRead = 1;
  ruif.is_halted = 0;

  #(PERIOD);

  if(ruif_tb.imemREN != 1)
    $display("TEST4: incorrect 'imemREN'");
  if(ruif_tb.dmemREN != 1)
    $display("TEST4: incorrect 'dmemREN'");
  if(ruif_tb.dmemWEN != 0)
    $display("TEST4: incorrect 'dmemWEN'");

  #(PERIOD);


  // TEST 5: get dhit and no longer want to read

  ruif.ihit = 0;
  ruif.dhit = 1;
  ruif.MemWrite = 0;
  ruif.MemRead = 1;
  ruif.is_halted = 0;

  #(PERIOD);

  if(ruif_tb.imemREN != 1)
    $display("TEST5: incorrect 'imemREN'");
  if(ruif_tb.dmemREN != 0)
    $display("TEST5: incorrect 'dmemREN'");
  if(ruif_tb.dmemWEN != 0)
    $display("TEST5: incorrect 'dmemWEN'");

  #(PERIOD);


  // TEST 6: halt

  ruif.ihit = 0;
  ruif.dhit = 0;
  ruif.MemWrite = 0;
  ruif.MemRead = 0;
  ruif.is_halted = 1;

  #(PERIOD);

  if(ruif_tb.imemREN != 0)
    $display("TEST6: incorrect 'imemREN'");
  if(ruif_tb.dmemREN != 0)
    $display("TEST6: incorrect 'dmemREN'");
  if(ruif_tb.dmemWEN != 0)
    $display("TEST6: incorrect 'dmemWEN'");

  #(PERIOD);

end
endprogram