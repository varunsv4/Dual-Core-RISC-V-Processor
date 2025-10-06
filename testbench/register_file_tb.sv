

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK, nRST, rfif);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

integer i;
integer j;

program test(
  input logic CLK, 
  output logic nRST,
  register_file_if.tb rfif_tb
);
parameter PERIOD = 10;
initial begin
  nRST = 1;
  #(PERIOD);

  nRST = 0;
  #(PERIOD * 2);

  nRST = 1;
  #(PERIOD);

  rfif_tb.WEN = 1;

  for(i = 0; i < 32; i++) begin
    rfif_tb.wsel = i;
    if(i == 0)
      rfif_tb.wdat = 32;
    else
      rfif_tb.wdat = i * 32;
    #(PERIOD);
  end

  rfif_tb.WEN = 0;

  for(i = 0; i < 32; i+= 2) begin
    rfif_tb.rsel1 = i;
    rfif_tb.rsel2 = i + 1;
    #(PERIOD);

    if(rfif_tb.rdat1 != (i * 32))
      $display("error: i = ", i);
    if(rfif_tb.rdat2 != ((i + 1) * 32))
      $display("error: i = ", i+1);
  end

end
endprogram
