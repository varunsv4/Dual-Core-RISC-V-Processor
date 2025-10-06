

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

// states

typedef enum {
    IDLE,
    SEND,
    WB1,
    WB2,
    SNOOP,
    CTC1,
    CTC2,
    RTC1,
    RTC2,
    FETCH
} state_t;


// status variables

state_t state, next_state;
logic core, next_core;
logic lrc, next_lrc;


// registered coherence variables

word_t reg_ccsnoopaddr, next_reg_ccsnoopaddr;
logic reg_ccinv, next_reg_ccinv;

// ======================================================
// REGISTERS
// ======================================================

always_ff @(posedge CLK, negedge nRST) begin
    if(!nRST) begin
        state <= IDLE;
        core <= 0;
        lrc <= 0;
        reg_ccsnoopaddr <= 0;
        reg_ccinv <= 0;
    end
    else begin
        state <= next_state;
        core <= next_core;
        lrc <= next_lrc;
        reg_ccsnoopaddr <= next_reg_ccsnoopaddr;
        reg_ccinv <= next_reg_ccinv;
    end
end


// ======================================================
// NEXT __ LOGIC
// ======================================================

always_comb begin
    next_state = state;
    next_core = core;
    next_lrc = lrc;
    next_reg_ccsnoopaddr = reg_ccsnoopaddr;
    next_reg_ccinv = reg_ccinv;

    casez(state)
        IDLE: begin
            if(ccif.dWEN[lrc]) begin
                next_state = WB1;
                next_core = lrc;
            end
            else if(ccif.dWEN[!lrc]) begin
                next_state = WB1;
                next_core = !lrc;
            end
            else if(ccif.dREN[lrc]) begin
                next_state = SEND;
                next_core = lrc;
                next_reg_ccsnoopaddr = ccif.daddr[lrc];
                next_reg_ccinv = ccif.ccwrite[lrc];
            end
            else if(ccif.dREN[!lrc]) begin
                next_state = SEND;
                next_core = !lrc;
                next_reg_ccsnoopaddr = ccif.daddr[!lrc];
                next_reg_ccinv = ccif.ccwrite[!lrc];
            end
            // else if(ccif.ccwrite[lrc]) begin
            //     next_reg_ccsnoopaddr = ccif.daddr[lrc];
            //     next_reg_ccinv = ccif.ccwrite[lrc];
            //     next_core = lrc;
            // end
            // else if(ccif.ccwrite[!lrc]) begin
            //     next_reg_ccsnoopaddr = ccif.daddr[!lrc];
            //     next_reg_ccinv = ccif.ccwrite[!lrc];
            //     next_core = !lrc;

            // end
            else if(ccif.iREN[lrc]) begin
                next_state = FETCH;
                next_core = lrc;
            end
            else if(ccif.iREN[!lrc]) begin
                next_state = FETCH;
                next_core = !lrc;
            end
        end
        SEND: next_state = SNOOP;
        WB1: begin
            if(ccif.ramstate == ACCESS)
                next_state = WB2;
        end
        WB2: begin
            if(ccif.ramstate == ACCESS) begin
                next_state = IDLE;
                next_lrc = !core;
            end
        end
        SNOOP: begin
            if(ccif.cctrans[!core])   //What if its neither
                next_state = CTC1;
            else
                next_state = RTC1;
            next_reg_ccinv = 0;
        end
        CTC1: begin
            if(ccif.ramstate == ACCESS) begin
                next_state = CTC2;
            end
        end
        CTC2: begin
            if(ccif.ramstate == ACCESS) begin
                next_state = IDLE;
                next_lrc = !core;
            end
        end
        RTC1: begin
            if(ccif.ramstate == ACCESS) begin
                next_state = RTC2;
            end
        end
        RTC2: begin
            if(ccif.ramstate == ACCESS) begin
                next_state = IDLE;
                next_lrc = !core;
            end
        end
        FETCH: begin
            if(ccif.ramstate == ACCESS) begin
                next_state = IDLE;
                next_lrc = !core;
            end
        end
    endcase
end


// ======================================================
// STATE OUTPUT LOGIC
// ======================================================

always_comb begin
    ccif.iwait = 2'b11;
    ccif.dwait = 2'b11;
    ccif.iload = '0;
    ccif.dload = '0;
    ccif.ramstore = '0;
    ccif.ramaddr = '0;
    ccif.ramWEN = 0;
    ccif.ramREN = 0;
    ccif.ccwait = '0;
    ccif.ccinv = '0;
    ccif.ccsnoopaddr = '0;

    casez(state)
        IDLE: begin
            // if(!ccif.dWEN) begin
            //     if(ccif.dREN[lrc])
            //         ccif.ccwait[!lrc] = 1;
            //     else if(ccif.dREN[!lrc])
            //         ccif.ccwait[lrc] = 1;
            // end
            ccif.ccsnoopaddr[!core] = reg_ccsnoopaddr;
            ccif.ccinv[!core] = reg_ccinv;
        end
        SEND: begin
            ccif.ccwait[!core] = 1;
            ccif.ccsnoopaddr[!core] = reg_ccsnoopaddr;
            ccif.ccinv[!core] = reg_ccinv;
        end
        WB1, WB2: begin
            ccif.ramWEN = ccif.dWEN[core];
            ccif.ramaddr = ccif.daddr[core];
            ccif.ramstore = ccif.dstore[core];

            if(ccif.ramstate == ACCESS)
                ccif.dwait[core] = 0;
        end
        SNOOP: begin
            ccif.ccwait[!core] = 1;
            ccif.ccsnoopaddr[!core] = reg_ccsnoopaddr;
            ccif.ccinv[!core] = reg_ccinv;
        end
        CTC1, CTC2: begin
            ccif.ccwait[!core] = 1;
            ccif.ccsnoopaddr[!core] = reg_ccsnoopaddr;
            ccif.ccinv[!core] = reg_ccinv;
            ccif.ramWEN = 1;
            ccif.ramaddr = ccif.daddr[core];
            ccif.ramstore = ccif.dstore[!core];
            ccif.dload[core] = ccif.dstore[!core];

            if(ccif.ramstate == ACCESS)
                ccif.dwait = '0;
        end
        RTC1, RTC2: begin
            ccif.ramREN = ccif.dREN[core];
            ccif.ramaddr = ccif.daddr[core];

            if(ccif.ramstate == ACCESS) begin
                ccif.dload[core] = ccif.ramload;
                ccif.dwait[core] = 0;
            end
        end
        FETCH: begin
            ccif.ramREN = ccif.iREN[core];
            ccif.ramaddr = ccif.iaddr[core];

            if(ccif.ramstate == ACCESS) begin
                ccif.iload[core] = ccif.ramload;
                ccif.iwait[core] = 0;
            end
        end
    endcase
end

endmodule
