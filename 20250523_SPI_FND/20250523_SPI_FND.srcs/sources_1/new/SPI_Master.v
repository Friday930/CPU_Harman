`timescale 1ns / 1ps

module SPI_Master (
    // global signals
    input  wire       clk,
    input  wire       reset,
    // internal signals
    input  wire       cpol,
    input  wire       cpha,
    input  wire       start,
    input  wire [7:0] tx_data,
    output wire [7:0] rx_data,
    output reg        done,
    output reg        ready,
    // external port
    output wire       SCLK,
    output wire       MOSI,
    input  wire       MISO
);
    localparam IDLE = 0, CP0 = 1, CP1 = 2, DELAY = 3;

    reg [1:0] state, next;
    reg [7:0] temp_tx_data, temp_tx_data_next;
    reg [7:0] temp_rx_data, temp_rx_data_next;
    reg [5:0] sclk_counter, sclk_counter_next;
    reg [2:0] bit_counter, bit_counter_next;
    wire w_sclk;

    assign MOSI    = temp_tx_data[7];
    assign rx_data = temp_rx_data;
    assign SCLK    = cpol ? ~w_sclk : w_sclk;

    // 다음상태와 SPHA에 따라 SCLK출력
    assign w_sclk = ((next == CP1) && ~cpha) || ((next == CP0) && cpha);

    always @(posedge clk, posedge reset) begin  // state logic
        if (reset) begin
            state        <= IDLE;
            temp_tx_data <= 0;
            temp_rx_data <= 0;
            sclk_counter <= 0;
            bit_counter  <= 0;
        end else begin
            state        <= next;
            temp_tx_data <= temp_tx_data_next;
            temp_rx_data <= temp_rx_data_next;
            sclk_counter <= sclk_counter_next;
            bit_counter  <= bit_counter_next;
        end
    end

    always @(*) begin  // next logic
        next              = state;
        temp_tx_data_next = temp_tx_data;
        temp_rx_data_next = temp_rx_data;
        sclk_counter_next = sclk_counter;
        bit_counter_next  = bit_counter;
        ready             = 0;
        done              = 0;
        case (state)
            IDLE: begin
                done              = 0;
                ready             = 1;
                if (start) begin
                    ready             = 0;
                    sclk_counter_next = 0;
                    bit_counter_next  = 0;
                    if (cpha) next = DELAY;
                    else begin
                        temp_tx_data_next = tx_data;
                        next              = CP0;
                    end
                end
            end
            DELAY: begin
                if (sclk_counter == 49) begin
                    temp_tx_data_next = tx_data;
                    sclk_counter_next = 0;
                    next              = CP0;
                end else sclk_counter_next = sclk_counter + 1;
            end
            CP0: begin
                if (sclk_counter == 49) begin
                    temp_rx_data_next = {temp_rx_data[6:0], MISO};
                    sclk_counter_next = 0;
                    next              = CP1;
                end else sclk_counter_next = sclk_counter + 1;
            end
            CP1: begin
                if (sclk_counter == 49) begin
                    sclk_counter_next = 0;
                    if (bit_counter == 7) begin
                        done             = 1;
                        bit_counter_next = 0;
                        next             = IDLE;
                    end else begin
                        temp_tx_data_next = {temp_tx_data[6:0], 1'b0};
                        bit_counter_next  = bit_counter + 1;
                        next              = CP0;
                    end
                end else sclk_counter_next = sclk_counter + 1;
            end
        endcase
    end
endmodule
