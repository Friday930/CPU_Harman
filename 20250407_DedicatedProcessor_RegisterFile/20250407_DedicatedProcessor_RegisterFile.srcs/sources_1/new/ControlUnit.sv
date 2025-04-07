`timescale 1ns / 1ps

module ControlUnit(
    input           clk,
    input           rst,
    output  logic   RFSrcMuxSel,
    output  logic   [2:0] readAddr1,
    output  logic   [2:0] readAddr2,
    output  logic   [2:0] writeAddr,
    output  logic   writeEn,
    output  logic   outbuf,
    input   logic   iLe10
    );

    typedef enum  { INIT_R1, INIT_R2, INIT_R3, CHECK_CONDITION, ADD_TO_SUM, INCREMENT_COUNTER, OUTPUT, HALT } state_e;
    state_e state, next;

    always_ff @( posedge clk, posedge rst ) begin
        if (rst) begin
            state <= INIT_R1;
        end else state <= next;
    end

    always_comb begin
        next = state;
        RFSrcMuxSel = 0;
        readAddr1 = 0;
        readAddr2 = 0;
        writeAddr = 0;
        writeEn = 0;
        outbuf = 0;
        
        case (state)
            INIT_R1: begin
                // Initialize R1 = 0
                RFSrcMuxSel = 1;     // Select adder result
                readAddr1 = 0;       // Read 0
                readAddr2 = 0;       // Read 0
                writeAddr = 1;       // Write to R1
                writeEn = 1;
                next = INIT_R2;
            end

            INIT_R2: begin
                // Initialize R2 = 0
                RFSrcMuxSel = 1;     // Select adder result
                readAddr1 = 0;       // Read 0
                readAddr2 = 0;       // Read 0
                writeAddr = 2;       // Write to R2
                writeEn = 1;
                next = INIT_R3;
            end
            
            INIT_R3: begin
                // Initialize R3 = 1 (constant for increment)
                RFSrcMuxSel = 0;  // Select constant 1 from mux
                writeAddr = 3;    // Write to R3
                writeEn = 1;
                next = CHECK_CONDITION;
            end
            
            CHECK_CONDITION: begin
                // Check if R1 <= 10
                readAddr1 = 1;    // Read from R1 for comparison
                
                if (iLe10) begin
                    next = ADD_TO_SUM;
                end else begin
                    next = OUTPUT;
                end
            end
            
            ADD_TO_SUM: begin
                // R2 = R2 + R1
                RFSrcMuxSel = 1;  // Select adder result
                readAddr1 = 1;    // Read from R1 (counter)
                readAddr2 = 2;    // Read from R2 (current sum)
                writeAddr = 2;    // Write to R2
                writeEn = 1;
                next = INCREMENT_COUNTER;
            end
            
            INCREMENT_COUNTER: begin
                // R1 = R1 + 1 (actually R1 + R3)
                RFSrcMuxSel = 1;  // Select adder result
                readAddr1 = 1;    // Read from R1 (counter)
                readAddr2 = 3;    // Read from R3 (constant 1)
                writeAddr = 1;    // Write to R1
                writeEn = 1;
                next = CHECK_CONDITION;
            end
            
            OUTPUT: begin
                // Output the final sum (R2)
                readAddr1 = 2;    // Read from R2 for output
                outbuf = 1;       // Enable output buffer
                next = HALT;
            end
            
            HALT: begin
                // Halt state - keep all outputs inactive
                next = HALT;
            end
        endcase
    end
endmodule