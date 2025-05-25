`timescale 1ns / 1ps

module SPI_top (
    input wire clk,
    input wire reset,
    // internal signals
    input  wire       cpol,
    input  wire       cpha,
    input  wire       start,
    input  wire [7:0] tx_data,
    output wire [7:0] rx_data,
    output reg        done,
    output reg        ready,
    input  wire       SS
);

    wire SCLK, MISO, MOSI;
    // assign MISO = MOSI;

    SPI_Master U_SPI_Master(
        // global signals
        .clk(clk),
        .reset(reset),
        // internal signals
        .cpol(cpol),
        .cpha(cpha),
        .start(start),
        .tx_data(tx_data),
        .rx_data(rx_data),
        .done(done),
        .ready(ready),
        // external port
        .SCLK(SCLK),
        .MOSI(MOSI),
        .MISO(MISO)
    );

    SPI_Slave U_SPI_Slave(
        .clk(clk),
        .reset(reset),
        .SCLK(SCLK),
        .MOSI(MOSI),
        .MISO(MISO),
        .SS(SS)
    );
    
endmodule