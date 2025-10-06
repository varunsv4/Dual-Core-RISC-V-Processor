`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;
`include "datapath_cache_if.vh"
`include "caches_if.vh"

module dcache (
    input logic CLK, nRST,
    datapath_cache_if.dcache dcif,
    /*
    modport dcache (
    input   halt, dmemREN, dmemWEN,
            datomic, dmemstore, dmemaddr,
    output  dhit, dmemload, flushed
  );
    */
    caches_if.dcache cif
    /*
    modport dcache (
    input   dwait, dload,
            ccwait, ccinv, ccsnoopaddr,
    output  dREN, dWEN, daddr, dstore,
            ccwrite, cctrans
    );
    */
);

    logic [31:0] hitcount, n_hitcount, misscount, n_misscount;
    logic [4:0] flushcount, n_flushcount;
    logic ccway, n_ccway;
    dcache_frame [7:0] way0, n_way0;
    dcache_frame [7:0] way1, n_way1;
    dcachef_t addr, snoopaddr;
    logic [DTAG_W-1:0]  tag;
    logic [DIDX_W-1:0]  idx;
    logic [DBLK_W-1:0]  blkoff;
    logic [DBYT_W-1:0]  bytoff;

    logic sel0, sel1, hit, dirty, seldirty, dirtyflush, n_ccwrite;
    logic [63:0] selblock;
    logic [31:0] data;
    logic [7:0] rused, n_rused;
    logic n_dREN, n_dWEN, n_resvalid, resvalid, sc_valid;
    word_t n_daddr, n_dstore, n_resset, resset;

    logic ccway0, ccway1;

    typedef enum logic [3:0] { 
        IDLE, WRITE1, WRITE2, ACCESS1, 
        ACCESS2, ITERATE, WRITE3, WRITE4, WRITEHITS, FLUSHED,
        SNOOP, WRITE5, WRITE6
    } state_t;

    state_t state, n_state;

    assign addr = dcachef_t'(dcif.dmemaddr);
    assign tag = addr.tag;
    assign idx = addr.idx;
    assign blkoff = addr.blkoff;
    assign bytoff = addr.bytoff;
    assign sel0 = (way0[idx].tag == tag) && way0[idx].valid; //&& (~dcif.dmemWEN || dirty);
    assign sel1 = (way1[idx].tag == tag) && way1[idx].valid; //&& (~dcif.dmemWEN || dirty);
    assign hit = dcif.dmemWEN && (sc_valid || !dcif.datomic) ? (sel0 || sel1) && seldirty : (sel0 || sel1);

    assign snoopaddr = dcachef_t'(cif.ccsnoopaddr);
    assign ccway0 = (way0[snoopaddr.idx].valid && way0[snoopaddr.idx].dirty && (way0[snoopaddr.idx].tag == snoopaddr.tag));
    assign ccway1 = (way1[snoopaddr.idx].valid && way1[snoopaddr.idx].dirty && (way1[snoopaddr.idx].tag == snoopaddr.tag));
    assign cif.cctrans = dcif.flushed ? 1'b0 : (ccway0 || ccway1);
    assign n_ccwrite = dcif.dmemWEN;

    assign sc_valid = dcif.datomic && resvalid && (dcif.dmemaddr == resset) && dcif.dmemWEN;

    always_comb begin 
        selblock = '0;
        seldirty = 0;
        if (sel0) begin
            selblock = way0[idx].data;
            seldirty = way0[idx].dirty;
        end
        if (sel1) begin
            selblock = way1[idx].data;
            seldirty = way1[idx].dirty;
        end
    end
    assign data = blkoff ? selblock[63:32] : selblock[31:0];    
    assign dirty = rused[idx] ? way0[idx].dirty : way1[idx].dirty;

    always_ff @(posedge CLK, negedge nRST) begin
        if (nRST == 1'b0) begin
            state <= IDLE;
            way0 <= '0;
            way1 <= '0;
            cif.dWEN <= '0;
            cif.dREN <= '0;
            cif.daddr <= '0;
            cif.dstore <= '0;
            rused <= '0;
            resset <= '0;
            resvalid <= '0;
            cif.ccwrite <= '0;
            ccway <= '0;
        end
        else begin
            state <= n_state;
            way0 <= n_way0;
            way1 <= n_way1;
            cif.dWEN <= n_dWEN;
            cif.dREN <= n_dREN;
            cif.daddr <= n_daddr;
            cif.dstore <= n_dstore;
            rused <= n_rused;
            resset <= n_resset;
            resvalid <= n_resvalid;
            cif.ccwrite <= n_ccwrite;
            ccway <= n_ccway;
        end
    end

    always_comb begin
        n_state = state;
        n_dWEN = cif.dWEN;
        n_dstore = cif.dstore;
        n_daddr = cif.daddr;
        n_dREN = cif.dREN;
        n_misscount = misscount;
        n_ccway = ccway;
        case (state) 
        IDLE: begin
            if (cif.ccwait) begin
                n_state = SNOOP;
                n_dREN = 1'b0;
                n_dWEN = 1'b0;
            end
            else if (~(dcif.dmemREN || dcif.dmemWEN)) begin
                n_state = IDLE;
                if (dcif.halt) begin
                    n_state = WRITE3;
                end
            end
            else if (~hit && dirty) begin
                if (dcif.dmemREN || sc_valid || ~dcif.datomic) begin
                    n_state = WRITE1;
                    n_dWEN = 1'b1;
                    n_daddr = rused[idx] ? word_t'({way0[idx].tag, idx, 3'b000}) : word_t'({way1[idx].tag, idx, 3'b000});
                    n_dstore = rused[idx] ? word_t'(way0[idx].data[0]) : word_t'(way1[idx].data[0]);
                end
            end
            else if (~hit && ~dirty) begin
                if (dcif.dmemREN || sc_valid || ~dcif.datomic) begin
                    n_state = ACCESS1;
                    n_dREN = 1'b1;
                    n_daddr = word_t'({dcif.dmemaddr[31:3], 3'b000});
                end
            end
            else if (dcif.dmemWEN) begin
                n_daddr = dcif.dmemaddr;
            end
        end
        WRITE1: begin
            if (~cif.dwait) begin
                n_state = WRITE2;
                n_dWEN = 1'b1;
                n_daddr = rused[idx] ? word_t'({way0[idx].tag, idx, 3'b100}) : word_t'({way1[idx].tag, idx, 3'b100});
                n_dstore = rused[idx] ? word_t'(way0[idx].data[1]) : word_t'(way1[idx].data[1]);
            end
        end
        WRITE2: begin
            if (~cif.dwait) begin
                n_state = ACCESS1;
                n_dWEN = 1'b0;
                n_dREN = 1'b1;
                n_daddr = word_t'({dcif.dmemaddr[31:3], 3'b000});
            end
        end
        ACCESS1: begin
            if (cif.ccwait) begin
                n_state = SNOOP;
                n_dREN = 1'b0;
                n_dWEN = 1'b0;
            end
            else if (~cif.dwait) begin
                n_state = ACCESS2;
                n_dREN = 1'b1;
                n_daddr = word_t'({dcif.dmemaddr[31:3], 3'b100});
            end
        end
        ACCESS2: begin
            if (~cif.dwait) begin
                n_state = IDLE;
                n_dREN = 1'b0;
                n_misscount = misscount + 1;
            end
        end
        WRITE3: begin
            if (cif.ccwait) begin
                n_state = SNOOP;
                n_dREN = 1'b0;
                n_dWEN = 1'b0;
            end
            else if (flushcount == 5'h10) begin
                n_state = FLUSHED;
            end
            else if (dirtyflush) begin
                n_dWEN = 1'b1;
                n_daddr = flushcount[3] ? word_t'({way1[flushcount[2:0]].tag, flushcount[2:0], 3'b000}) : word_t'({way0[flushcount[2:0]].tag, flushcount[2:0], 3'b000});
                n_dstore = flushcount[3] ? word_t'(way1[flushcount[2:0]].data[0]) : word_t'(way0[flushcount[2:0]].data[0]);
                if (~cif.dwait) begin
                    n_state = WRITE4;
                    n_dWEN = 1'b1;
                    n_daddr = flushcount[3] ? word_t'({way1[flushcount[2:0]].tag, flushcount[2:0], 3'b100}) : word_t'({way0[flushcount[2:0]].tag, flushcount[2:0], 3'b100});
                    n_dstore = flushcount[3] ? word_t'(way1[flushcount[2:0]].data[1]) : word_t'(way0[flushcount[2:0]].data[1]);
                end
            end
        end
        WRITE4: begin
            if (~cif.dwait) begin
                n_state = WRITE3;
                n_dWEN = 1'b0;
            end
        end
        SNOOP: begin
            if (cif.cctrans) begin
                n_state = WRITE5;
                n_dstore = ccway0 ? word_t'(way0[snoopaddr.idx].data[0]) : word_t'(way1[snoopaddr.idx].data[0]);
                n_ccway = ccway0;
            end
            else begin
                n_state = IDLE;
            end
        end
        WRITE5: begin
            if (~cif.dwait) begin
                n_state = WRITE6;
                n_dstore = ccway ? word_t'(way0[snoopaddr.idx].data[1]) : word_t'(way1[snoopaddr.idx].data[1]);
            end
        end
        WRITE6: begin
            if (~cif.dwait) begin
                n_state = IDLE;
            end
        end
        endcase
    end

    always_comb begin
        dcif.dmemload = '0;
        dcif.dhit = 1'b0;
        n_rused = rused;
        n_way0 = way0;
        n_way1 = way1;
        dcif.flushed = 1'b0;
        n_resset = resset;
        n_resvalid = resvalid;
        case (state)
        IDLE: begin
            if (!cif.ccwait) begin
                if (dcif.dmemREN || dcif.dmemWEN) begin
                    if (hit) begin
                        dcif.dmemload = data;
                        dcif.dhit = 1'b1;
                        n_rused[idx] = sel1;
                        if (dcif.dmemWEN) begin
                            if (dcif.datomic)
                                dcif.dmemload = sc_valid ? 32'b0 : 32'b1;
                            if (sc_valid || ~dcif.datomic) begin
                                if (sel1) begin
                                    n_way1[idx].valid = 1'b1;
                                    n_way1[idx].dirty = 1'b1;
                                    n_way1[idx].tag = tag;
                                    n_way1[idx].data[blkoff] = dcif.dmemstore;
                                end
                                else begin
                                    n_way0[idx].valid = 1'b1;
                                    n_way0[idx].dirty = 1'b1;
                                    n_way0[idx].tag = tag;
                                    n_way0[idx].data[blkoff] = dcif.dmemstore;
                                end
                            end
                        end
                    end
                    else begin
                        if (dcif.dmemWEN && (sel0 || sel1)) n_rused[idx] = sel0;
                        if (~sc_valid && dcif.datomic && dcif.dmemWEN) begin
                            dcif.dmemload = 32'b1;
                            dcif.dhit = 1'b1;
                        end
                    end
                end
                if (dcif.datomic && dcif.dmemREN ) begin
                    n_resset = dcif.dmemaddr;
                    n_resvalid = 1;
                end
            end
        end
        WRITE2: begin
            if (rused[idx]) begin
                n_way0[idx].dirty = 1'b0;
            end
            else begin
                n_way1[idx].dirty = 1'b0;
            end
        end
        ACCESS1: begin
            if (!cif.dwait) begin
                if (rused[idx]) begin
                    n_way0[idx].valid = 1'b1;
                    n_way0[idx].tag = tag;
                    n_way0[idx].data[0] = cif.dload;
                    n_way0[idx].dirty = cif.ccwrite;
                end
                else begin
                    n_way1[idx].valid = 1'b1;
                    n_way1[idx].tag = tag;
                    n_way1[idx].data[0] = cif.dload;
                    n_way1[idx].dirty = cif.ccwrite;
                end
            end
        end
        ACCESS2: begin
            if (rused[idx]) begin
                n_way0[idx].data[1] = cif.dload;
            end
            else begin
                n_way1[idx].data[1] = cif.dload;
            end
        end
        WRITE3: begin
            if (~cif.dwait) begin
                if (flushcount[3]) begin
                    n_way1[flushcount[2:0]].dirty = 1'b0;
                end
                else begin
                    n_way0[flushcount[2:0]].dirty = 1'b0;
                end
            end
        end
        FLUSHED: begin
            dcif.flushed = 1'b1;
        end
        SNOOP: begin
            //if(!cif.cctrans) begin
            if((way0[snoopaddr.idx].tag == snoopaddr.tag) && (way0[snoopaddr.idx].valid == 1)) begin
                n_way0[snoopaddr.idx].valid = !cif.ccinv;
                n_way0[snoopaddr.idx].dirty = 1'b0;
            end
            else if((way1[snoopaddr.idx].tag == snoopaddr.tag) && (way1[snoopaddr.idx].valid == 1)) begin
                n_way1[snoopaddr.idx].valid = !cif.ccinv;
                n_way1[snoopaddr.idx].dirty = 1'b0;
            end
            //end
        end
        WRITE6: begin
            if(!cif.dwait) begin
                if (ccway0) begin
                    // n_way0[snoopaddr.idx].valid = !cif.ccinv;
                    // n_way0[snoopaddr.idx].dirty = 0;
                end
                else if (ccway1) begin
                    // n_way1[snoopaddr.idx].valid = !cif.ccinv;
                    // n_way1[snoopaddr.idx].dirty = 0;
                end
            end
        end
        endcase
        if (cif.ccinv && (n_state != SNOOP)) begin
            if((way0[snoopaddr.idx].tag == snoopaddr.tag) && (way0[snoopaddr.idx].valid == 1)) begin
                n_way0[snoopaddr.idx].valid = !cif.ccinv;
                n_way0[snoopaddr.idx].dirty = 1'b0;
            end
            else if((way1[snoopaddr.idx].tag == snoopaddr.tag) && (way1[snoopaddr.idx].valid == 1)) begin
                n_way1[snoopaddr.idx].valid = !cif.ccinv;
                n_way1[snoopaddr.idx].dirty = 1'b0;
            end
            if (resset == cif.ccsnoopaddr) begin
                n_resvalid = 1'b0;
            end
        end
    end

    always_ff @(posedge CLK, negedge nRST) begin
        if (nRST == 1'b0) begin
            hitcount <= '0;
            misscount <= '0;
            flushcount <= '0;
        end
        else begin
            hitcount <= n_hitcount;
            misscount <= n_misscount;
            flushcount <= n_flushcount;
        end
    end

    always_comb begin
        n_hitcount = hitcount;
        if (dcif.dhit) begin
            n_hitcount = hitcount + 1;
        end
    end

    always_comb begin
        n_flushcount = flushcount;
        dirtyflush = 1'b0;
        if (flushcount[3]) begin
            if (way1[flushcount[2:0]].dirty) begin
                dirtyflush = 1'b1;
            end
            else begin
                if (state == WRITE3) begin
                    n_flushcount = flushcount + 1;
                end
            end
        end
        else begin
            if (way0[flushcount[2:0]].dirty) begin
                dirtyflush = 1'b1;
            end
            else begin
                if ((state == WRITE3)) begin
                    n_flushcount = flushcount + 1;
                end
            end
        end
        if ((state == WRITE4) && (n_state == WRITE3)) begin
            n_flushcount = flushcount + 1;
        end
    end


endmodule