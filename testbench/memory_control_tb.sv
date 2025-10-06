/*
  Memory Control test bench
*/

// mapped needs these
`include "cache_control_if.vh"
`include "caches_if.vh"
`include "cpu_ram_if.vh"

// all types
`include "cpu_types_pkg.vh"

// import types
import cpu_types_pkg::*;

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interfaces
  caches_if cif0 ();
  caches_if cif1 ();
  cache_control_if ccif (cif0, cif1);
  cpu_ram_if ramif ();

  // test program
  test PROG (CLK, nRST, ccif, cif0);

  // DUT
`ifndef MAPPED
  memory_control DUT(CLK, nRST, ccif);
`else
  memory_control DUT(
    .\CLK (CLK),
    .\nRST (nRST),
    .\ccif.iREN (ccif.iREN),
    .\ccif.dREN (ccif.dREN),
    .\ccif.dWEN (ccif.dWEN),
    .\ccif.dstore (ccif.dstore),
    .\ccif.iaddr (ccif.iaddr),
    .\ccif.daddr (ccif.daddr),
    .\ccif.ramload (ccif.ramload),
    .\ccif.ramstate (ccif.ramstate),
    .\ccif.ccwrite (ccif.ccwrite),
    .\ccif.cctrans (ccif.cctrans),
    .\ccif.iwait (ccif.iwait),
    .\ccif.dwait (ccif.dwait),
    .\ccif.iload (ccif.iload),
    .\ccif.dload (ccif.dload),
    .\ccif.ramstore (ccif.ramstore),
    .\ccif.ramaddr (ccif.ramaddr),
    .\ccif.ramWEN (ccif.ramWEN),
    .\ccif.ramREN (ccif.ramREN),
    .\ccif.ccwait (ccif.ccwait),
    .\ccif.ccinv (ccif.ccinv),
    .\ccif.ccsnoopaddr (ccif.ccsnoopaddr)
  );
`endif

  // RAM
`ifndef MAPPED
  ram RAM(CLK, nRST, ramif);
`else
  ram RAM(
    .\CLK (CLK),
    .\nRST (nRST), .\ramif.ramaddr (ramif.ramaddr), .\ramif.ramstore (ramif.ramstore),
    .\ramif.ramREN (ramif.ramREN),
    .\ramif.ramWEN (ramif.ramWEN),
    .\ramif.ramstate (ramif.ramstate),
    .\ramif.ramload (ramif.ramload)
  );
`endif

assign ramif.ramaddr = ccif.ramaddr;
assign ramif.ramstore = ccif.ramstore;
assign ramif.ramREN = ccif.ramREN;
assign ramif.ramWEN = ccif.ramWEN;
assign ccif.ramstate = ramif.ramstate;
assign ccif.ramload = ramif.ramload;

endmodule

program test(
  input logic CLK, 
  output logic nRST,
  cache_control_if.cc ccif_tb,
  caches_if.caches cif0
);
parameter PERIOD = 10;

