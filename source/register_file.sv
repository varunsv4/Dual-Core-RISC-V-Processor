`include "register_file_if.vh"

module register_file (
    input logic CLK, nRST, register_file_if.rf rfif
);

logic [31:0][31:0] regs;
logic [31:0][31:0] next_regs;

always_ff @(negedge CLK, negedge nRST) begin
    if(!nRST)
        regs <= '0;
    else
        regs <= next_regs;
end

assign rfif.rdat1 = regs[rfif.rsel1];
assign rfif.rdat2 = regs[rfif.rsel2];

always_comb begin
    next_regs = regs;

    if(rfif.WEN && (rfif.wsel != '0))
        next_regs[rfif.wsel] = rfif.wdat;
end

endmodule