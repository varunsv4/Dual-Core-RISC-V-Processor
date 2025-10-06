// interface includes
`include "datapath_cache_if.vh"

// all types
`include "cpu_types_pkg.vh"

module icache (
    input CLK, nRST,
    datapath_cache_if dcif,
    caches_if cif
);

// type import
import cpu_types_pkg::*;

typedef enum {
    IDLE,
    ACCESS_MEM
} state_t;

state_t state, next_state;
icache_frame [15:0] icache, next_icache;

icachef_t addr;
assign addr = icachef_t'(dcif.imemaddr);

logic next_iREN;
word_t next_iaddr;


// ======================================================
// ICACHE, STATE, AND VALUE REGISTERS
// ======================================================

always_ff @(posedge CLK, negedge nRST) begin
    if(!nRST)
        icache <= '0;
    else
        icache <= next_icache;
end

always_ff @(posedge CLK, negedge nRST) begin
    if(!nRST)
        state <= IDLE;
    else
        state <= next_state;
end

always_ff @(posedge CLK, negedge nRST) begin
    if(!nRST) begin
        cif.iREN <= 0;
        cif.iaddr <= 0;
    end
    else begin
        cif.iREN <= next_iREN;
        cif.iaddr <= next_iaddr;
    end
end

// ======================================================
// OUTPUT AND NEXT STATE LOGIC
// ======================================================

always_comb begin
    next_state = state;
    next_icache = icache;

    dcif.ihit = 0;
    dcif.imemload = 0;

    next_iREN = cif.iREN;
    next_iaddr = cif.iaddr;

    if(dcif.imemREN) begin
        if(state == IDLE) begin
            if((addr.tag == icache[addr.idx].tag) && icache[addr.idx].valid) begin
                dcif.ihit = 1;
                dcif.imemload = icache[addr.idx].data;
            end
            else begin
                next_state = ACCESS_MEM;
                next_iREN = 1;
                next_iaddr = dcif.imemaddr;
            end
        end
        else begin
            if(!cif.iwait) begin
                next_state = IDLE;
                next_iREN = 0;
                next_iaddr = 0;
                next_icache[addr.idx].valid = 1;
                next_icache[addr.idx].tag = addr.tag;
                next_icache[addr.idx].data = cif.iload;
                dcif.imemload = cif.iload;
                dcif.ihit = 1;
            end
        end
    end
end
endmodule