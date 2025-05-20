`timescale 1ns / 1ps

module SPI_Slave (
    // global signals
    input  wire clk,
    input  wire rst,
    // SPI signals
    input  wire SCLK,
    input  wire MOSI,
    output wire MISO,
    input  wire SS
);
    wire [7:0] si_data;
    wire       si_done;
    wire [7:0] so_data;
    wire       so_start;
    wire       so_done;

    SPI_Slave_Intf U_SPI_Slave_Intf (
        .clk     (clk),
        .rst     (rst),
        .SCLK    (SCLK),
        .MOSI    (MOSI),
        .MISO    (MISO),
        .SS      (SS),
        .si_data (si_data),
        .si_done (si_done),
        .so_data (so_data),
        .so_start(so_start),
        .so_done (so_done)
    );

    SPI_Slave_Reg U_SPI_Slave_Reg (
        .clk     (clk),
        .rst     (rst),
        .ss_n    (SS),
        .si_data (si_data),
        .si_done (si_done),
        .so_data (so_data),
        .so_start(so_start),
        .so_done (so_done)
    );

endmodule

module SPI_Slave_Intf (
    // global signals
    input  wire       clk,
    input  wire       rst,
    // SPI signals
    input  wire       SCLK,
    input  wire       MOSI,
    output wire       MISO,
    input  wire       SS,
    // internal signals
    output wire [7:0] si_data,
    output wire       si_done,
    input  wire [7:0] so_data,
    input  wire       so_start,
    output wire       so_done
);

    // Flip-Flop Syncronizer

    reg sclk_sync0, sclk_sync1;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            sclk_sync0 <= 0;
            sclk_sync1 <= 0;
        end else begin
            sclk_sync0 <= SCLK;
            sclk_sync1 <= sclk_sync0;
        end
    end

    wire sclk_rising = sclk_sync0 & ~sclk_sync1;
    wire sclk_falling = ~sclk_sync0 & sclk_sync1;

    // Slave Input Circuit (MOSI)

    localparam SI_IDLE = 0, SI_PHASE = 1;

    reg si_state, si_next;
    reg si_done_reg, si_done_next;
    reg [7:0] si_data_reg, si_data_next;
    reg [$clog2(7)-1:0] si_bit_cnt_reg, si_bit_cnt_next;

    assign si_data = si_data_reg;
    assign si_done = si_done_reg;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            si_state       <= SI_IDLE;
            si_done_reg    <= 0;
            si_data_reg    <= 0;
            si_bit_cnt_reg <= 0;
        end else begin
            si_state       <= si_next;
            si_done_reg    <= si_done_next;
            si_data_reg    <= si_data_next;
            si_bit_cnt_reg <= si_bit_cnt_next;
        end
    end

    always @(*) begin
        si_next         = si_state;
        si_done_next    = si_done_reg;
        si_data_next    = si_data_reg;
        si_bit_cnt_next = si_bit_cnt_reg;
        case (si_state)
            SI_IDLE: begin
                si_done_next = 1'b0;
                if (!SS) begin
                    si_bit_cnt_next = 0;
                    si_next         = SI_PHASE;
                end
            end
            SI_PHASE: begin
                if (!SS) begin
                    if (sclk_rising) begin
                        si_data_next = {si_data_reg[6:0], MOSI};
                        if (si_bit_cnt_reg == 7) begin
                            si_bit_cnt_next = 0;
                            si_done_next    = 1'b1;
                            si_next         = SI_IDLE;
                        end else begin
                            si_bit_cnt_next = si_bit_cnt_reg + 1;
                        end
                    end
                end else begin
                    si_next = SI_IDLE;
                end
            end
        endcase
    end

    // Slave Output Circuit (MISO)

    localparam SO_IDLE = 0, SO_PHASE = 1;

    reg so_state, so_next;
    reg so_done_reg, so_done_next;
    reg [7:0] so_data_reg, so_data_next;
    reg [$clog2(7)-1:0] so_bit_cnt_reg, so_bit_cnt_next;

    assign so_done = so_done_reg;
    assign MISO    = ~SS ? so_data_reg[7] : 1'bz;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            so_state       <= SO_IDLE;
            so_done_reg    <= 0;
            so_data_reg    <= 0;
            so_bit_cnt_reg <= 0;
        end else begin
            so_state       <= so_next;
            so_done_reg    <= so_done_next;
            so_data_reg    <= so_data_next;
            so_bit_cnt_reg <= so_bit_cnt_next;
        end
    end

    always @(*) begin
        so_next         = so_state;
        so_done_next    = so_done_reg;
        so_data_next    = so_data_reg;
        so_bit_cnt_next = so_bit_cnt_reg;
        case (so_state)
            SO_IDLE: begin
                so_done_next = 1'b0;
                if (!SS && so_start) begin
                    so_bit_cnt_next = 0;
                    so_data_next    = so_data;
                    so_next         = SO_PHASE;
                end
            end
            SO_PHASE: begin
                if (!SS) begin
                    if (sclk_falling) begin
                        // data shift 되서 출력됨
                        so_data_next = {so_data_reg[6:0], 1'b0};
                        if (so_bit_cnt_reg == 7) begin
                            so_bit_cnt_next = 0;
                            so_done_next    = 1'b1;
                            so_next         = SO_IDLE;
                        end else begin
                            so_bit_cnt_next = so_bit_cnt_reg + 1;
                        end
                    end
                end else begin
                    so_next = SO_IDLE;
                end
            end
        endcase
    end

endmodule

module SPI_Slave_Reg (
    // global signals
    input  wire       clk,
    input  wire       rst,
    // internal signals
    input  wire       ss_n,
    input  wire [7:0] si_data,
    input  wire       si_done,
    // input  wire       so_ready,
    output reg  [7:0] so_data,
    output wire       so_start,
    input  wire       so_done
);
    localparam IDLE = 0, ADDR_PHASE = 1, WRITE_PHASE = 2, READ_PHASE = 3;

    reg [7:0] slv_reg0, slv_reg1, slv_reg2, slv_reg3;
    // reg [7:0] slv_reg[0:3];

    reg [1:0] state, next;
    reg [1:0] addr_next, addr_reg;
    reg so_start_next, so_start_reg;

    assign so_start = so_start_reg;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            state        <= IDLE;
            addr_reg     <= 0;
            so_start_reg <= 0;
        end else begin
            state        <= next;
            addr_reg     <= addr_next;
            so_start_reg <= so_start_next;
        end
    end

    always @(*) begin
        next          = state;
        addr_next     = addr_reg;
        so_start_next = so_start_reg;
        case (state)
            IDLE: begin
                so_start_next = 1'b0;
                if (!ss_n) begin
                    next = ADDR_PHASE;
                end
            end
            ADDR_PHASE: begin
                if (!ss_n) begin
                    if (si_done) begin
                        addr_next = si_data[1:0];
                        if (si_data[7]) begin
                            next = WRITE_PHASE;
                        end else begin
                            next = READ_PHASE;
                        end
                    end
                end else begin
                    next = IDLE;
                end
            end
            WRITE_PHASE: begin
                if (!ss_n) begin
                    if (si_done) begin
                        case (addr_reg)
                            2'd0: slv_reg0 = si_data;
                            2'd1: slv_reg1 = si_data;
                            2'd2: slv_reg2 = si_data;
                            2'd3: slv_reg3 = si_data;
                        endcase
                        if (addr_reg == 2'd3) begin
                            addr_next = 0;
                        end else begin
                            addr_next = addr_reg + 1;
                        end
                    end
                end else begin
                    next = IDLE;
                end
            end
            READ_PHASE: begin
                if (!ss_n) begin
                    so_start_next = 1'b1;
                    case (addr_reg)
                        2'd0: so_data = slv_reg0;
                        2'd1: so_data = slv_reg1;
                        2'd2: so_data = slv_reg2;
                        2'd3: so_data = slv_reg3;
                    endcase
                    if (so_done) begin
                        if (addr_reg == 3) begin
                            addr_next = 0;
                        end else begin
                            addr_next = addr_reg + 1;
                        end
                    end
                end else begin
                    next = IDLE;
                end
            end
        endcase
    end

endmodule
