// `timescale 1ns / 1ps

// module SPI_Master (
//     input  wire       sys_clk,
//     input  wire       rst,
//     input  wire       start,
//     input  wire [7:0] tx_data,
//     output wire [7:0] rx_data,
//     output wire       MOSI,
//     input  wire       MISO,
//     output reg        done,
//     output reg        ready,
//     output reg        SCLK,
//     output reg        CS
// );

//     localparam IDLE = 0, CP0 = 1, CP1 = 2;

//     reg [1:0] state, next;
//     reg [7:0] temp_tx_data_reg, temp_tx_data_next;
//     reg [7:0] rx_data_reg, rx_data_next;
//     reg [$clog2(50)-1:0] SCLK_counter_reg, SCLK_counter_next;
//     reg [$clog2(8)-1:0] bit_counter_reg, bit_counter_next;

//     assign rx_data = rx_data_reg;
//     assign MOSI = temp_tx_data_reg[7];

//     always @(posedge sys_clk, posedge rst) begin
//         if (rst) begin
//             state            <= IDLE;
//             temp_tx_data_reg <= 0;
//             rx_data_reg      <= 0;
//             SCLK_counter_reg <= 0;
//             bit_counter_reg  <= 0;
//         end else begin
//             state            <= next;
//             temp_tx_data_reg <= temp_tx_data_next;
//             rx_data_reg      <= rx_data_next;
//             SCLK_counter_reg <= SCLK_counter_next;
//             bit_counter_reg  <= bit_counter_next;
//         end
//     end

//     always @(*) begin
//         next              = state;
//         temp_tx_data_next = temp_tx_data_reg;
//         rx_data_next      = rx_data_reg;
//         SCLK_counter_next = SCLK_counter_reg;
//         bit_counter_next  = bit_counter_reg;
//         ready             = 1'b0;
//         done              = 1'b0;
//         SCLK              = 1'b0;
//         CS                = 1'b1;
//         case (state)
//             IDLE: begin
//                 temp_tx_data_next = 8'bz;
//                 done = 1'b0;
//                 ready = 1'b1;
//                 CS = 1'b1;
//                 if (start) begin
//                     temp_tx_data_next = tx_data;
//                     ready = 1'b0;
//                     next = CP0;
//                     CS = 1'b0;
//                 end else next = IDLE;
//             end
//             CP0: begin
//                 SCLK = 1'b0;
//                 if (SCLK_counter_reg == 49) begin
//                     rx_data_next = {rx_data_reg[6:0], MISO};
//                     SCLK_counter_next = 0;
//                     next = CP1;
//                 end else begin
//                     SCLK_counter_next = SCLK_counter_reg + 1;
//                     CS = 1'b0;
//                 end
//             end
//             CP1: begin
//                 SCLK = 1'b1;
//                 CS = 1'b0;
//                 if (SCLK_counter_reg == 49) begin
//                     SCLK_counter_next = 0;
//                     if (bit_counter_reg == 7) begin
//                         done = 1'b1;
//                         next = IDLE;
//                         CS = 1'b1;
//                     end else begin
//                         temp_tx_data_next = {temp_tx_data_reg[6:0], 1'b0};
//                         // SCLK_counter_next = 0;
//                         bit_counter_next  = bit_counter_reg + 1;
//                         next = CP0;
//                     end
//                 end else begin
//                     SCLK_counter_next = SCLK_counter_reg + 1;
//                     // next = CP0;
//                 end
//             end
//         endcase
//     end
// endmodule

module SPI_Master (
    input  wire       sys_clk,
    input  wire       rst,
    input  wire       start,
    input  wire [7:0] tx_data,
    output wire [7:0] rx_data,
    output wire       MOSI,
    input  wire       MISO,
    output reg        done,
    output reg        ready,
    output reg        SCLK,
    output wire        CS
);

    localparam IDLE = 0, CP0 = 1, CP1 = 2;

    reg [1:0] state, next;
    reg [7:0] temp_tx_data_reg, temp_tx_data_next;
    reg [7:0] rx_data_reg, rx_data_next;
    reg [$clog2(50)-1:0] SCLK_counter_reg, SCLK_counter_next;
    reg [$clog2(8)-1:0] bit_counter_reg, bit_counter_next;

    assign rx_data = rx_data_reg;
    assign MOSI = temp_tx_data_reg[7];

    always @(posedge sys_clk, posedge rst) begin
        if (rst) begin
            state            <= IDLE;
            temp_tx_data_reg <= 0;
            rx_data_reg      <= 0;
            SCLK_counter_reg <= 0;
            bit_counter_reg  <= 0;
        end else begin
            state            <= next;
            temp_tx_data_reg <= temp_tx_data_next;
            rx_data_reg      <= rx_data_next;
            SCLK_counter_reg <= SCLK_counter_next;
            bit_counter_reg  <= bit_counter_next;
        end
    end

    // CS 신호 제어를 위한 별도의 플립플롭 추가
    reg cs_reg;
    always @(posedge sys_clk, posedge rst) begin
        if (rst)
            cs_reg <= 1'b1;  // 리셋 시 비활성화
        else if (state == IDLE && start)
            cs_reg <= 1'b0;  // 통신 시작 시 활성화
        else if (state == CP1 && SCLK_counter_reg == 49 && bit_counter_reg == 7)
            cs_reg <= 1'b1;  // 통신 완료 시 비활성화
    end
    
    // CS 신호 할당
    assign CS = cs_reg;

    always @(*) begin
        next              = state;
        temp_tx_data_next = temp_tx_data_reg;
        rx_data_next      = rx_data_reg;
        SCLK_counter_next = SCLK_counter_reg;
        bit_counter_next  = bit_counter_reg;
        ready             = 1'b0;
        done              = 1'b0;
        SCLK              = 1'b0;
        
        case (state)
            IDLE: begin
                temp_tx_data_next = 8'bz;
                done = 1'b0;
                ready = 1'b1;
                if (start) begin
                    temp_tx_data_next = tx_data;
                    ready = 1'b0;
                    next = CP0;
                end else next = IDLE;
            end
            CP0: begin
                SCLK = 1'b0;
                if (SCLK_counter_reg == 49) begin
                    SCLK_counter_next = 0;
                    next = CP1;
                end else begin
                    SCLK_counter_next = SCLK_counter_reg + 1;
                end
            end
            CP1: begin
                SCLK = 1'b1;
                if (SCLK_counter_reg == 49) begin
                    SCLK_counter_next = 0;
                    if (bit_counter_reg == 7) begin
                        done = 1'b1;
                        next = IDLE;
                    end else begin
                        temp_tx_data_next = {temp_tx_data_reg[6:0], 1'b0};
                        bit_counter_next  = bit_counter_reg + 1;
                        next = CP0;
                    end
                end else begin
                    SCLK_counter_next = SCLK_counter_reg + 1;
                end
            end
        endcase
    end
endmodule