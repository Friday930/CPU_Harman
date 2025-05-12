`timescale 1ns / 1ps

module AXI4_Lite_Slave (
    // Global Signal
    input logic ACLK,
    input logic ARESETn,

    // Write Address (Write Transaction : AW Channel)
    input  logic [3:0] AWADDR,
    input  logic       AWVALID,
    output logic       AWREADY,

    // Write (Write Transaction : W Channel)
    input  logic [31:0] WDATA,
    input  logic        WVALID,
    output logic        WREADY,

    // Write Response (Write Transaction : B Channel)
    output logic [1:0] BRESP,
    output logic       BVALID,
    input  logic       BREADY,

    // READ Address (READ Transaction : AR Channel)
    input  logic [3:0] ARADDR,
    input  logic       ARVALID,
    output logic       ARREADY,

    // READ (READ Transaction : R Channel)
    output logic [31:0] RDATA,
    output logic        RVALID,
    input  logic        RREADY
);

    logic [31:0] slv_reg0;
    logic [31:0] slv_reg1;
    logic [31:0] slv_reg2;
    logic [31:0] slv_reg3;

  // Write Address (Write Transaction : AW Channel)
  typedef enum {
    AW_IDLE_S,
    AW_READY_S
  } aw_state_e;

  aw_state_e aw_state, aw_next;

  always_ff @(posedge ACLK) begin
    if (!ARESETn) begin
      aw_state <= AW_IDLE_S;
    end else begin
      aw_state <= aw_next;
    end
  end

  always_comb begin
    aw_next = aw_state;
    AWREADY = 1'b0;
    case (aw_state)
        AW_IDLE_S: begin
            AWREADY = 1'b0;
            if (AWVALID) begin
                aw_next = AW_READY_S;
            end
        end
        AW_READY_S: begin
            
        end
    endcase
    

  end

endmodule
