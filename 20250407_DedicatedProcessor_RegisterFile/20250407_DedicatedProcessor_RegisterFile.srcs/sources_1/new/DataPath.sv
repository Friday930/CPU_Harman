`timescale 1ns / 1ps

module DataPath(
    input   logic                       clk,
    input   logic                       rst,
    input   logic                       RFSrcMuxSel,
    input   logic   [2:0]                    readAddr1,
    input   logic   [2:0]                    readAddr2,
    input   logic   [2:0]                   writeAddr,
    input   logic                       writeEn,
    input   logic                       outbuf,
    output  logic                       iLe10,
    output  logic   [7:0]    out
    );
    
    logic   [7:0]            wD, rD1, rD2, sum;

    mux_2x1 U_Mux_RFSrcMuxSel(
        .sel                            (RFSrcMuxSel),
        .x1                             (1),
        .x2                             (sum),
        .y                              (wD)
    );

    RegFile U_RegFile(
        .clk                            (clk),
        .readAddr1                      (readAddr1),
        .readAddr2                      (readAddr2),
        .writeAddr                      (writeAddr),
        .writeEn                        (writeEn),
        .wData                          (wD),
        .rData1                         (rD1),
        .rData2                         (rD2)
    );

    comparator U_Comp(
        .in1                            (rD1),
        .iLe10                          (iLe10)
    );

    adder U_Accumulator(
        .a                              (rD1),
        .b                              (rD2),
        .sum                            (sum)
    );

    register U_Out_Reg(
        .clk                            (clk),
        .rst                            (rst),
        .en                             (outbuf),
        .d                              (rD1),
        .q                              (out)
    );


endmodule


module mux_2x1 (
    input   logic                  sel,
    input   logic   [7:0]    x1,
    input   logic   [7:0]    x2,
    output  logic   [7:0]    y
);

    always_comb begin : mux
        case (sel)
            1'b0: y = x1;
            1'b1: y = x2;
            default: y = 0;
        endcase
    end
    
endmodule

module RegFile (
    input   logic           clk,
    input   logic   [2:0]   readAddr1,
    input   logic   [2:0]   readAddr2,
    input   logic   [2:0]   writeAddr,
    input   logic           writeEn,
    input   logic   [7:0]   wData,
    output  logic   [7:0]   rData1,
    output  logic   [7:0]   rData2
);

    logic   [7:0]           mem[0:7];

    always_ff @( posedge clk ) begin : write
        if (writeEn) begin
            mem[writeAddr] <= wData;
        end
    end

    assign                  rData1 = (readAddr1 == 3'b0) ? 8'b0 : mem[readAddr1];
    assign                  rData2 = (readAddr2 == 3'b0) ? 8'b0 : mem[readAddr2];
    
endmodule

module comparator (
    input   logic   [7:0] in1,
    output  logic   iLe10
);

    assign          iLe10 = (in1 <= 8'd10);
    
endmodule

module adder (
    input   logic   [7:0]   a,
    input   logic   [7:0]   b,
    output  logic   [7:0]   sum
);
    assign                  sum = a + b;
    
endmodule

module register (
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   en,
    input   logic   [7:0]     d,
    output  logic   [7:0]     q
);

    always_ff @( posedge clk, posedge rst ) begin : output_register
        if (rst) begin
            q <= 0;
        end else if (en) begin
            q <= d;
        end
    end
    
endmodule