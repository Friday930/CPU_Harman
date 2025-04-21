`timescale 1ns / 1ps

module MCU (
    input logic clk,
    input logic reset,

    // output logic [7:0] GPOA,
    // input  logic [7:0] GPIB,
    inout  logic [7:0] GPIO
);
    // global signal
    logic        PCLK;
    logic        PRESET;
    // APB Interface Signals
    logic [31:0] PADDR;
    logic [31:0] PWDATA;
    logic        PWRITE;
    logic        PENABLE;
    logic        PSEL_RAM;
    // logic        PSEL_GPO;
    // logic        PSEL_GPI;
    logic        PSEL_GPIO;
    logic [31:0] PRDATA_RAM;
    // logic [31:0] PRDATA_GPO;
    // logic [31:0] PRDATA_GPI;
    logic [31:0] PRDATA_GPIO;
    logic        PREADY_RAM;
    // logic        PREADY_GPO;
    // logic        PREADY_GPI;
    logic        PREADY_GPIO;
    // Internal Interface Signals
    // CPU - APB_Master Signals
    logic        transfer;
    logic        ready;

    logic [31:0] addr;
    logic [31:0] wdata;
    logic [31:0] rdata;
    logic        write;

    logic        dataWe;
    logic [31:0] dataAddr;
    logic [31:0] dataWData;
    logic [31:0] dataRData;

    // ROM signals
    logic [31:0] instrCode;
    logic [31:0] instrMemAddr;

    assign PCLK   = clk;
    assign PRESET = reset;

    assign addr   = dataAddr;
    assign wdata  = dataWData;
    assign rdata  = dataRData;
    assign write  = dataWe;

    rom U_ROM (
        .addr(instrMemAddr),
        .data(instrCode)
    );

    RV32I_Core U_Core (.*);

    APB_Master U_APB_Master (
        .*,
        .PSEL0  (PSEL_RAM),
        .PSEL1  (PSEL_GPO),
        .PSEL2  (PSEL_GPI),
        .PSEL3  (PSEL_GPIO),
        .PRDATA0(PRDATA_RAM),
        .PRDATA1(PRDATA_GPO),
        .PRDATA2(PRDATA_GPI),
        .PRDATA3(PRDATA_GPIO),
        .PREADY0(PREADY_RAM),
        .PREADY1(PREADY_GPO),
        .PREADY2(PREADY_GPI),
        .PREADY3(PREADY_GPIO)
    );

    ram U_RAM (
        .*,
        .PSEL  (PSEL_RAM),
        .PRDATA(PRDATA_RAM),
        .PREADY(PREADY_RAM)
    );

    // GPO_Periph U_GPOA (
    //     .*,
    //     .PSEL   (PSEL_GPO),
    //     .PRDATA (PRDATA_GPO),
    //     .PREADY (PREADY_GPO),
    //     // export signals
    //     .outPort(GPOA)
    // );

    // GPI_Periph U_GPIB (
    //     .*,
    //     .PSEL  (PSEL_GPI),
    //     .PRDATA(PRDATA_GPI),
    //     .PREADY(PREADY_GPI),
    //     .inPort(GPIB)
    // );

    GPIO_Periph u_GPIO_Periph (
        .*,
        .PSEL  (PSEL_GPIO),
        .PRDATA(PRDATA_GPIO),
        .PREADY(PREADY_GPIO),
        .io    (GPIO)
    );




endmodule
