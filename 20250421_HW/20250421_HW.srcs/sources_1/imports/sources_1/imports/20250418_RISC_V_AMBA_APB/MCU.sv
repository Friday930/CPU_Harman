`timescale 1ns / 1ps

module MCU (
    input logic clk,
    input logic reset,

    // output logic [7:0] GPOA,
    // input  logic [7:0] GPIB,
    inout  logic [7:0] GPIOA,
    inout  logic [7:0] GPIOB
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
    logic        PSEL_GPIOA;
    logic        PSEL_GPIOB;
    logic [31:0] PRDATA_RAM;
    // logic [31:0] PRDATA_GPO;
    logic [31:0] PRDATA_GPIOA;
    logic [31:0] PRDATA_GPIOB;
    logic        PREADY_RAM;
    // logic        PREADY_GPO;
    logic        PREADY_GPIOA;
    logic        PREADY_GPIOB;
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
        .PRDATA2(PRDATA_GPIOA),
        .PRDATA3(PRDATA_GPIOB),
        .PREADY0(PREADY_RAM),
        .PREADY1(PREADY_GPO),
        .PREADY2(PREADY_GPIOA),
        .PREADY3(PREADY_GPIOB)
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

    GPIO_Periph U_GPIOA (
        .*,
        .PSEL  (PSEL_GPIOA),
        .PRDATA(PRDATA_GPIOA),
        .PREADY(PREADY_GPIOA),
        .io(GPIOA)
    );

    GPIO_Periph U_GPIOB (
        .*,
        .PSEL  (PSEL_GPIOB),
        .PRDATA(PRDATA_GPIOB),
        .PREADY(PREADY_GPIOB),
        .io    (GPIOB)
    );




endmodule
