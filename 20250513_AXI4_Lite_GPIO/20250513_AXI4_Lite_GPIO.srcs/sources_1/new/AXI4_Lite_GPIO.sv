`timescale 1ns / 1ps

module AXI4_Lite_GPIO (
    // Global Signals
    input  logic        ACLK,
    input  logic        ARESETn,
    // WRITE Transaction, AW Channel
    input  logic [ 3:0] AWADDR,
    input  logic        AWVALID,
    output logic        AWREADY,
    // WRITE Transaction, W Channel
    input  logic [31:0] WDATA,
    input  logic        WVALID,
    output logic        WREADY,
    // WRITE Transaction, B Channel
    output logic [ 1:0] BRESP,
    output logic        BVALID,
    input  logic        BREADY,
    // READ Transaction, AR Channel
    input  logic [ 3:0] ARADDR,
    input  logic        ARVALID,
    output logic        ARREADY,
    // READ Transaction, R Channel
    output logic [31:0] RDATA,
    output logic        RVALID,
    input  logic        RREADY,
    output logic [ 1:0] RRESP,
    // external port
    inout  logic [ 7:0] io_port
);

    logic [7:0] moder, odr, idr;

    AXI4_Lite_Interface_GPIO U_AXI4_Intf_GPIO (.*);
    GPIO_ip U_GPIO (.*);
    
endmodule

module AXI4_Lite_Interface_GPIO (
    // Global Signals
    input  logic        ACLK,
    input  logic        ARESETn,
    // WRITE Transaction, AW Channel
    input  logic [ 3:0] AWADDR,
    input  logic        AWVALID,
    output logic        AWREADY,
    // WRITE Transaction, W Channel
    input  logic [31:0] WDATA,
    input  logic        WVALID,
    output logic        WREADY,
    // WRITE Transaction, B Channel
    output logic [ 1:0] BRESP,
    output logic        BVALID,
    input  logic        BREADY,
    // READ Transaction, AR Channel
    input  logic [ 3:0] ARADDR,
    input  logic        ARVALID,
    output logic        ARREADY,
    // READ Transaction, R Channel
    output logic [31:0] RDATA,
    output logic        RVALID,
    input  logic        RREADY,
    output logic [ 1:0] RRESP,
    // internal signals
    output logic [ 7:0] moder,
    output logic [ 7:0] odr,
    input  logic [ 7:0] idr
);

    logic [31:0] slv_reg0, slv_reg1, slv_reg2, slv_reg3;

    assign moder         = slv_reg0[7:0];
    assign odr           = slv_reg1[7:0];
    assign slv_reg2[7:0] = idr;  // read only

    // WRITE Transation, AW Channel transfer
    typedef enum bit {
        AW_IDLE_S,
        AW_READY_S
    } aw_state_e;

    aw_state_e aw_state, aw_next;
    logic [3:0] aw_addr_reg, aw_addr_next;  // addr 저장 공간

    always_ff @(posedge ACLK) begin  // clk에 맞추는 동기화 reset
        if (!ARESETn) begin
            aw_state    <= AW_IDLE_S;
            aw_addr_reg <= 0;
        end else begin
            aw_state    <= aw_next;
            aw_addr_reg <= aw_addr_next;
        end
    end

    always_comb begin
        aw_next      = aw_state;
        AWREADY      = 1'b0;
        aw_addr_next = aw_addr_reg;
        case (aw_state)
            AW_IDLE_S: begin
                AWREADY = 1'b0;
                if (AWVALID) begin // valid 신호 들어왔을 때 context switching이 일어남
                    aw_next      = AW_READY_S;
                    aw_addr_next = AWADDR;
                end
            end
            AW_READY_S: begin
                AWREADY = 1'b1;  // Handshaking 일어남
                aw_addr_next = AWADDR; // AWADDR값 변경되면 안됨 aw_addr_reg도 가능하긴 함
                aw_next = AW_IDLE_S;
            end
        endcase
    end

    // WRITE Transation, W Channel transfer
    typedef enum bit {
        W_IDLE_S,
        W_READY_S
    } w_state_e;

    w_state_e w_state, w_next;

    always_ff @(posedge ACLK) begin
        if (!ARESETn) begin
            w_state <= W_IDLE_S;
        end else begin
            w_state <= w_next;
        end
    end

    always_comb begin
        w_next = w_state;
        WREADY = 1'b0;
        case (w_state)
            W_IDLE_S: begin
                WREADY = 1'b0;
                if (AWVALID) begin
                    w_next = W_READY_S;
                end
            end
            W_READY_S: begin
                WREADY = 1'b1;
                if (WVALID) begin
                    w_next = W_IDLE_S;
                    case (aw_addr_reg[3:2])
                        2'd0: slv_reg0 = WDATA;
                        2'd1: slv_reg1 = WDATA;
                        2'd2:
                        ;//slv_reg2 = WDATA; -> 두 군데 동시 저장 불가
                        2'd3: slv_reg3 = WDATA;
                    endcase
                end
            end
        endcase
    end

    // WRITE Transation, B Channel transfer
    typedef enum bit {
        B_IDLE_S,
        B_VALID_S
    } b_state_e;

    b_state_e b_state, b_next;

    always_ff @(posedge ACLK) begin
        if (!ARESETn) begin
            b_state <= B_IDLE_S;
        end else begin
            b_state <= b_next;
        end
    end

    always_comb begin
        b_next = b_state;
        BVALID = 1'b0;
        BRESP  = 2'b00;
        case (b_state)
            B_IDLE_S: begin
                BVALID = 1'b0;
                if (WVALID && WREADY) begin
                    b_next = B_VALID_S;
                end
            end
            B_VALID_S: begin
                BVALID = 1'b1;
                BRESP  = 2'b00;  // OK
                if (BREADY) begin
                    b_next = B_IDLE_S;
                end
            end
        endcase
    end

    // READ Transation, AR Channel transfer
    typedef enum bit {
        AR_IDLE_S,
        AR_READY_S
    } ar_state_e;

    ar_state_e ar_state, ar_next;
    logic [3:0] ar_addr_reg, ar_addr_next;  // addr 저장 공간

    always_ff @(posedge ACLK) begin
        if (!ARESETn) begin
            ar_state    <= AR_IDLE_S;
            ar_addr_reg <= 0;
        end else begin
            ar_state    <= ar_next;
            ar_addr_reg <= ar_addr_next;
        end
    end

    always_comb begin
        ar_next      = ar_state;
        ARREADY      = 1'b0;
        ar_addr_next = ar_addr_reg;
        case (ar_state)
            AW_IDLE_S: begin
                ARREADY = 1'b0;
                if (ARVALID) begin
                    ar_next = AR_READY_S;
                    ar_addr_next = ARADDR; // VALID 신호 들어오면 주소 저장
                end
            end
            AW_READY_S: begin
                ARREADY      = 1'b1;
                ar_addr_next = ARADDR;
                ar_next      = AR_IDLE_S;
            end
        endcase
    end

    // READ Transation, R Channel transfer
    typedef enum bit {
        R_IDLE_S,
        R_VALID_S
    } r_state_e;

    r_state_e r_state, r_next;

    always_ff @(posedge ACLK) begin
        if (!ARESETn) begin
            r_state <= R_IDLE_S;
        end else begin
            r_state <= r_next;
        end
    end

    always_comb begin
        r_next = r_state;
        RVALID = 1'b0;
        RRESP  = 2'b00;
        case (r_state)
            R_IDLE_S: begin
                RVALID = 1'b0;
                if (ARVALID && ARREADY) begin
                    r_next = R_VALID_S;
                end
            end
            R_VALID_S: begin
                RVALID = 1'b1;
                RRESP  = 2'b00;  // OK
                case (ar_addr_reg[3:2])
                    2'd0: RDATA = slv_reg0;
                    2'd1: RDATA = slv_reg1;
                    2'd2: RDATA = slv_reg2;
                    2'd3: RDATA = slv_reg3;
                endcase
                if (RREADY) begin
                    r_next = R_IDLE_S;
                end
            end
        endcase
    end

endmodule

module GPIO_ip (
    input  logic [7:0] moder,
    input  logic [7:0] odr,
    output logic [7:0] idr,
    inout  logic [7:0] io_port
);
    genvar i;
    generate
        for (i = 0; i < 8; i++) begin
            assign io_port[i] = moder[i] ? odr[i] : 1'bz;
            assign idr[i]     = (~moder[i]) ? io_port[i] : 1'bz;
        end
    endgenerate
endmodule
