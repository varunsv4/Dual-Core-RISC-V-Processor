/*
  Dcache Test Bench
*/

// mapped needs these
`include "datapath_cache_if.vh"
`include "caches_if.vh"

// all types
`include "cpu_types_pkg.vh"

// import types
import cpu_types_pkg::*;

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module dcache_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interfaces
  datapath_cache_if dcif ();
  caches_if cif();

  // test program
  test PROG (CLK, nRST, dcif, cif);

  // DUT
`ifndef MAPPED
  dcache DUT(CLK, nRST, dcif, cif);
`else
  dcache DUT(
    .\CLK (CLK),
    .\nRST (nRST),
    .\dcif.dmemREN (dcif.dmemREN),
    .\dcif.dmemWEN (dcif.dmemWEN),
    .\dcif.dmemstore (dcif.dmemstore),
    .\dcif.dmemaddr (dcif.dmemaddr),
    .\dcif.halt (dcif.halt),
    .\dcif.dhit (dcif.dhit),
    .\dcif.dmemload (dcif.dmemload),
    .\dcif.flushed (dcif.flushed),
    .\cif.dwait (cif.dwait),
    .\cif.dload (cif.dload),
    .\cif.ccwait (cif.ccwait),
    .\cif.ccinv (cif.ccinv),
    .\cif.ccsnoopaddr (cif.ccsnoopaddr),
    .\cif.dREN (cif.dREN),
    .\cif.dWEN (cif.dWEN),
    .\cif.daddr (cif.daddr),
    .\cif.dstore (cif.dstore),
    .\cif.ccwrite (cif.ccwrite),
    .\cif.cctrans (cif.cctrans)
  );
`endif

endmodule

program test(
  input logic CLK, 
  output logic nRST,
  datapath_cache_if.dcache dcif_tb,
  caches_if.dcache cif_tb
);
parameter PERIOD = 10;

