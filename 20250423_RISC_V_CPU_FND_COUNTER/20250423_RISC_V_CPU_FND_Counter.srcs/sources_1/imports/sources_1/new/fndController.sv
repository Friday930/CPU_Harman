`timescale 1ns / 1ps

module FndController_Periph (
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
    // outport signals
    output logic [ 3:0] fndCom,
    output logic [ 7:0] fndFont
);

    logic        fcr;
    logic [ 3:0] fpr;
    logic [13:0] fdr;

    APB_SlaveIntf_FndController U_APB_Intf_FndController (.*);
    FndController U_FndController (.*);

endmodule

module APB_SlaveIntf_FndController (
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
    // internal signals
    output logic [ 7:0] fcr,
    output logic [ 7:0] fmr,
    output logic [13:0] fdr
);
    logic [31:0] slv_reg0, slv_reg1, slv_reg2;  //, slv_reg3;

    assign fcr = slv_reg0[0];
    assign fmr = slv_reg1[3:0];
    assign fdr = slv_reg2[3:0];


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

// module FndController (
//     input  logic       fcr,
//     input  logic [3:0] fmr,
//     input  logic [13:0] fdr,
//     output logic [3:0] fndCom,
//     output logic [7:0] fndFont
// );
//     assign fndCom = fcr ? ~fmr : 4'b1111;

//     always_comb begin
//         case (fdr)
//             4'h0: fndFont = 8'hc0;
//             4'h1: fndFont = 8'hf9;
//             4'h2: fndFont = 8'ha4;
//             4'h3: fndFont = 8'hb0;
//             4'h4: fndFont = 8'h99;
//             4'h5: fndFont = 8'h92;
//             4'h6: fndFont = 8'h82;
//             4'h7: fndFont = 8'hf8;
//             4'h8: fndFont = 8'h80;
//             4'h9: fndFont = 8'h90;
//             4'ha: fndFont = 8'h88;
//             4'hb: fndFont = 8'h83;
//             4'hc: fndFont = 8'hc6;
//             4'hd: fndFont = 8'ha1;
//             4'he: fndFont = 8'h86;
//             4'hf: fndFont = 8'h8e;
//             default: fndFont = 8'hff;
//         endcase
//     end
// endmodule

module FndController (
    input  logic        PCLK,
    input  logic        PRESET,
    input  logic        fcr,
    input  logic [13:0] fdr,
    input  logic [ 3:0] fpr,
    output logic [ 3:0] fndCom,
    output logic [ 7:0] fndFont
);

    logic tick, fndDp;
    logic [1:0] digit_sel;
    logic [3:0] digit_1, digit_10, digit_100, digit_1000, digit;
    logic [7:0] fndSegData;

    assign fndFont = {fndDp, fndSegData[6:0]};
    //assign fndCom = fcr ? ~fmr : 4'b1111;
    clk_div_1khz U_Clk_Div_1Khz (
        .clk  (PCLK),
        .reset(PRESET),
        .tick (tick)
    );

    counter_2bit U_Conter_2big (
        .clk  (PCLK),
        .reset(PRESET),
        .tick (tick),
        .count(digit_sel)
    );

    decoder_2x4 U_Dec_2x4 (
        .en(fcr),
        .x (digit_sel),
        .y (fndCom)
    );

    digit_splitter U_Digit_Splitter (
        .data(fdr),
        .digit_1(digit_1),
        .digit_10(digit_10),
        .digit_100(digit_100),
        .digit_1000(digit_1000)
    );

    mux_4x1 U_Mux_4x1 (
        .sel(digit_sel),
        .x0 (digit_1),
        .x1 (digit_10),
        .x2 (digit_100),
        .x3 (digit_1000),
        .y  (digit)
    );

    bcdtoseg U_BCDtoSEG (
        .bcd(digit),
        .fndFont(fndSegData)
    );

    mux_4x1_1bit Mux_4x1_1bit (
        .sel(digit_sel),
        .x  (fpr),
        .y  (fndDp)
    );

endmodule

module mux_4x1_1bit (
    input logic [1:0] sel,
    input logic [3:0] x,
    output logic y
);

    always @(*) begin
        y = 1'b1;
        case (sel)
            2'b00: y = x[0];
            2'b01: y = x[1];
            2'b10: y = x[2];
            2'b11: y = x[3];
        endcase
    end

endmodule


module digit_splitter (
    input  logic [13:0] data,
    output logic [ 3:0] digit_1,
    output logic [ 3:0] digit_10,
    output logic [ 3:0] digit_100,
    output logic [ 3:0] digit_1000
);
    assign digit_1 = data % 10;
    assign digit_10 = (data / 10) % 10;
    assign digit_100 = (data / 100) % 10;
    assign digit_1000 = data / 1000;

endmodule

module mux_4x1 (
    input  logic [1:0] sel,
    input  logic [3:0] x0,
    input  logic [3:0] x1,
    input  logic [3:0] x2,
    input  logic [3:0] x3,
    output logic [3:0] y
);
    always @(*) begin
        y = 4'b0000;
        case (sel)
            2'b00: y = x0;
            2'b01: y = x1;
            2'b10: y = x2;
            2'b11: y = x3;
        endcase
    end
endmodule

module bcdtoseg (
    input  logic [3:0] bcd,
    output logic [7:0] fndFont
);
    always_comb begin
        case (bcd)
            4'h0: fndFont = 8'hc0;
            4'h1: fndFont = 8'hf9;
            4'h2: fndFont = 8'ha4;
            4'h3: fndFont = 8'hb0;
            4'h4: fndFont = 8'h99;
            4'h5: fndFont = 8'h92;
            4'h6: fndFont = 8'h82;
            4'h7: fndFont = 8'hf8;
            4'h8: fndFont = 8'h80;
            4'h9: fndFont = 8'h90;
            4'ha: fndFont = 8'h88;
            4'hb: fndFont = 8'h83;
            4'hc: fndFont = 8'hc6;
            4'hd: fndFont = 8'ha1;
            4'he: fndFont = 8'h86;
            4'hf: fndFont = 8'h8e;
            default: fndFont = 8'hff;
        endcase
    end
endmodule

module clk_div_1khz (
    input  logic clk,
    input  logic reset,
    output logic tick
);
    reg [$clog2(100_000)-1 : 0] div_counter;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            div_counter <= 0;
            tick <= 1'b0;
        end else begin
            if (div_counter == 100_000 - 1) begin
                div_counter <= 0;
                tick <= 1'b1;
            end else begin
                div_counter <= div_counter + 1;
                tick <= 1'b0;
            end
        end
    end
endmodule

module counter_2bit (
    input  logic       clk,
    input  logic       reset,
    input  logic       tick,
    output logic [1:0] count
);
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            count <= 0;
        end else begin
            if (tick) begin
                count <= count + 1;
            end
        end
    end
endmodule

module decoder_2x4 (
    input  logic       en,
    input  logic [1:0] x,
    output logic [3:0] y
);
    always @(*) begin
        y = 4'b1111;
        if (en) begin
            case (x)
                2'b00: y = 4'b1110;
                2'b01: y = 4'b1101;
                2'b10: y = 4'b1011;
                2'b11: y = 4'b0111;
            endcase
        end else begin
            y = 4'b1111;
        end
    end
endmodule
