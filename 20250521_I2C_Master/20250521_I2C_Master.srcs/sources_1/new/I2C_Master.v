`timescale 1ns / 1ps

module I2C_Master (
    input  wire       sys_clk,
    input  wire       reset,
    input  wire [7:0] tx_data,
    input  wire       start,
    // input wire i2c_en,
    input  wire       stop,
    output reg        tx_done,
    output reg        ready,
    inout             SCL,
    inout             SDA
);

    localparam IDLE = 0, START1 = 1, START2 = 2, DATA1 = 3, DATA2 = 4, DATA3 = 5, DATA4 = 6, ACK1 = 7, ACK2 = 8, HOLD = 9, STOP1 = 10, STOP2 = 11;

    reg [3:0] state, next;
    reg [7:0] temp_tx_data_reg, temp_tx_data_next;
    reg [$clog2(499)-1:0] clk_counter_reg, clk_counter_next;
    reg [$clog2(7)-1:0] bit_counter_reg, bit_counter_next;
    reg scl_reg, scl_next;
    reg sda_reg, sda_next;

    assign SCL = scl_reg;
    assign SDA = sda_reg;

    always @(posedge sys_clk, posedge reset) begin
        if (reset) begin
            state            <= IDLE;
            temp_tx_data_reg <= 0;
            clk_counter_reg  <= 0;
            scl_reg          <= 0;
            sda_reg          <= 0;
        end else begin
            state            <= next;
            temp_tx_data_reg <= temp_tx_data_next;
            clk_counter_reg  <= clk_counter_next;
            scl_reg          <= scl_next;
            sda_reg          <= scl_next;
        end
    end

    always @(*) begin
        next              = state;
        temp_tx_data_next = temp_tx_data_reg;
        clk_counter_next  = clk_counter_reg;
        scl_next          = scl_reg;
        sda_next          = sda_reg;
        case (state)
            IDLE: begin
                sda_next = 1;
                scl_next = 1;
                if (start) begin
                    temp_tx_data_next = tx_data;
                    next = START1;
                end else begin
                    next = IDLE;
                end
            end
            START1: begin
                sda_next = 0;
                scl_next = 1;
                if (clk_counter_reg == 499) begin
                    clk_counter_next = 0;
                    next = START2;
                end else begin
                    clk_counter_next = clk_counter_reg + 1;
                end
            end
            START2: begin
                sda_next = 0;
                scl_next = 0;
                if (clk_counter_reg == 499) begin
                    clk_counter_next = 0;
                    next = DATA1;
                end else begin
                    clk_counter_next = clk_counter_reg + 1;
                end
            end
            DATA1: begin
                sda_next = temp_tx_data_next[7];
                scl_next = 0;
                if (clk_counter_reg == 249) begin
                    clk_counter_next = 0;
                    next = DATA2;
                end else begin
                    clk_counter_next = clk_counter_reg + 1;
                end
            end
            DATA2: begin
                sda_next = temp_tx_data_next[7];
                scl_next = 1;
                if (clk_counter_reg == 249) begin
                    clk_counter_next = 0;
                    next = DATA3;
                end else begin
                    clk_counter_next = clk_counter_reg + 1;
                end
            end
            DATA3: begin
                sda_next = temp_tx_data_next[7];
                scl_next = 1;
                if (clk_counter_reg == 249) begin
                    clk_counter_next = 0;
                    next = DATA4;
                end else begin
                    clk_counter_next = clk_counter_reg + 1;
                end
            end
            DATA4: begin
                sda_next = temp_tx_data_next[7];
                scl_next = 0;
                if (clk_counter_reg == 249) begin
                    clk_counter_next = 0;
                    if (bit_counter_reg == 7) begin
                        next = ACK1;
                    end
                    begin
                        bit_counter_next  = bit_counter_reg + 1;
                        temp_tx_data_next = {temp_tx_data_reg[6:0], 1'b0};
                    end
                end
            end
            ACK1: begin
                sda_next = 0;
                scl_next = 1;
                if (clk_counter_reg == 499) begin
                    clk_counter_next = 0;
                    next = ACK2;
                end else begin
                    clk_counter_next = clk_counter_reg + 1;
                end
            end
            ACK2: begin
                sda_next = 0;
                scl_next = 0;
                if (clk_counter_reg == 499) begin
                    clk_counter_next = 0;
                    next = HOLD;
                end else begin
                    clk_counter_next = clk_counter_reg + 1;
                end
            end
            HOLD: begin
                sda_next = 0;
                scl_next = 0;
            end
        endcase
    end


endmodule
