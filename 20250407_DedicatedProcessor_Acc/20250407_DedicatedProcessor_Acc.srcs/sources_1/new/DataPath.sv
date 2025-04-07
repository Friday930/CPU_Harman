`timescale 1ns / 1ps

module DataPath(
    input   logic           clk,
    input   logic           reset,
    input   logic           sumSrcMuxSel,
    input   logic           iSrcMuxSel,
    input   logic           SumEn,
    input   logic           iEn,
    input   logic           adderSrcMuxSel,
    input   logic           outbuf,
    output  logic           iLe10,
    output  logic   [7:0]   outport
    );

    logic   [7:0]           adderResult, sumSrcMuxData, iSrcMuxData, sumRegData, iRegData;

    mux_2x1 U_SumSrcMux(
        .sel                (sumSrcMuxSel),
        .x0                 (8'b0),
        .x1                 (adderResult),
        .y                  (sumSrcMuxData)
    );

    mux_2x1 U_iSrcMux(
        .sel                (iSrcMuxSel),
        .x0                 (8'b0),
        .x1                 (adderResult),
        .y                  (iSrcMuxData)
    );

    register U_SumReg(
        .clk                (clk),
        .reset              (reset),
        .en                 (iEn),
        .d                  (sumSrcMuxData),
        .q                  (sumRegData)
    );

    register U_iReg(
        .clk                (clk),
        .reset              (reset),
        .en                 (iEn),
        .d                  (iSrcMuxData),
        .q                  (iRegData)
    );

    mux_2x1 U_adderSrcMux(
        .sel                (adderSrcMuxSel),
        .x0                 (sumRegData),
        .x1                 (8'b1),
        .y                  (iSrcMuxData)
    );
endmodule

module mux_2x1 (
    input   logic           sel,
    input           [7:0]   x0,
    input           [7:0]   x1,
    output  logic   [7:0]    y
);
    always_comb begin : mux
        y = 8'b0;
        case (sel)
            1'b0: y = x0; 
            1'b1: y = x1; 
        endcase
    end
endmodule

module register (
    input   logic           clk,
    input   logic           reset,
    input   logic           en,
    input   logic   [7:0]   d,
    output  logic   [7:0]   q
);

    always_ff @( posedge clk, posedge reset ) begin : register
        if (reset) begin
            q <= 0;
        end else if (en) begin
            q <= d;
        end
    end
endmodule

module comparator (
    input   logic   [7:0]   a,
    input   logic   [7:0]   b,
    output  logic           le
);  
    assign                  le = (a <= b);
endmodule

module adder (
    input   logic   [7:0]   a,
    input   logic   [7:0]   b,
    output  logic   [7:0]   sum
);  
    assign                  sum = a + b;
endmodule