// `timescale 1ns / 1ps

// module APB_Slave_FND (
//     // global signal
//     input  logic        PCLK,
//     input  logic        PRESET,
//     // APB Interface Signals
//     input  logic [ 3:0] PADDR,
//     input  logic [31:0] PWDATA,
//     input  logic        PWRITE,
//     input  logic        PENABLE,
//     input  logic        PSEL,
//     output logic [31:0] PRDATA,
//     output logic        PREADY,
//     // internal signals
//     output logic        fcr,
//     output logic [ 3:0] fmr,
//     output logic [ 3:0] fdr
// );
//     logic [31:0] slv_reg0, slv_reg1, slv_reg2;

//     assign fcr = slv_reg0;
//     assign fmr = slv_reg1[3:0];
//     assign fdr = slv_reg2[3:0];

//     always_ff @(posedge PCLK, posedge PRESET) begin
//         if (PRESET) begin
//             slv_reg0 <= 0;
//             slv_reg1 <= 0;
//             slv_reg2 <= 0;
//             // slv_reg3 <= 0;
//         end else begin
//             if (PSEL && PENABLE) begin
//                 PREADY <= 1'b1;
//                 if (PWRITE) begin
//                     case (PADDR[3:2])
//                         2'd0: slv_reg0 <= PWDATA;
//                         2'd1: slv_reg1 <= PWDATA;
//                         2'd2: slv_reg2 <= PWDATA;
//                         // 2'd3: slv_reg3 <= PWDATA;
//                     endcase
//                 end else begin
//                     PRDATA <= 32'bx;
//                     case (PADDR[3:2])
//                         2'd0: PRDATA <= slv_reg0;
//                         2'd1: PRDATA <= slv_reg1;
//                         2'd2: PRDATA <= slv_reg2;
//                         // 2'd3: PRDATA <= slv_reg3;
//                     endcase
//                 end
//             end else begin
//                 PREADY <= 1'b0;
//             end
//         end
//     end
// endmodule

// module fnd_top (
//     input  logic       PCLK,
//     input  logic       PRESET,
//     input  logic       fcr,
//     input  logic [3:0] fmr,
//     input  logic [3:0] fdr,
//     output logic [3:0] fnd_comm,
//     output logic [7:0] fnd_font
// );

//     // logic clk_100Hz;
//     logic [2:0] sel;
//     logic [3:0] d1, d10, d100, d1000, num;

//     // clk_divder U_Clk_divder (
//     //     .clk         (clk),
//     //     .reset       (reset),
//     //     .internal_clk(clk_100Hz)
//     // );

//     // counter U_Counter (
//     //     .clk  (clk_100Hz),
//     //     .reset(reset),
//     //     .sel  (sel)
//     // );

//     decoder_3x8 U_Dec_3x8 (
//         .sel     (fmr),
//         .en      (fcr),
//         .fnd_comm(fnd_comm)
//     );

//     digit_splitter U_Digit_Splitter (
//         .num      (fdr),
//         .en       (fcr),
//         .digit1   (d1),
//         .digit10  (d10),
//         .digit100 (d100),
//         .digit1000(d1000)
//     );

//     mux_4x1 U_mux_4x1 (
//         .sel(sel),
//         .en (fcr),
//         .x0 (d1),
//         .x1 (d10),
//         .x2 (d100),
//         .x3 (d1000),
//         .y  (num)
//     );

//     fnd U_fnd (
//         .num(num),
//         .en (fcr),
//         .seg(fnd_font)
//     );

// endmodule

// // ---- fnd_comm ----
// // module clk_divder #(
// //     parameter FCOUNT = 250_000
// // ) (
// //     input  logic clk,
// //     input  logic reset,
// //     output logic internal_clk
// // );

// //     logic [$clog2(FCOUNT)-1:0] counter;

// //     always_ff @(posedge clk, posedge reset) begin
// //         if (reset) begin
// //             counter <= 0;
// //             internal_clk <= 0;
// //         end else begin
// //             if (counter == FCOUNT - 1) begin
// //                 counter <= 0;
// //                 internal_clk <= 1'b1;
// //             end else begin
// //                 counter <= counter + 1;
// //                 internal_clk <= 1'b0;
// //             end
// //         end
// //     end
// // endmodule

// // module counter (
// //     input  logic       clk,
// //     input  logic       reset,
// //     output logic [2:0] sel
// // );

// //     always_ff @(posedge clk, posedge reset) begin
// //         if (reset) begin
// //             sel <= 0;
// //         end else sel <= sel + 1;
// //     end
// // endmodule

// module decoder_3x8 (
//     input  logic [2:0] sel,
//     input  logic       en,
//     output logic [3:0] fnd_comm
// );

//     always_comb begin
//         if (en) begin
//             case (sel)
//                 3'd0: fnd_comm = 4'b1110;
//                 3'd1: fnd_comm = 4'b1101;
//                 3'd2: fnd_comm = 4'b1011;
//                 3'd3: fnd_comm = 4'b0111;
//                 3'd4: fnd_comm = 4'b1110;
//                 3'd5: fnd_comm = 4'b1101;
//                 3'd6: fnd_comm = 4'b1011;
//                 3'd7: fnd_comm = 4'b0111;
//                 default: fnd_comm = 4'b1111;
//             endcase
//         end
//     end
// endmodule

// // ---- fnd_font ----

// // module digit_splitter #(
// //     parameter BIT_WIDTH = 4
// // ) (
// //     input  logic [BIT_WIDTH-1:0] num,
// //     input  logic                 en,
// //     output logic [          3:0] digit1,
// //     output logic [          3:0] digit10,
// //     output logic [          3:0] digit100,
// //     output logic [          3:0] digit1000
// // );
// //     always_comb begin
// //         digit1 = 0;
// //         digit10 = 0;
// //         digit100 = 0;
// //         digit1000 = 0;
// //         if (en) begin
// //             digit1 = num % 10;
// //             digit10 = (num / 10) % 10;
// //             digit100 = (num / 100) % 10;
// //             digit1000 = (num / 1000) % 10;
// //         end
// //     end

// // endmodule

// module mux_4x1 (
//     input logic en,
//     input logic [2:0] sel,
//     input logic [3:0] x0,
//     input logic [3:0] x1,
//     input logic [3:0] x2,
//     input logic [3:0] x3,
//     output logic [3:0] y
// );

//     always_comb begin
//         if (en) begin
//             case (sel)
//                 3'h0: y = x0;
//                 3'h1: y = x1;
//                 3'h2: y = x2;
//                 3'h3: y = x3;
//                 default: y = 4'hf;
//             endcase
//         end
//     end

// endmodule

// module fnd (
//     input  logic [3:0] num,
//     input  logic       en,
//     output logic [7:0] seg
// );

//     always_comb begin
//         if (en) begin    
//             case (num)
//                 4'h0: seg = 8'hc0;
//                 4'h1: seg = 8'hf9;
//                 4'h2: seg = 8'ha4;
//                 4'h3: seg = 8'hb0;
//                 4'h4: seg = 8'h99;
//                 4'h5: seg = 8'h92;
//                 4'h6: seg = 8'h82;
//                 4'h7: seg = 8'hf8;
//                 4'h8: seg = 8'h80;
//                 4'h9: seg = 8'h90;
//                 4'ha: seg = 8'h88;
//                 4'hb: seg = 8'h83;
//                 4'hc: seg = 8'hc6;
//                 4'hd: seg = 8'ha1;
//                 4'he: seg = 8'h86;
//                 4'hf: seg = 8'h8e;
//                 default: seg = 8'hff;
//             endcase
//         end
//     end
// endmodule
