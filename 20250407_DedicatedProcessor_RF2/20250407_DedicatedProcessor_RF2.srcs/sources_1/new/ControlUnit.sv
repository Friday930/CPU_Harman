`timescale 1ns / 1ps

module ControlUnit (
    input  logic       clk,
    input  logic       reset,
    output logic       RFSrcMuxSel,
    output logic [2:0] readAddr1,
    output logic [2:0] readAddr2,
    output logic [2:0] writeAddr,
    output logic [2:0] ALUop,
    output logic       writeEn,
    output logic       outBuf,
    input  logic       iLe10
);
    typedef enum {
        S0,
        S1,
        S2,
        S3,
        S4,
        S5,
        S6,
        S7,
        S8,
        S9,
        S10,
        S11
    } state_e;

    state_e state, state_next;
    logic [14:0] out_signals;

    assign {RFSrcMuxSel, readAddr1, readAddr2, writeAddr, ALUop, writeEn, outBuf} = out_signals;

    always_ff @(posedge clk, posedge reset) begin : state_reg
        if (reset) state <= S0;
        else state <= state_next;
    end

    always_comb begin : state_next_machine
        state_next  = state;
        out_signals = 0;
        case (state)
            //{RFSrcMuxSel, readAddr1, readAddr2, writeAddr, ALUop, writeEn, outBuf} = out_signals;
            S0: begin  // R1 = 1
                out_signals = 15'b1_001_000_001_110_1_1;  // machine code
                state_next  = S1;
            end
            S1: begin  // R2 = 0
                out_signals = 15'b0_000_000_010_111_1_1;
                state_next  = S2;
            end
            S2: begin  // R3 = 0;
                out_signals = 15'b0_000_000_011_111_1_1;
                state_next  = S3;
            end
            S3: begin  // R4 = R1 + R1
                out_signals = 15'b0_001_001_100_000_1_1;
                state_next  = S4;
            end
            S4: begin  // R5 = R4 + R4
                out_signals = 15'b0_100_100_101_000_1_1;
                state_next  = S5;
            end
            S5: begin  // R6 = R5 - R1
                out_signals = 15'b0_101_001_110_001_1_1;
                state_next  = S6;
            end
            // S6: begin // outport = R2
            //     out_signals = 12'b0_010_000_000_0_1;
            //     state_next     = S3;
            // end
            S6: begin  // R2 = R6 and R4
                out_signals = 15'b0_110_100_010_010_1_1;
                state_next  = S7;
            end
            S7: begin  // R3 = R2 or R5
                out_signals = 15'b0_010_101_011_011_1_1;
                state_next  = S8;
            end
            S8: begin  // R7 = R3 xor R2
                out_signals = 15'b0_011_010_111_100_1_1;
                state_next  = S9;
            end
            S9: begin  // R4 = not R7
                out_signals = 15'b0_111_000_100_101_1_1;
                state_next  = S10;
            end
            S10: begin  // 
                out_signals = 15'b0_111_100_000_000_0_0;
                if (iLe10) state_next = S4;
                else state_next = S11;
            end
            S11: begin  // HALT
                out_signals = 15'b0_000_000_000_000_0_0;
                state_next  = S11;
            end
        endcase
    end
endmodule
