`timescale 1ns / 1ps

module SPI_Input_Master (
    input  wire        sys_clk,
    input  wire        rst,
    input  wire        btn,
    input  wire [15:0] number,
    output wire         start,
    input wire         done,
    output wire  [ 7:0] data
);
    wire bd_o;

    btn_debounce U_btn_debounce (
        .i_btn(btn),
        .clk  (sys_clk),
        .reset(rst),
        .o_btn(bd_o)
    );

    FSM_input_master U_FSM_input_master (
        .sys_clk(sys_clk),
        .rst    (rst),
        .done   (done),
        .btn    (bd_o),
        .number (number),
        .data   (data),
        .start  (start)
    );

endmodule

// module btn_debounce (
//     input  i_btn,
//     clk,
//     reset,
//     output o_btn
// );

//     // state
//     //         state, next;
//     reg [7:0] q_reg, q_next;  // shift register
//     reg                        edge_detect;
//     wire                       btn_debounce;

//     // 1kHz clk, state
//     reg  [$clog2(100_000)-1:0] counter;
//     reg                        r_1kHz;

//     always @(posedge clk, posedge reset) begin
//         if (reset) begin
//             counter <= 0;
//             r_1kHz  <= 0;
//         end else begin
//             if (counter == 100_000 - 1) begin
//                 counter <= 0;
//                 r_1kHz  <= 1'b1;
//             end else begin  // 1kHz 1thick
//                 counter <= counter + 1;
//                 r_1kHz  <= 1'b0;
//             end
//         end
//     end

//     // state logic, shift register
//     always @(posedge r_1kHz, posedge reset) begin
//         if (reset) begin
//             q_reg <= 0;
//         end else q_reg <= q_next;
//     end

//     // next logic
//     always @(i_btn, r_1kHz) begin  // event i_btn, r_1kHz
//         // q_reg 현재의 상위 7비트를 다음 하위 7비트에 넣고 최상위에는 i_btn을 넣어라
//         q_next = {i_btn, q_reg[7:1]};  // 8shift 동작 
//     end

//     // 8 input AND gate
//     assign btn_debounce = &q_reg;

//     // edge_detector, 100MHz -> F/F 추가
//     always @(posedge clk, posedge reset) begin
//         if (reset) begin
//             edge_detect <= 1'b0;
//         end else edge_detect <= btn_debounce;
//     end

//     // 최종 출력
//     assign o_btn = btn_debounce & (~edge_detect);
// endmodule

module btn_debounce (
    input  i_btn, clk, reset,
    output o_btn
);
    reg [2:0] ff; // 간단한 3단 플립플롭

    always @(posedge clk, posedge reset) begin
        if (reset) 
            ff <= 3'b000;
        else 
            ff <= {ff[1:0], i_btn};
    end

    // 간단한 엣지 검출
    assign o_btn = ff[1] & ~ff[2];
endmodule

module FSM_input_master (
    input wire sys_clk,
    input wire rst,
    input wire done,
    input wire btn,
    input wire [15:0] number,
    output reg [7:0] data, 
    output wire start
);

    localparam IDLE = 0, L_BYTE = 1, H_BYTE = 2;

    reg [1:0] next, state;
    reg start_reg, start_next;

    assign start = start_reg;

    always @(posedge sys_clk, posedge rst) begin
        if (rst) begin
            state <= IDLE;
            start_reg <= 0;
        end else begin
            state <= next;
            start_reg <= start_next;
        end
    end

    always @(*) begin
        next = state;
        start_next = start_reg;
        data = 0;
        case (state)
            IDLE: begin
                start_next = 0;
                if (btn) begin
                    next = L_BYTE;
                    start_next = 1;
                    data = number[7:0];
                end
            end
            L_BYTE: begin
                data = number[7:0];
                if (done) begin
                    // data = number[7:0];
                    start_next = 1'b0;
                    next = H_BYTE;
                end
            end
            H_BYTE: begin
                // start_next = 0;
                data = number[15:8];
                if (done) begin
                    // data = number[15:8];
                    start_next = 1'b0;
                    next = IDLE;
                end else start_next = 1;
            end
        endcase
    end


endmodule


