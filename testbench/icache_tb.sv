`include "caches_if.vh"
`include "datapath_cache_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

`timescale 1 ns / 1 ns

module icache_tb;


    parameter PERIOD = 10;

    logic CLK = 0, nRST;

  // clock
    always #(PERIOD/2) CLK++;

    caches_if cif();
    datapath_cache_if dpif();

    test PROG(CLK, nRST, dpif, cif);

    icache DUT(CLK, nRST, dpif, cif);


endmodule

program test(
  input logic CLK, 
  output logic nRST,
  datapath_cache_if.icache dpif,
  caches_if.icache cif
);
parameter PERIOD = 10;
initial begin
  static string test_name = "reset DUT";
  nRST = 1;
  #(PERIOD);

  nRST = 0;
  #(PERIOD * 2);

  nRST = 1;
  #(PERIOD);

  test_name = "1: Read, Miss";
  @(negedge CLK);
  dpif.imemREN = 1'b1;
  dpif.imemaddr = 32'hf0f0f0f0;
  cif.iwait = 1'b1;
  #(PERIOD);
  cif.iload = 32'h12345678;
  cif.iwait = 1'b0;
  #(PERIOD);
  test_name = "2: Read, Miss";
  dpif.imemaddr = 32'hadbdabcd;
  cif.iwait = 1'b1;
  #(PERIOD);
  cif.iload = 32'h87654321;
  cif.iwait = 1'b0;
  #(PERIOD);
  test_name = "3: Read, Miss, Replace";
  dpif.imemaddr = 32'h0000abcd;
  cif.iwait = 1'b1;
  #(PERIOD);
  cif.iload = 32'hffff0000;
  cif.iwait = 1'b0;
  #(PERIOD);
  test_name = "4: Read, Miss";
  dpif.imemaddr = 32'h00001111;
  cif.iwait = 1'b1;
  #(PERIOD);
  cif.iload = 32'h01010101;
  cif.iwait = 1'b0;
  #(PERIOD);
  test_name = "5: Read, Hit";
  dpif.imemaddr = 32'hf0f0f0f0;
  cif.iwait = 1'b1;
  #(PERIOD);
  test_name = "6: Read, Hit";
  dpif.imemaddr = 32'h0000abcd;
  cif.iwait = 1'b1;
  #(PERIOD);
  // cif.iload = 32'h01010101;
  // cif.iwait = 1'b0;
  // #(PERIOD);
  // dpif.imemREN = 1'b1;

end
endprogram