/*
  Request Unit Test Bench
*/

// mapped needs these
`include "forwarding_unit_if.vh"

// all types
`include "cpu_types_pkg.vh"

// import types
import cpu_types_pkg::*;

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module forwarding_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interfaces
  forwarding_unit_if fuif ();

  // test program
  test PROG (fuif);


  forwarding_unit DUT(fuif);


endmodule

program test(
  forwarding_unit_if.tb fuif_tb
);
parameter PERIOD = 10;

initial begin
    fuif_tb.wsel_MEM = '0;
    #(PERIOD);
    fuif_tb.RegWr_MEM = 1'b1;
    fuif_tb.wsel_MEM = 5'd5;
    fuif_tb.rs1_EX = 5'd5;
    #(PERIOD);
    fuif_tb.wsel_MEM = 5'd5;
    fuif_tb.rs2_EX = 5'd5;
    #(PERIOD);
    fuif_tb.rs1_EX = 5'd3;
    #(PERIOD);
    fuif_tb.wsel_WB = 5'd3;
    fuif_tb.RegWr_WB = 1'b1;
    #(PERIOD);
    fuif_tb.rs2_EX = 5'd3;
    #(PERIOD);
    fuif_tb.rs1_EX = 5'd5;
    #(PERIOD);
end
endprogram