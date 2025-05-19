`timescale 1ns / 1ps

module SPI_FND (
    input wire sys_clk,
    input wire rst,
    input wire btn,
    input wire [15:0] number,
    output wire [7:0] fnd_font,
    output wire [3:0] fnd_comm
);

    wire start, done, SCLK, MOSI, MISO, CS;
    wire [7:0] tx_data;

    SPI_Input_Master U_SPI_Input_Master (
        .sys_clk(sys_clk),
        .rst    (rst),
        .btn    (btn),
        .number (number),
        .start  (start),
        .done   (done),
        .data   (tx_data)
    );

    SPI_Master U_SPI_Master (
        .sys_clk(sys_clk),
        .rst    (rst),
        .start  (start),
        .tx_data(tx_data),
        .rx_data(rx_data),
        .MOSI   (MOSI),
        .MISO   (MISO),
        .done   (done),
        .ready  (ready),
        .SCLK   (SCLK),
        .CS     (CS)
    );

    SPI_Slave_IP U_SPI_Slave_IP (
        .sys_clk (sys_clk),
        .rst     (rst),
        .SCLK    (SCLK),
        .MOSI    (MOSI),
        .CS      (CS),
        .MISO    (MISO),
        .fnd_font(fnd_font),
        .fnd_comm(fnd_comm)
    );

endmodule
