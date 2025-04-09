`timescale 1ns / 1ps

module ram (
    input  logic        clk,
    input  logic        we,
    input  logic [31:0] addr,
    input  logic [31:0] wData,
    output logic [31:0] rData
);

    logic [31:0] mem[0:9];  // test하므로 작게

    initial begin
        for (int i = 0; i < 10; i++) begin
            mem[i] = 10 + i;
        end
    end

    always_ff @(posedge clk) begin
        if (we) begin
            mem[addr[31:2]] <= wData;
        end
    end

    assign rData = mem[addr[31:2]];

endmodule
