`timescale 1ns / 1ps

module SPI_Slave_IP (
    input  wire       sys_clk,
    input  wire       rst,
    input  wire       SCLK,
    input  wire       MOSI,
    input  wire       CS,
    output wire       MISO,
    output wire [7:0] fnd_font,
    output wire [3:0] fnd_comm
);

    wire [ 7:0] data;
    wire        done;
    wire [15:0] fnd_data;

    SPI_Slave U_SPI_Slave (
        .SCLK(SCLK),
        .rst (rst),
        .MOSI(MOSI),
        .CS  (CS),
        .MISO(MISO),
        .data(data),
        .done(done)
    );

    FSM U_FSM (
        .sys_clk (sys_clk),
        .rst     (rst),
        .data    (data),
        .done    (done),
        .CS      (CS),
        .fnd_data(fnd_data)
    );

    fnd_controller U_fnd_controller (
        .clk     (sys_clk),
        .reset   (rst),
        .bcd     (fnd_data),
        .seg     (fnd_font),
        .seg_comm(fnd_comm)
    );

endmodule

module SPI_Slave (
    input  wire       SCLK,
    input  wire       rst,
    input  wire       MOSI,
    input  wire       CS,
    output wire       MISO,
    output wire [7:0] data,
    output reg        done
);

    reg [          7:0] data_reg;
    reg [$clog2(8)-1:0] bit_count;
    assign data = data_reg;

    assign MISO = CS ? 8'dz : MOSI;

    always @(posedge SCLK, posedge rst) begin
        if (rst) begin
            data_reg <= 0;
        end else begin
            if (!CS) begin
                done <= 0;
                data_reg <= {data_reg[6:0], MOSI};
                if (bit_count == 7) begin
                    done <= 1;
                    bit_count <= 0;
                end else bit_count <= bit_count + 1;
            end
        end
    end
endmodule

module FSM (
    input  wire        sys_clk,
    input  wire        rst,
    input  wire [ 7:0] data,
    input  wire        done,
    input  wire        CS,
    output wire [15:0] fnd_data
);

    localparam IDLE = 0, L_BYTE = 1, H_BYTE = 2;

    reg [1:0] next, state;
    reg [15:0] fnd_data_reg, fnd_data_next;

    assign fnd_data = fnd_data_reg;

    always @(posedge sys_clk, posedge rst) begin
        if (rst) begin
            state <= IDLE;
            fnd_data_reg <= 0;
        end else begin
            state <= next;
            fnd_data_reg <= fnd_data_next;
        end
    end

    always @(*) begin
        next = state;
        fnd_data_next = fnd_data_reg;
        case (state)
            IDLE: begin
                if (!CS) begin
                    next = L_BYTE;
                end
            end
            L_BYTE: begin
                if (!CS && done) begin
                    fnd_data_next[7:0] = data;
                    next = H_BYTE;
                end
            end
            H_BYTE: begin
                if (!CS && done) begin
                    fnd_data_next[15:8] = data;
                    next = IDLE;
                end
            end
        endcase
    end

endmodule

