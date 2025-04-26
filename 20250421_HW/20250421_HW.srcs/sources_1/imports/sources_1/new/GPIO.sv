`timescale 1ns / 1ps

module GPIO_Periph (
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
    // inoutport signals
    inout  logic [ 7:0] io
);

    logic [7:0] moder;
    logic [7:0] idr;
    logic [7:0] odr;

    APB_Slave_GPIO U_APB_Intf_GPIO (.*);
    GPIO U_GPIO (.*);
endmodule

module GPIO (
    input  logic [7:0] moder,
    input  logic PWRITE,
    input  logic [7:0] odr,
    output logic [7:0] idr,
    inout  logic [7:0] io
);

    logic [7:0] ioPort;

    genvar i;
    generate
        for (i = 0;i < 8;i++) begin
            assign ioPort[i] = moder[i] ? odr[i] : 1'bz;
            assign idr[i] = ~moder[i] ? io[i] : 1'bz;
        end
    endgenerate

    assign  io = PWRITE ? ioPort : 8'bz;

endmodule

module APB_Slave_GPIO (
    // global signal
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
    // internal signals (GPIO)
    output logic [ 7:0] moder,
    output logic [ 7:0] odr,
    input  logic [ 7:0] idr
);
    logic [31:0] slv_reg0, slv_reg1, slv_reg2;

    assign moder = slv_reg0[7:0];
    assign odr   = slv_reg1[7:0];
    assign idr   = slv_reg2[7:0];

    always_ff @(posedge PCLK, posedge PRESET) begin
        if (PRESET) begin
            slv_reg0 <= 0;
            slv_reg1 <= 0;
            slv_reg2 <= 0;
            // slv_reg3 <= 0;
        end else begin
            if (PSEL && PENABLE) begin
                PREADY <= 1'b1;
                if (PWRITE) begin
                    case (PADDR[3:2])
                        2'd0: slv_reg0 <= PWDATA;
                        2'd1: slv_reg1 <= PWDATA;
                        2'd2: slv_reg2 <= PWDATA;
                        // 2'd3: slv_reg3 <= PWDATA;
                    endcase
                end else begin
                    PRDATA <= 32'bx;
                    case (PADDR[3:2])
                        2'd0: PRDATA <= slv_reg0;
                        2'd1: PRDATA <= slv_reg1;
                        2'd2: PRDATA <= slv_reg2;
                        // 2'd3: PRDATA <= slv_reg3;
                    endcase
                end
            end else begin
                PREADY <= 1'b0;
            end
        end
    end

endmodule
