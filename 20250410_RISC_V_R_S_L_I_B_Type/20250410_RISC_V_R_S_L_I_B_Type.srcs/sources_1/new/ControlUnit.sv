`timescale 1ns / 1ps

`include "defines.sv"

module ControlUnit (
    input  logic [31:0] instrCode,
    output logic        regFileWe,
    output logic [ 3:0] aluControl,
    output logic [ 2:0] compControl,
    output logic        aluSrcMuxSel,
    output logic        PCSrcMuxSel,
    output logic        dataWe,
    output logic        RFWDSrcMuxSel
);
    wire [6:0] opcode = instrCode[6:0];
    wire [3:0] operators = {
        instrCode[30], instrCode[14:12]
    };  // {func7[5], func3}
    // wire [2:0] func3 = instrCode[14:12];

    logic [4:0] signals;
    assign {regFileWe, aluSrcMuxSel, dataWe, RFWDSrcMuxSel, PCSrcMuxSel} = signals;

    always_comb begin
        signals = 3'b0;
        case (opcode)
            // {regFileWe, aluSrcMuxSel, dataWe, RFWDSrcMuxSel, PCSrcMuxSel} = signals
            `OP_TYPE_R: signals = 5'b1_0_0_0_0;
            `OP_TYPE_S: signals = 5'b0_1_1_0_0;
            `OP_TYPE_L: signals = 5'b1_1_0_1_0;
            `OP_TYPE_I: signals = 5'b1_1_0_0_0;
            `OP_TYPE_B: signals = 5'b1_1_0_0_1;
        endcase
    end

    always_comb begin
        aluControl = 4'bx;
        compControl = 3'b0;
        case (opcode)
            `OP_TYPE_R: aluControl = operators;  // {func7[5], func3}
            `OP_TYPE_S: aluControl = `ADD;
            `OP_TYPE_L: aluControl = `ADD;
            `OP_TYPE_I: begin
                if (operators == 4'b1101) begin
                    aluControl = operators;
                end else aluControl = {1'b0, operators[2:0]};  // {1'b0, func3}
            end
            `OP_TYPE_B: compControl = operators[2:0];
        endcase
    end
endmodule