task automatic dump_memory();
  string filename = "memcpu.hex";
  int memfd;

  // syif.tbCTRL = 1;
  cif0.daddr = 0;
  cif0.dWEN = 0;
  cif0.dREN = 0;

  memfd = $fopen(filename,"w");
  if (memfd)
    $display("Starting memory dump.");
  else
    begin $display("Failed to open %s.",filename); $finish; end

  for (int unsigned i = 0; memfd && i < 16384; i++)
  begin
    int chksum = 0;
    bit [7:0][7:0] values;
    string ihex;

    cif0.daddr = i << 2;
    cif0.dREN = 1;
    repeat (4) @(posedge CLK);
    if (cif0.dload === 0)
      continue;
    values = {8'h04,16'(i),8'h00,cif0.dload};
    foreach (values[j])
      chksum += values[j];
    chksum = 16'h100 - chksum;
    ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
    $fdisplay(memfd,"%s",ihex.toupper());
  end //for
  if (memfd)
  begin
    // syif.tbCTRL = 0;
    cif0.dREN = 0;
    $fdisplay(memfd,":00000001FF");
    $fclose(memfd);
    $display("Finished memory dump.");
  end
endtask

initial begin

  nRST = 1;
  #(PERIOD);

  nRST = 0;
  #(PERIOD * 2);

  nRST = 1;
  #(PERIOD);

  @(negedge CLK);

  cif0.dWEN = 1'b1;
  cif1.dWEN = 1'b1;
  cif0.dstore = 32'h11;
  cif0.daddr = 32'hF;
  cif1.dstore = 32'hBAD;
  cif1.daddr = 32'hBAD1;
  @(cif0.dwait == 1'b0);
  #(PERIOD);
  @(negedge CLK);
  cif1.dWEN = 1'b0;
  cif0.dstore = 32'h33;
  cif0.daddr = 32'hFF;
  @(cif0.dwait == 1'b0);
  #(PERIOD);
  @(negedge CLK);
  cif0.dWEN = 1'b0;
  #(PERIOD*5);


  @(negedge CLK);

  cif0.dWEN = 1'b1;
  cif1.dWEN = 1'b1;
  cif1.dstore = 32'h66;
  cif1.daddr = 32'h8;
  cif0.dstore = 32'hBAD;
  cif0.daddr = 32'hBAD1;
  @(cif1.dwait == 1'b0);
  #(PERIOD);
  @(negedge CLK);
  cif0.dWEN = 1'b0;
  cif1.dstore = 32'h99;
  cif1.daddr = 32'hF8;
  @(cif1.dwait == 1'b0);
  #(PERIOD);
  @(negedge CLK);
  cif1.dWEN = 1'b0;
  #(PERIOD*5);
  

  cif0.iREN = 1'b1;
  cif1.iREN = 1'b1;
  cif0.iaddr = 32'hF;
  @(cif0.iwait == 1'b0);
  #(PERIOD);
  @(negedge CLK);
  cif1.iaddr = 32'hFF;
  @(cif1.iwait == 1'b0);
  #(PERIOD);
  cif0.iREN = 1'b1;
  cif1.iREN = 1'b1;
  cif0.iaddr = 32'h8;
  @(cif0.iwait == 1'b0);
  #(PERIOD);
  @(negedge CLK);
  cif1.iaddr = 32'hF8;
  @(cif1.iwait == 1'b0);
  #(PERIOD);
  cif0.iREN = 1'b0;
  cif1.iREN = 1'b0;
  #(PERIOD*5);

  @(negedge CLK);
  cif0.dREN = 1'b1;
  cif1.dREN = 1'b1;
  cif0.daddr = 32'h8;
  cif0.ccwrite = 1'b1;
  #(PERIOD);
  cif1.cctrans = 1'b0;
  #(PERIOD);
  @(cif0.dwait == 1'b0);
  #(PERIOD);
  @(negedge CLK);
  cif0.daddr = 32'hf8;
  @(cif0.dwait == 1'b0);
  #(PERIOD);
  @(negedge CLK);
  cif0.dREN = 1'b0;
  cif1.dREN = 1'b0;
  #(PERIOD);

  @(negedge CLK);
  cif0.dREN = 1'b1;
  cif1.dREN = 1'b1;
  cif1.daddr = 32'hf;
  cif1.ccwrite = 1'b1;
  #(PERIOD);
  cif0.cctrans = 1'b0;
  #(PERIOD);
  @(cif1.dwait == 1'b0);
  #(PERIOD);
  @(negedge CLK);
  cif1.daddr = 32'hff;
  @(cif1.dwait == 1'b0);
  #(PERIOD);
  @(negedge CLK);
  cif0.dREN = 1'b0;
  cif1.dREN = 1'b0;
  #(PERIOD*5);

  @(negedge CLK);
  cif0.dREN = 1'b1;
  cif1.dREN = 1'b1;
  cif0.daddr = 32'h8;
  cif0.ccwrite = 1'b1;
  #(PERIOD);
  cif1.cctrans = 1'b1;
  #(PERIOD);
  cif1.dWEN = 1'b1;
  cif1.dstore = 32'h0f0f;
  @(cif0.dwait == 1'b0);
  #(PERIOD);
  @(negedge CLK);
  cif0.daddr = 32'hf8;
  cif1.dWEN = 1'b1;
  cif1.dstore = 32'hf0f0;
  @(cif0.dwait == 1'b0);
  #(PERIOD);
  @(negedge CLK);
  cif0.dREN = 1'b0;
  cif1.dREN = 1'b0;
  cif1.dWEN = 1'b0;
  #(PERIOD);

  @(negedge CLK);
  cif0.dREN = 1'b1;
  cif1.dREN = 1'b1;
  cif1.daddr = 32'hf;
  cif1.ccwrite = 1'b1;
  #(PERIOD);
  cif0.cctrans = 1'b1;
  #(PERIOD);
  cif0.dWEN = 1'b1;
  cif0.dstore = 32'h0f0f0000;
  @(cif1.dwait == 1'b0);
  #(PERIOD);
  @(negedge CLK);
  cif1.daddr = 32'hff;
  cif0.dWEN = 1'b1;
  cif0.dstore = 32'hf0f00000;
  @(cif1.dwait == 1'b0);
  #(PERIOD);
  @(negedge CLK);
  cif0.dREN = 1'b0;
  cif1.dREN = 1'b0;
  cif0.dWEN = 1'b0;
  #(PERIOD*5);



  
//   // TEST1: SW iREN, ramstate A

//   cif0.iREN = 1;
//   cif0.dREN = 0;
//   cif0.dWEN = 0;
//   cif0.dstore = 0;
//   cif0.iaddr = 32'h00df8200;
//   cif0.daddr = 0;

//   #(5ns);

//   // if(ccif_tb.iwait != 0)
//   //   $display("TEST1: incorrect 'iwait'");
//   if(ccif_tb.dwait != 1)
//     $display("TEST1: incorrect 'dwait'");
//   if(ccif_tb.iload != 0)
//     $display("TEST1: incorrect 'iload'");
//   if(ccif_tb.dload != 0)
//     $display("TEST1: incorrect 'dload'");
//   if(ccif_tb.ramstore != 0)
//     $display("TEST1: incorrect 'ramstore'");
//   if(ccif_tb.ramaddr != 32'h00df8200)
//     $display("TEST1: incorrect 'ramaddr'");
//   if(ccif_tb.ramWEN != 0)
//     $display("TEST1: incorrect 'ramWEN'");
//   if(ccif_tb.ramREN != 1)
//     $display("TEST1: incorrect 'ramREN'");

//   #(5ns);

//   // TEST2: SW dWEN, ramstate B

//   cif0.iREN = 1;
//   cif0.dREN = 0;
//   cif0.dWEN = 1;
//   cif0.dstore = 32'habcdabcd;
//   cif0.iaddr = 32'h00df8200;
//   cif0.daddr = 32'h00000500;

//   #(5ns);

//   if(ccif_tb.iwait != 1)
//     $display("TEST2: incorrect 'iwait'");
//   if(ccif_tb.dwait != 1)
//     $display("TEST2: incorrect 'dwait'");
//   if(ccif_tb.iload != 0)
//     $display("TEST2: incorrect 'iload'");
//   if(ccif_tb.dload != 0)
//     $display("TEST2: incorrect 'dload'");
//   if(ccif_tb.ramstore != 32'habcdabcd)
//     $display("TEST2: incorrect 'ramstore'");
//   if(ccif_tb.ramaddr != 32'h00000500)
//     $display("TEST2: incorrect 'ramaddr'");
//   if(ccif_tb.ramWEN != 1)
//     $display("TEST2: incorrect 'ramWEN'");
//   if(ccif_tb.ramREN != 0)
//     $display("TEST2: incorrect 'ramREN'");
  
//   #(5ns);


//   // TEST3: SW dWEN, ramstate A

//   cif0.iREN = 1;
//   cif0.dREN = 0;
//   cif0.dWEN = 1;
//   cif0.dstore = 32'habcdabcd;
//   cif0.iaddr = 32'h00df8200;
//   cif0.daddr = 32'h00000500;

//   #(5ns);

//   if(ccif_tb.iwait != 1)
//     $display("TEST3: incorrect 'iwait'");
//   if(ccif_tb.dwait != 0)
//     $display("TEST3: incorrect 'dwait'");
//   if(ccif_tb.iload != 0)
//     $display("TEST3: incorrect 'iload'");
//   if(ccif_tb.dload != 0)
//     $display("TEST3: incorrect 'dload'");
//   if(ccif_tb.ramstore != 32'habcdabcd)
//     $display("TEST3: incorrect 'ramstore'");
//   if(ccif_tb.ramaddr != 32'h00000500)
//     $display("TEST3: incorrect 'ramaddr'");
//   if(ccif_tb.ramWEN != 1)
//     $display("TEST3: incorrect 'ramWEN'");
//   if(ccif_tb.ramREN != 0)
//     $display("TEST3: incorrect 'ramREN'");
  
//   #(5ns);

//   // TEST4: LW iREN, ramstate B

//   cif0.iREN = 1;
//   cif0.dREN = 0;
//   cif0.dWEN = 0;
//   cif0.dstore = 0;
//   cif0.iaddr = 32'h0000ff00;
//   cif0.daddr = 0;

//   #(5ns);

//   if(ccif_tb.iwait != 1)
//     $display("TEST4: incorrect 'iwait'");
//   if(ccif_tb.dwait != 1)
//     $display("TEST4: incorrect 'dwait'");
//   if(ccif_tb.iload != 0)
//     $display("TEST4: incorrect 'iload'");
//   if(ccif_tb.dload != 0)
//     $display("TEST4: incorrect 'dload'");
//   if(ccif_tb.ramstore != 0)
//     $display("TEST4: incorrect 'ramstore'");
//   if(ccif_tb.ramaddr != 32'h0000ff00)
//     $display("TEST4: incorrect 'ramaddr'");
//   if(ccif_tb.ramWEN != 0)
//     $display("TEST4: incorrect 'ramWEN'");
//   if(ccif_tb.ramREN != 1)
//     $display("TEST4: incorrect 'ramREN'");
  
//   #(5ns);

  
//   // TEST5: LW iREN, ramstate A

//   cif0.iREN = 1;
//   cif0.dREN = 0;
//   cif0.dWEN = 0;
//   cif0.dstore = 0;
//   cif0.iaddr = 32'h0000ff00;
//   cif0.daddr = 0;

//   #(5ns);

//   if(ccif_tb.iwait != 0)
//     $display("TEST5: incorrect 'iwait'");
//   if(ccif_tb.dwait != 1)
//     $display("TEST5: incorrect 'dwait'");
//   if(ccif_tb.iload != 0)
//     $display("TEST5: incorrect 'iload'");
//   if(ccif_tb.dload != 0)
//     $display("TEST5: incorrect 'dload'");
//   if(ccif_tb.ramstore != 0)
//     $display("TEST5: incorrect 'ramstore'");
//   if(ccif_tb.ramaddr != 32'h0000ff00)
//     $display("TEST5: incorrect 'ramaddr'");
//   if(ccif_tb.ramWEN != 0)
//     $display("TEST5: incorrect 'ramWEN'");
//   if(ccif_tb.ramREN != 1)
//     $display("TEST5: incorrect 'ramREN'");

//   #(5ns);

  
//   // TEST6: LW dREN, ramstate B

//   cif0.iREN = 1;
//   cif0.dREN = 1;
//   cif0.dWEN = 0;
//   cif0.dstore = 0;
//   cif0.iaddr = 32'h0000ff00;
//   cif0.daddr = 32'h00000500;

//   #(5ns);

//   if(ccif_tb.iwait != 1)
//     $display("TEST6: incorrect 'iwait'");
//   if(ccif_tb.dwait != 1)
//     $display("TEST6: incorrect 'dwait'");
//   if(ccif_tb.iload != 0)
//     $display("TEST6: incorrect 'iload'");
//   if(ccif_tb.dload != 0)
//     $display("TEST6: incorrect 'dload'");
//   if(ccif_tb.ramstore != 0)
//     $display("TEST6: incorrect 'ramstore'");
//   if(ccif_tb.ramaddr != 32'h00000500)
//     $display("TEST6: incorrect 'ramaddr'");
//   if(ccif_tb.ramWEN != 0)
//     $display("TEST6: incorrect 'ramWEN'");
//   if(ccif_tb.ramREN != 1)
//     $display("TEST6: incorrect 'ramREN'");
  
//   #(5ns);


//   // TEST7: LW dREN, ramstate A

//   cif0.iREN = 1;
//   cif0.dREN = 1;
//   cif0.dWEN = 0;
//   cif0.dstore = 0;
//   cif0.iaddr = 32'h0000ff00;
//   cif0.daddr = 32'h00000500;

//   #(5ns);

//   if(ccif_tb.iwait != 1)
//     $display("TEST7: incorrect 'iwait'");
//   if(ccif_tb.dwait != 0)
//     $display("TEST7: incorrect 'dwait'");
//   if(ccif_tb.iload != 0)
//     $display("TEST7: incorrect 'iload'");
//   if(ccif_tb.dload != 32'habcdabcd)
//     $display("TEST7: incorrect 'dload'");
//   if(ccif_tb.ramstore != 0)
//     $display("TEST7: incorrect 'ramstore'");
//   if(ccif_tb.ramaddr != 32'h00000500)
//     $display("TEST7: incorrect 'ramaddr'");
//   if(ccif_tb.ramWEN != 0)
//     $display("TEST7: incorrect 'ramWEN'");
//   if(ccif_tb.ramREN != 1)
//     $display("TEST7: incorrect 'ramREN'");
  
//   #(5ns);

  dump_memory();

  $finish;

end
endprogram