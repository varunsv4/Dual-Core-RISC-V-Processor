/*
  Arithmetic Logic Unit test bench
*/

// mapped needs this
`include "alu_if.vh"

// all types
`include "cpu_types_pkg.vh"

// import types
import cpu_types_pkg::*;

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_tb;

  parameter PERIOD = 10;

  // interface
  alu_if aluif ();

  // test program
  test PROG (aluif);
  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
    .\aluif.aluop (aluif.aluop),
    .\aluif.porta (aluif.porta),
    .\aluif.portb (aluif.portb),
    .\aluif.negative (aluif.negative),
    .\aluif.portout (aluif.portout),
    .\aluif.overflow (aluif.overflow),
    .\aluif.zero (aluif.zero)
  );
`endif

endmodule

program test(
  alu_if.tb aluif_tb
);
parameter PERIOD = 10;
initial begin

  // TEST1: ALU_SLL

  aluif_tb.aluop = ALU_SLL;
  aluif_tb.porta = 32'haabbccdd;
  aluif_tb.portb = 32'd4;

  #(5ns);

  if(aluif_tb.negative != 1)
    $display("TEST1: incorrect 'negative'");
  if(aluif_tb.portout != 32'habbccdd0)
    $display("TEST1: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST1: incorrect 'overflow'");
  if(aluif_tb.zero != 0)
    $display("TEST1: incorrect 'zero'");

  #(5ns);
  

  // TEST2: ALU_SRL

  aluif_tb.aluop = ALU_SRL;
  aluif_tb.porta = 32'haabbccdd;
  aluif_tb.portb = 32'd4;

  #(5ns);

  if(aluif_tb.negative != 0)
    $display("TEST2: incorrect 'negative'");
  if(aluif_tb.portout != 32'h0aabbccd)
    $display("TEST2: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST2: incorrect 'overflow'");
  if(aluif_tb.zero != 0)
    $display("TEST2: incorrect 'zero'");
  
  #(5ns);


  // TEST3: ALU_SRA negative

  aluif_tb.aluop = ALU_SRA;
  aluif_tb.porta = 32'h87654321;
  aluif_tb.portb = 32'd8;

  #(5ns);

  if(aluif_tb.negative != 1)
    $display("TEST3: incorrect 'negative'");
  if(aluif_tb.portout != 32'hff876543)
    $display("TEST3: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST3: incorrect 'overflow'");
  if(aluif_tb.zero != 0)
    $display("TEST3: incorrect 'zero'");
  
  #(5ns);

  
  // TEST4: ALU_SRA positive

  aluif_tb.aluop = ALU_SRA;
  aluif_tb.porta = 32'h12345678;
  aluif_tb.portb = 32'd8;

  #(5ns);

  if(aluif_tb.negative != 0)
    $display("TEST4: incorrect 'negative'");
  if(aluif_tb.portout != 32'h00123456)
    $display("TEST4: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST4: incorrect 'overflow'");
  if(aluif_tb.zero != 0)
    $display("TEST4: incorrect 'zero'");

  #(5ns);

  
  // TEST5: ADD basic

  aluif_tb.aluop = ALU_ADD;
  aluif_tb.porta = 32'd20;
  aluif_tb.portb = 32'd8;

  #(5ns);

  if(aluif_tb.negative != 0)
    $display("TEST5: incorrect 'negative'");
  if(aluif_tb.portout != 32'd28)
    $display("TEST5: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST5: incorrect 'overflow'");
  if(aluif_tb.zero != 0)
    $display("TEST5: incorrect 'zero'");

  #(5ns);


  // TEST6: ADD overflow 1

  aluif_tb.aluop = ALU_ADD;
  aluif_tb.porta = 32'h80000001;
  aluif_tb.portb = 32'h80000001;

  #(5ns);

  if(aluif_tb.negative != 0)
    $display("TEST6: incorrect 'negative'");
  // if(aluif_tb.portout != -32'd9)
  //   $display("TEST6: incorrect 'portout'");
  if(aluif_tb.overflow != 1)
    $display("TEST6: incorrect 'overflow'");
  if(aluif_tb.zero != 0)
    $display("TEST6: incorrect 'zero'");

  #(5ns);

  
  // TEST7: ADD zero

  aluif_tb.aluop = ALU_ADD;
  aluif_tb.porta = 32'd29;
  aluif_tb.portb = -32'd29;

  #(5ns);

  if(aluif_tb.negative != 0)
    $display("TEST7: incorrect 'negative'");
  if(aluif_tb.portout != 32'd0)
    $display("TEST7: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST7: incorrect 'overflow'");
  if(aluif_tb.zero != 1)
    $display("TEST7: incorrect 'zero'");

  #(5ns);


  // TEST8: ADD overflow 2

  aluif_tb.aluop = ALU_ADD;
  aluif_tb.porta = 32'h7fffffff;
  aluif_tb.portb = 32'h7fffffff;

  #(5ns);

  if(aluif_tb.negative != 1)
    $display("TEST8: incorrect 'negative'");
  // if(aluif_tb.portout != -32'd9)
  //   $display("TEST8: incorrect 'portout'");
  if(aluif_tb.overflow != 1)
    $display("TEST8: incorrect 'overflow'");
  if(aluif_tb.zero != 0)
    $display("TEST8: incorrect 'zero'");
  
  #(5ns);


  // TEST9: SUB basic

  aluif_tb.aluop = ALU_SUB;
  aluif_tb.porta = 32'd20;
  aluif_tb.portb = 32'd8;

  #(5ns);

  if(aluif_tb.negative != 0)
    $display("TEST9: incorrect 'negative'");
  if(aluif_tb.portout != 32'd12)
    $display("TEST9: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST9: incorrect 'overflow'");
  if(aluif_tb.zero != 0)
    $display("TEST9: incorrect 'zero'");

  #(5ns);


  // TEST10: SUB overflow 1

  aluif_tb.aluop = ALU_SUB;
  aluif_tb.porta = 32'h7fffffff;
  aluif_tb.portb = 32'h80000000;

  #(5ns);

  if(aluif_tb.negative != 1)
    $display("TEST10: incorrect 'negative'");
  // if(aluif_tb.portout != -32'd15)
  //   $display("TEST10: incorrect 'portout'");
  if(aluif_tb.overflow != 1)
    $display("TEST10: incorrect 'overflow'");
  if(aluif_tb.zero != 0)
    $display("TEST10: incorrect 'zero'");

  #(5ns);


  // TEST11: SUB zero

  aluif_tb.aluop = ALU_SUB;
  aluif_tb.porta = 32'd29;
  aluif_tb.portb = 32'd29;

  #(5ns);

  if(aluif_tb.negative != 0)
    $display("TEST11: incorrect 'negative'");
  if(aluif_tb.portout != 32'd0)
    $display("TEST11: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST11: incorrect 'overflow'");
  if(aluif_tb.zero != 1)
    $display("TEST11: incorrect 'zero'");
  
  #(5ns);


  // TEST12: SUB overflow 2

  aluif_tb.aluop = ALU_SUB;
  aluif_tb.porta = 32'h80000000;
  aluif_tb.portb = 32'h7fffffff;

  #(5ns);

  if(aluif_tb.negative != 0)
    $display("TEST12: incorrect 'negative'");
  // if(aluif_tb.portout != -32'd9)
  //   $display("TEST12: incorrect 'portout'");
  if(aluif_tb.overflow != 1)
    $display("TEST12: incorrect 'overflow'");
  if(aluif_tb.zero != 0)
    $display("TEST12: incorrect 'zero'");

  #(5ns);

  
  // TEST13: AND ZERO

  aluif_tb.aluop = ALU_AND;
  aluif_tb.porta = 32'hf0f0f0f0;
  aluif_tb.portb = 32'h0f0f0f0f;

  #(5ns);

  if(aluif_tb.negative != 0)
    $display("TEST13: incorrect 'negative'");
  if(aluif_tb.portout != 32'd0)
    $display("TEST13: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST13: incorrect 'overflow'");
  if(aluif_tb.zero != 1)
    $display("TEST13: incorrect 'zero'");

  #(5ns);

  
  // TEST14: AND NEGATIVE

  aluif_tb.aluop = ALU_AND;
  aluif_tb.porta = 32'hf0a1f085;
  aluif_tb.portb = 32'hffa50f95;

  #(5ns);

  if(aluif_tb.negative != 1)
    $display("TEST14: incorrect 'negative'");
  if(aluif_tb.portout != 32'hf0a10085)
    $display("TEST14: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST14: incorrect 'overflow'");
  if(aluif_tb.zero != 0)
    $display("TEST14: incorrect 'zero'");

  #(5ns);


  // TEST15: OR ZERO

  aluif_tb.aluop = ALU_OR;
  aluif_tb.porta = 32'h00000000;
  aluif_tb.portb = 32'h00000000;

  #(5ns);

  if(aluif_tb.negative != 0)
    $display("TEST15: incorrect 'negative'");
  if(aluif_tb.portout != 32'd0)
    $display("TEST15: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST15: incorrect 'overflow'");
  if(aluif_tb.zero != 1)
    $display("TEST15: incorrect 'zero'");
  
  #(5ns);

  
  // TEST16: OR NEGATIVE

  aluif_tb.aluop = ALU_OR;
  aluif_tb.porta = 32'hf0f0f0f0;
  aluif_tb.portb = 32'h0f0f0f0f;

  #(5ns);

  if(aluif_tb.negative != 1)
    $display("TEST16: incorrect 'negative'");
  if(aluif_tb.portout != 32'hffffffff)
    $display("TEST16: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST16: incorrect 'overflow'");
  if(aluif_tb.zero != 0)
    $display("TEST16: incorrect 'zero'");

  #(5ns);

  
  // TEST17: XOR ZERO

  aluif_tb.aluop = ALU_XOR;
  aluif_tb.porta = 32'habababab;
  aluif_tb.portb = 32'habababab;

  #(5ns);

  if(aluif_tb.negative != 0)
    $display("TEST17: incorrect 'negative'");
  if(aluif_tb.portout != 32'd0)
    $display("TEST17: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST17: incorrect 'overflow'");
  if(aluif_tb.zero != 1)
    $display("TEST17: incorrect 'zero'");

  #(5ns);


  // TEST18: XOR NEGATIVE

  aluif_tb.aluop = ALU_XOR;
  aluif_tb.porta = 32'hf85ab0c0;
  aluif_tb.portb = 32'h091abf0b;

  #(5ns);

  if(aluif_tb.negative != 1)
    $display("TEST18: incorrect 'negative'");
  if(aluif_tb.portout != 32'hf1400fcb)
    $display("TEST18: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST18: incorrect 'overflow'");
  if(aluif_tb.zero != 0)
    $display("TEST18: incorrect 'zero'");
  
  #(5ns);

  
  // TEST19: SLT ZERO

  aluif_tb.aluop = ALU_SLT;
  aluif_tb.porta = 32'd31;
  aluif_tb.portb = 32'd31;

  #(5ns);

  if(aluif_tb.negative != 0)
    $display("TEST19: incorrect 'negative'");
  if(aluif_tb.portout != 32'd0)
    $display("TEST19: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST19: incorrect 'overflow'");
  if(aluif_tb.zero != 1)
    $display("TEST19: incorrect 'zero'");

  #(5ns);

  
  // TEST20: SLT ONE

  aluif_tb.aluop = ALU_SLT;
  aluif_tb.porta = 32'hffffffff;
  aluif_tb.portb = 32'd17;

  #(5ns);

  if(aluif_tb.negative != 0)
    $display("TEST20: incorrect 'negative'");
  if(aluif_tb.portout != 32'd1)
    $display("TEST20: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST20: incorrect 'overflow'");
  if(aluif_tb.zero != 0)
    $display("TEST20: incorrect 'zero'");

  #(5ns);

  
  // TEST21: SLTU ZERO

  aluif_tb.aluop = ALU_SLTU;
  aluif_tb.porta = 32'hffffffff;
  aluif_tb.portb = 32'd31;

  #(5ns);

  if(aluif_tb.negative != 0)
    $display("TEST21: incorrect 'negative'");
  if(aluif_tb.portout != 32'd0)
    $display("TEST21: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST21: incorrect 'overflow'");
  if(aluif_tb.zero != 1)
    $display("TEST21: incorrect 'zero'");

  #(5ns);

  
  // TEST22: SLTU ZERO

  aluif_tb.aluop = ALU_SLTU;
  aluif_tb.porta = 32'd16;
  aluif_tb.portb = 32'hffffffef;

  #(5ns);

  if(aluif_tb.negative != 0)
    $display("TEST22: incorrect 'negative'");
  if(aluif_tb.portout != 32'd1)
    $display("TEST22: incorrect 'portout'");
  if(aluif_tb.overflow != 0)
    $display("TEST22: incorrect 'overflow'");
  if(aluif_tb.zero != 0)
    $display("TEST22: incorrect 'zero'");

  #(5ns);
  
end
endprogram
