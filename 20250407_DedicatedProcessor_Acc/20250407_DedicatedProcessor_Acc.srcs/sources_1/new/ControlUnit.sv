`timescale 1ns / 1ps

module ControlUnit(
    input   logic           clk,
    input   logic           reset,
    output  logic           sumSrcMuxSel,
    output  logic           iSrcMuxSel,
    output  logic           SumEn,
    output  logic           iEn,
    output  logic           adderSrcMuxSel,
    output  logic           outbuf,
    input   logic           iLe10
    );

    // localparam              S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5;
    typedef enum            { S0, S1, S2, S3, S4, S5 } state_e;
    state_e                 state, next;
    // logic   [2:0]           state, next;
    
    always_ff @( posedge clk, posedge reset ) begin : state_reg
        if (reset) begin
            state <= S0;
        end else state <= next;
    end

    always_comb begin : state_next_machine
        next = state;
        sumSrcMuxSel = 0;
        iSrcMuxSel = 0;
        SumEn = 0;
        iEn = 0;
        adderSrcMuxSel = 0;
        outbuf = 0; 
        case (state)
            S0: begin
                sumSrcMuxSel = 0;
                iSrcMuxSel = 0;
                SumEn = 1;
                iEn = 1;
                adderSrcMuxSel = 1'bx;
                outbuf = 0;
                next = S1;
            end
            S1: begin
                sumSrcMuxSel = 1'bx;
                iSrcMuxSel = 1'bx;
                SumEn = 0;
                iEn = 0;
                adderSrcMuxSel = 1'bx;
                outbuf = 0;
                if (iLe10) begin
                    next = S2;
                end else next = S5;
            end
            S2: begin
                sumSrcMuxSel = 1;
                iSrcMuxSel = 1'bx;
                SumEn = 1;
                iEn = 0;
                adderSrcMuxSel = 0;
                outbuf = 0;
                next = S3;
            end
            S3: begin
                sumSrcMuxSel = 1'bx;
                iSrcMuxSel = 1;
                SumEn = 0;
                iEn = 1;
                adderSrcMuxSel = 1;
                outbuf = 0;
                next = S4;                
            end
            S4: begin
                sumSrcMuxSel = 1'bx;
                iSrcMuxSel = 1'bx;
                SumEn = 0;
                iEn = 0;
                adderSrcMuxSel = 1'bx;
                outbuf = 1;
                next = S1;                
            end
            S5: begin
                sumSrcMuxSel = 1'bx;
                iSrcMuxSel = 1'bx;
                SumEn = 0;
                iEn = 0;
                adderSrcMuxSel = 1'bx;
                outbuf = 0;
                next = S5;                
            end            
        endcase
    end
endmodule
