`timescale 1ns / 1ps

module top_DedicatedProcessor(
    input   logic           clk,
    input   logic           reset,
    output  logic   [7:0]   outPort
    );

    logic           sumSrcMuxSel;
    logic           iSrcMuxSel;
    logic           SumEn;
    logic           iEn;
    logic           adderSrcMuxSel;
    logic           outbuf;
    logic           iLe10;

    DataPath U_DataPath(.*);

    ControlUnit U_ControlUnit(.*);
endmodule
