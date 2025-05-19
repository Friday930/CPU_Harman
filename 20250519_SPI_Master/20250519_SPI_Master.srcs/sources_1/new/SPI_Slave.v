`timescale 1ns / 1ps

module SPI_Slave ();
endmodule

module SPI_Slave_Intf (
    input  wire       clk,
    input  wire       reset,
    // external signals
    input  wire       SCLK,
    input  wire       MOSI,
    output wire       MISO,
    input  wire       SS,
    // internal signals
    output reg        done,
    output reg        write,
    output reg  [1:0] addr,
    output wire [7:0] wdata,
    input  wire [7:0] rdata
);

    // localparam IDLE = 0, CP0 = 1, CP1 = 2;
    localparam SO_IDLE = 0, SO_DATA = 1;

    reg [1:0] state, next;
    reg [7:0] temp_tx_data;
    reg [7:0] temp_rx_data;
    reg [$clog2(7)-1:0] bit_counter;

    assign wdata = temp_rx_data;
    assign MISO  = SS ? 1'bz : temp_tx_data[7];

    // MOSI sequence
    always @(posedge SCLK) begin
        if (SS == 1'b0) begin
            temp_rx_data <= {temp_rx_data[6:0], MOSI};
        end
    end

    // MISO sequence
    // always @(negedge SCLK) begin
    //     if (SS == 1'b0) begin
    //         temp_tx_data_reg <= {temp_tx_data_reg[6:0], 1'b0};
    //     end
    // end

    // always @(*) begin
    //     next = state;
    //     temp_tx_data_next = temp_tx_data_reg;
    //     case (state)
    //         SO_IDLE: begin
    //             if (!SS && rden) begin
    //                 if (rden) begin
    //                     temp_tx_data_next = rdata;
    //                     next = SO_DATA;
    //                 end
    //             end
    //         end
    //         SO_DATA: begin
    //             if (!SS && rden) begin
    //                 temp_tx_data_next = 
    //             end
    //         end
    //     endcase
    // end

    // MISO sequence
    always @(negedge SCLK) begin
        if (!SS) begin
            if (bit_counter == 7) begin
                temp_tx_data <= rdata;
                bit_counter <= 0;
                done <= 1;
            end else begin
                bit_counter <= bit_counter + 1;
                done <= 0;
            end
        end
    end


    // always @(posedge SCLK, posedge reset) begin
    //     if (reset) begin
    //         state <= IDLE;
    //         temp_tx_data_reg <= 0;
    //         temp_rx_data_reg <= 0;
    //     end else begin
    //         state <= next;
    //         temp_tx_data_reg <= temp_tx_data_next;
    //         temp_rx_data_reg <= temp_rx_data_next;
    //     end
    // end

    // always @(*) begin
    //     next = state;
    //     temp_tx_data_next = temp_tx_data_reg;
    //     temp_rx_data_next = temp_rx_data_reg;
    //     case (state)
    //         IDLE: begin
    //             if (!SS) begin
    //                 temp_tx_data_next = rdata;
    //                 next = CP0;
    //             end
    //         end
    //         CP0: begin
    //             if (SCLK == 1) begin
    //                 begin
    //                     temp_rx_data_next = {temp_rx_data_reg[6:0], MOSI};
    //                     next = CP1;
    //                 end
    //             end
    //         end
    //         CP1: begin
    //             if (SCLK == 1'b0) begin
    //                 if (bit_counter_reg == 7) begin
    //                     done = 1'b1;
    //                 end else begin
    //                     bit_counter_next = bit_counter_reg + 1;
    //                 end
    //             end
    //         end
    //     endcase
    // end

endmodule
