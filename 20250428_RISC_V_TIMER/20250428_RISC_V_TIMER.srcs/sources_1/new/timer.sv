`timescale 1ns / 1ps

module tim_periph (
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
    output logic        PREADY
);

    logic        en;
    logic        clear;
    logic [31:0] psc;
    logic [31:0] arr;
    logic [31:0] tcnt;

    APB_Slave_TIM U_APB_Intf_TIM (.*);
    timer U_TIM (
        .clk  (PCLK),
        .reset(PRESET),
        .*
    );

endmodule

module timer (
    input  logic        clk,
    input  logic        reset,
    input  logic        en,
    input  logic        clear,
    input  logic [31:0] psc,
    input  logic [31:0] arr,
    output logic [31:0] tcnt
);

    logic tim_tick;

    prescaler U_PSC (.*);
    tim_counter U_TCNT (.*);

endmodule

module prescaler (
    input  logic        clk,
    input  logic        reset,
    input  logic        en,
    input  logic        clear,
    input  logic [31:0] psc,
    output logic        tim_tick
);
    logic [31:0] counter;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            counter  <= 0;
            tim_tick <= 1'b0;
        end else begin
            if (en) begin
                if (counter == psc) begin // -1은 c언어에서(HW 부하 줄이기)
                    counter  <= 0;
                    tim_tick <= 1'b1;
                end else begin
                    counter  <= counter + 1;
                    tim_tick <= 1'b0;
                end
            end
            if (clear) begin
                counter  <= 0;
                tim_tick <= 1'b0;
            end
        end
    end

endmodule

module tim_counter (
    input  logic        clk,
    input  logic        reset,
    input  logic        clear,
    input  logic        tim_tick,
    input  logic [31:0] arr,
    output logic [31:0] tcnt
);

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            tcnt <= 0;
        end else begin
            if (tim_tick) begin
                if (tcnt == arr) begin
                    tcnt <= 0;
                end else begin
                    tcnt <= tcnt + 1;
                end
                if (clear) begin
                    tcnt <= 0;
                end
            end
        end
    end

endmodule

module APB_Slave_TIM (
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
    // internal side signals
    output logic        en,
    output logic        clear,
    output logic [31:0] psc,
    output logic [31:0] arr,
    input  logic [31:0] tcnt
);
    logic [31:0] slv_reg0, slv_reg1, slv_reg2, slv_reg3;

    assign en       = slv_reg0[0];
    assign clear    = slv_reg0[1];
    assign slv_reg1 = tcnt;
    assign psc      = slv_reg2;
    assign arr      = slv_reg3;

    always_ff @(posedge PCLK, posedge PRESET) begin
        if (PRESET) begin
            slv_reg0 <= 0;
            // slv_reg1 <= 0;
            slv_reg2 <= 0;
            slv_reg3 <= 0;
        end else begin
            if (PSEL && PENABLE) begin
                PREADY <= 1'b1;
                if (PWRITE) begin
                    case (PADDR[3:2])
                        2'd0: slv_reg0 <= PWDATA;
                        2'd1: ;//slv_reg1 <= PWDATA;
                        2'd2: slv_reg2 <= PWDATA;
                        2'd3: slv_reg3 <= PWDATA;
                    endcase
                end else begin
                    PRDATA <= 32'bx;
                    case (PADDR[3:2])
                        2'd0: PRDATA <= slv_reg0;
                        2'd1: PRDATA <= slv_reg1;
                        2'd2: PRDATA <= slv_reg2;
                        2'd3: PRDATA <= slv_reg3;
                    endcase
                end
            end else begin
                PREADY <= 1'b0;
            end
        end
    end

endmodule
