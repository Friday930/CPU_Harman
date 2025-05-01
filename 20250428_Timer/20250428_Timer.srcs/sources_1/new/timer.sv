`timescale 1ns / 1ps

module timer #(
    parameter BIT_WIDTH = 32
) (
    input  logic                         clk,
    input  logic                         reset,
    input  logic                         en,
    input  logic                         clear,
    output logic [$clog2(BIT_WIDTH)-1:0] count
);

    logic tick;

    prescalar #(
        .FCOUNT(100_000)
    ) U_CLK_Div (
        .clk  (clk),
        .reset(reset),
        .en   (en),
        .clear(clear),
        .tick (tick)
    );

    counter #(
        .FREQ     (1000),
        .BIT_WIDTH(32)
    ) U_Counter (
        .clk  (clk),
        .reset(reset),
        .tick (tick),
        .clear(clear),
        .count(count)
    );



endmodule

module prescalar #(
    parameter FCOUNT = 100_000  // 1kHz
) (
    input  logic clk,
    input  logic reset,
    input  logic en,
    input  logic clear,
    output logic tick
);
    logic [$clog2(FCOUNT)-1:0] count_reg, count_next;
    logic tick_reg, tick_next;

    assign tick = tick_reg;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            count_reg <= 0;
            tick_reg  <= 0;
        end else begin
            count_reg <= count_next;
            tick_reg  <= tick_next;
        end
    end

    always_comb begin
        count_next = count_reg;
        tick_next  = 0;

        if (en) begin
            if (count_reg == FCOUNT - 1) begin
                count_next = 0;
                tick_next  = 1;
            end else begin
                count_next = count_reg + 1;
                tick_next  = 0;
            end
        end else begin
            count_next = 0;
            tick_next  = 0;
        end
    end
endmodule

module counter #(
    parameter FREQ = 1000,
    BIT_WIDTH = 32
) (
    input  logic                         clk,
    input  logic                         reset,
    input  logic                         tick,
    input  logic                         clear,
    output logic [$clog2(BIT_WIDTH)-1:0] count
);

    logic [$clog2(FREQ)-1:0] count_reg, count_next;
    assign count = count_reg;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            count_reg <= 0;
        end else begin
            count_reg <= count_next;
        end
    end

    always_comb begin
        count_next = count_reg;
        if (clear) begin
            count_next = 0;
        end else begin
            if (tick) begin
                if (count_reg == FREQ - 1) begin
                    count_next = 0;
                end else begin
                    count_next = count_reg + 1;
                end
            end
        end
    end

endmodule