initial begin
  string test_name = "RESET";
  nRST = 1;
  #(PERIOD);

  nRST = 0;
  #(PERIOD * 2);

  nRST = 1;
  #(PERIOD);

  @(posedge CLK)
  
  // ======================================================
  // TEST1: NO READ OR WRITE
  // ======================================================
  test_name = "NO READ OR WRITE";
  dcif_tb.halt = 0;
  dcif_tb.dmemREN = 0;
  dcif_tb.dmemWEN = 0;
  dcif_tb.dmemstore = '0;
  dcif_tb.dmemaddr = '0;
  cif_tb.dwait = 1;
  cif_tb.dload = '0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;

  #(PERIOD);

  // ======================================================
  // TEST2: READ, MISS | I->S
  // ======================================================
  test_name = "READ, MISS";
  #(PERIOD);

  // CYCLE 1: state = IDLE

  dcif_tb.dmemREN = 1;
  dcif_tb.dmemWEN = 0;
  dcif_tb.dmemstore = '0;
  dcif_tb.dmemaddr = 32'h00aa00ac;  // idx = 5, way1
  cif_tb.dwait = 1;
  cif_tb.dload = 0; 
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);


  // CYCLE 2: state = ACCESS1

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 3: state = ACCESS1

  cif_tb.dwait = 0;
  cif_tb.dload = 32'hDEADBEEF;
  #(PERIOD);

  
  // CYCLE 4: state = ACCESS2

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 5 : state = ACCESS2

  cif_tb.dwait = 0;
  cif_tb.dload = 32'hBEEFDEAD;
  #(PERIOD);


  // CYCLE 6: state = IDLE, get hit

  dcif_tb.dmemREN = 1;
  dcif_tb.dmemWEN = 0;
  dcif_tb.dmemstore = '0;
  dcif_tb.dmemaddr = 32'h00aa00ac;
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);


  // ======================================================
  // TEST3: READ, HIT
  // ======================================================
  test_name = "READ, HIT";

  // CYCLE 1: state = IDLE;

  dcif_tb.dmemREN = 1;
  dcif_tb.dmemWEN = 0;
  dcif_tb.dmemstore = 0;
  dcif_tb.dmemaddr = 32'h00aa00ac;  // idx = 5, way1
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);


  // ======================================================
  // TEST4: WRITE, MISS | I->M
  // ======================================================
  test_name = "WRITE, MISS 1";

  // CYCLE 1: state = IDLE

  dcif_tb.dmemREN = 0;
  dcif_tb.dmemWEN = 1;
  dcif_tb.dmemstore = 32'hBEEFBEEF;
  dcif_tb.dmemaddr = 32'h00001ffd;  // idx = 7, way1
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);


  // CYCLE 2: state = ACCESS1

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 3: state = ACCESS1

  cif_tb.dwait = 0;
  cif_tb.dload = 32'hFEEBFEEB;
  #(PERIOD);


  // CYCLE 4: state = ACCESS2

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 5: state = ACCESS2

  cif_tb.dwait = 0;
  cif_tb.dload = 32'hDAADDEED;
  #(PERIOD);


  // CYCLE 6: state = IDLE, get hit

  dcif_tb.dmemREN = 0;
  dcif_tb.dmemWEN = 1;
  dcif_tb.dmemstore = 32'hBEEFBEEF;
  dcif_tb.dmemaddr = 32'h00001ffd;  // idx = 7, way1
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);


  // ======================================================
  // TEST4: WRITE, MISS | I->M
  // ======================================================
  test_name = "WRITE, MISS 2";

  // CYCLE 1: state = IDLE

  dcif_tb.dmemREN = 0;
  dcif_tb.dmemWEN = 1;
  dcif_tb.dmemstore = 32'hDEADDEAD;
  dcif_tb.dmemaddr = 32'h00004ffd;  // idx = 7, way0
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);

  // CYCLE 2: state = ACCESS1

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 3: state = ACCESS1

  cif_tb.dwait = 0;
  cif_tb.dload = 32'hBBEEAAFF;
  #(PERIOD);


  // CYCLE 4: state = ACCESS2

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 5: state = ACCESS2

  cif_tb.dwait = 0;
  cif_tb.dload = 32'hDDEEAADD;
  #(PERIOD);


  // CYCLE 6: state = IDLE, get hit

  dcif_tb.dmemREN = 0;
  dcif_tb.dmemWEN = 1;
  dcif_tb.dmemstore = 32'hDEADDEAD;
  dcif_tb.dmemaddr = 32'h00004ffd;  // idx = 7, way0
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);


  // ======================================================
  // TEST5: WRITE, MISS, DIRTY
  // ======================================================
  test_name = "WRITE, MISS, DIRTY";

  // CYCLE 1: state = IDLE

  dcif_tb.dmemREN = 0;
  dcif_tb.dmemWEN = 1;
  dcif_tb.dmemstore = 32'hFEEDBEEF;
  dcif_tb.dmemaddr = 32'h00006dfd;  // idx = 7, block 1
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);

  // CYCLE 2: state = WRITE1

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 3: state = WRITE1

  cif_tb.dwait = 0;
  #(PERIOD);


  // CYCLE 4: state = WRITE2

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 5: state = WRITE2

  cif_tb.dwait = 0;
  #(PERIOD);


  // CYCLE 2: state = ACCESS1

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 3: state = ACCESS1

  cif_tb.dwait = 0;
  cif_tb.dload = 32'hFEEBDAED;
  #(PERIOD);


  // CYCLE 4: state = ACCESS2

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 5: state = ACCESS2

  cif_tb.dwait = 0;
  cif_tb.dload = 32'hDBEADBEA;
  #(PERIOD);


  // CYCLE 6: state = IDLE, get hit

  dcif_tb.dmemREN = 0;
  dcif_tb.dmemWEN = 1;
  dcif_tb.dmemstore = 32'hFEEDBEEF;
  dcif_tb.dmemaddr = 32'h00006dfd;
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);


  // ======================================================
  // TEST6: SNOOP FROM IDLE, SNOOP MISS
  // ======================================================
  test_name = "SNOOP FROM IDLE, SNOOP MISS";

  // CYCLE 1: state = IDLE

  dcif_tb.dmemREN = 1;
  dcif_tb.dmemWEN = 0;
  dcif_tb.dmemstore = '0;
  dcif_tb.dmemaddr = 32'h00004c76;  // idx = 6, way1
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 1;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);


  // CYCLE 2: state = SNOOP

  cif_tb.ccsnoopaddr = 32'h00005f22;
  cif_tb.ccinv = 0;
  #(PERIOD)


  // CYCLE 3: state = IDLE

  dcif_tb.dmemREN = 0;
  dcif_tb.dmemWEN = 0;
  dcif_tb.dmemstore = '0;
  dcif_tb.dmemaddr = '0;
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);


  // ======================================================
  // TEST7: SNOOP FROM ACCESS1, SNOOP HIT
  // ======================================================
  test_name = "SNOOP FROM ACCESS1, SNOOP HIT";

  // CYCLE 1: state = IDLE

  dcif_tb.dmemREN = 1;
  dcif_tb.dmemWEN = 0;
  dcif_tb.dmemstore = '0;
  dcif_tb.dmemaddr = 32'h00004c76;  // idx = 6, way1
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);


  // CYCLE 2: state = ACCESS1

  cif_tb.ccwait = 1;
  #(PERIOD);


  // CYCLE 3: state = SNOOP

  cif_tb.ccsnoopaddr = 32'h00004ffd;  // idx = 7, way0
  cif_tb.ccinv = 1;
  #(PERIOD);


  // CYCLE 4: state = WRITE5

  cif_tb.dwait = 1;
  #(PERIOD * 10)


  // CYCLE 5: state = WRITE5

  cif_tb.dwait = 0;
  #(PERIOD);


  // CYCLE 6: state = WRITE6

  cif_tb.dwait = 1;
  #(PERIOD * 10)


  // CYCLE 7: state = WRITE6

  cif_tb.dwait = 0;
  #(PERIOD);


  // CYCLE 8: state = IDLE

  dcif_tb.dmemREN = 0;
  dcif_tb.dmemWEN = 0;
  dcif_tb.dmemstore = '0;
  dcif_tb.dmemaddr = '0;
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);


  // ======================================================
  // TEST8: WRITE, MISS | I->M
  // ======================================================
  test_name = "WRITE, MISS 3";

  // CYCLE 1: state = IDLE

  dcif_tb.dmemREN = 0;
  dcif_tb.dmemWEN = 1;
  dcif_tb.dmemstore = 32'hEADDEEFB;
  dcif_tb.dmemaddr = 32'h0000468b;  // idx = 1, way1
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);

  // CYCLE 2: state = ACCESS1

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 3: state = ACCESS1

  cif_tb.dwait = 0;
  cif_tb.dload = 32'hDBDBEEEA;
  #(PERIOD);


  // CYCLE 4: state = ACCESS2

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 5: state = ACCESS2

  cif_tb.dwait = 0;
  cif_tb.dload = 32'hAFFADEEB;
  #(PERIOD);


  // CYCLE 6: state = IDLE, get hit

  dcif_tb.dmemREN = 0;
  dcif_tb.dmemWEN = 1;
  dcif_tb.dmemstore = 32'hEADDEEFB;
  dcif_tb.dmemaddr = 32'h0000468b;  // idx = 1, way1
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);


  // ======================================================
  // TEST9: SNOOP FROM WRITE3, MISS
  // ======================================================
  test_name = "SNOOP FROM WRITE3, MISS";

  // CYCLE 1: state = IDLE

  dcif.halt = 1;
  dcif_tb.dmemREN = 0;
  dcif_tb.dmemWEN = 0;
  dcif_tb.dmemstore = '0;
  dcif_tb.dmemaddr = '0;
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);


  // CYCLE 2: state = WRITE3

  cif_tb.ccwait = 1;
  #(PERIOD);


  // CYCLE 3: state = SNOOP

  cif_tb.ccsnoopaddr = 32'h000014b2;
  cif_tb.ccinv = 1;
  #(PERIOD)


  // ======================================================
  // TEST10: HALT, FLUSH
  // ======================================================
  test_name = "HALT, FLUSH";

  // CYCLE 1: state = IDLE

  dcif.halt = 1;
  dcif_tb.dmemREN = 0;
  dcif_tb.dmemWEN = 0;
  dcif_tb.dmemstore = '0;
  dcif_tb.dmemaddr = '0;
  cif_tb.dwait = 1;
  cif_tb.dload = 0;
  cif_tb.ccwait = 0;
  cif_tb.ccinv = 0;
  cif_tb.ccsnoopaddr = '0;
  #(PERIOD);


  // CYCLE 2: WRITE3, flushcount 0-8
  cif_tb.dwait = 1;
  #(PERIOD * 9);


  // CYCLE 3: WRITE3, flushcount 9

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 4: WRITE3, flushcount 9

  cif_tb.dwait = 0;
  #(PERIOD);


  // CYCLE 5: WRITE4, flushcount 9

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 6: WRITE4, flushcount 9

  cif_tb.dwait = 0;
  #(PERIOD);


  // CYCLE 7: WRITE3, flushcount 10-15

  cif_tb.dwait = 1;
  #(PERIOD * 5);

  // CYCLE 8: WRITE3, flushcount 16

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 9: WRITE3, flushocunt 16

  cif_tb.dwait = 0;
  #(PERIOD);


  // CYCLE 10: WRITE4, flushcount 16

  cif_tb.dwait = 1;
  #(PERIOD * 10);


  // CYCLE 11: WRITE4, flushcount 16

  cif_tb.dwait = 0;
  #(PERIOD);

  #(PERIOD * 5);

end
endprogram