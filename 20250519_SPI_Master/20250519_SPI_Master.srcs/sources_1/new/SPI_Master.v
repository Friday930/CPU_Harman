`timescale 1ns / 1ps

module SPI_Master (
    // global signals
    input  wire       clk,
    input  wire       reset,
    // internal signals
    input  wire       cpol, // 0 : 유지, 1 : 반전
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

    localparam IDLE = 0, CP_DELAY = 1, CP0 = 2, CP1 = 3;

    wire r_sclk;
    reg [1:0] state, next;
    reg [7:0] temp_tx_data_next, temp_tx_data_reg;
    reg [7:0] temp_rx_data_next, temp_rx_data_reg;
    reg [$clog2(49)-1:0] sclk_counter_next, sclk_counter_reg;
    reg [$clog2(7)-1:0] bit_counter_next, bit_counter_reg;


    assign MOSI    = temp_tx_data_reg[7];
    assign rx_data = temp_rx_data_reg;
    
    assign r_sclk = ((next == CP1) && ~cpha) || ((next == CP0) && cpha); // cpol이 0일 때 r_sclk가 HIGH가 출력되는 조건
    assign SCLK = cpol ? ~r_sclk : r_sclk; // 반전
    // 상태에 따라 clk 발생함


    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state            <= IDLE;
            temp_tx_data_reg <= 0;
            sclk_counter_reg <= 0;
            bit_counter_reg  <= 0;
            temp_rx_data_reg <= temp_rx_data_next;
        end else begin
            state            <= next;
            temp_tx_data_reg <= temp_tx_data_next;
            sclk_counter_reg <= sclk_counter_next;
            bit_counter_reg  <= bit_counter_next;
            temp_rx_data_reg <= temp_rx_data_next;
        end
    end

    always @(*) begin
        next              = state;
        ready             = 0;
        done              = 0;
        // r_sclk            = 0;
        sclk_counter_next = sclk_counter_reg;
        bit_counter_next  = bit_counter_reg;
        temp_rx_data_next = temp_rx_data_reg;
        temp_tx_data_next = temp_tx_data_reg;
        case (state)
            IDLE: begin
                temp_tx_data_next = 0;
                done              = 0;
                ready             = 1;
                if (start) begin
                    next              = cpha ? CP_DELAY : CP0;
                    temp_tx_data_next = tx_data;
                    ready             = 0;
                    sclk_counter_next = 0;
                    bit_counter_next  = 0;
                end
            end
            CP_DELAY: begin // 반 주기 delay
                if (sclk_counter_reg == 49) begin
                    sclk_counter_next = 0;
                    next              = CP0;
                end else begin
                    sclk_counter_next = sclk_counter_reg + 1;
                end
            end
            CP0: begin
                // r_sclk = 0;
                if (sclk_counter_reg == 49) begin
                    temp_rx_data_next = {temp_tx_data_reg[6:0], MISO};
                    sclk_counter_next = 0;
                    next              = CP1;
                end else begin
                    sclk_counter_next = sclk_counter_reg + 1;
                    next              = CP0;
                end
            end
            CP1: begin
                // r_sclk = 1;
                if (sclk_counter_reg == 49) begin
                    if (bit_counter_reg == 7) begin
                        done = 1;
                        next = IDLE;
                    end else begin
                        temp_tx_data_next = {temp_tx_data_reg[6:0], 1'b0};
                        sclk_counter_next = 0;
                        bit_counter_next  = bit_counter_reg + 1;
                        next              = CP0;
                    end
                end else begin
                    sclk_counter_next = sclk_counter_reg + 1;
                end
            end
        endcase
    end

endmodule
