`timescale 1ns / 1ps

module GPO_Periph (
    input  logic        PCLK,
    input  logic        PRESET,
    // APB Interface Signals
    input  logic [ 3:0] PADDR,
    input  logic [31:0] PWDATA,
    input  logic        PWRITE,
    input  logic        PENABLE,
    input  logic        PSEL,
    output logic [31:0] PRDATA,
    output logic        PREADY,
    // export signals
    output logic [ 7:0] outPort
);

    logic [7:0] moder;
    logic [7:0] odr;

    APB_Slave U_APB_Intf (.*);
    GPO U_GPO (.*);
endmodule
