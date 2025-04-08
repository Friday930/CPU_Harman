`timescale 1ns / 1ps

module RV32I_Core (
    input  logic        clk,
    input  logic        reset,
    input  logic [31:0] instrCode,
    output logic [31:0] instrMemAddr
);

    logic               regFileWe;
    logic   [3:0]       aluControl;

    ControlUnit u_ControlUnit (
        .instrCode (instrCode),
        .regFileWe (regFileWe),
        .aluControl(aluControl)
    );

    DataPath u_DataPath (
        .clk         (clk),
        .reset       (reset),
        .instrCode   (instrCode),
        .instrMemAddr(instrMemAddr),
        .regFileWe   (regFileWe),
        .aluControl  (aluControl)
    );


endmodule
