`timescale 1ns / 1ps

module fifo_status_reg (
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
    // in or outport signals
    input  logic        write, 
    output logic        read,
    output logic        ready
);

  logic [1:0] fsr;
  logic [7:0] fwd, frd;

  APB_SlaveIntf U_APB_Intf (.*);
  fifo U_FIFO (.*);

endmodule

// module APB_SlaveIntf (
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
//     input  logic [ 1:0] fsr,
//     output logic [ 7:0] fwd,
//     output logic [ 7:0] frd,
//     output logic        ready,
//     output logic        wr_en,
//     output logic        rd_en
// );
//   logic [31:0] slv_reg0, slv_reg1, slv_reg2, slv_reg3;

//   assign fsr   = slv_reg0[1:0];
//   assign fwd   = slv_reg1[7:0];
//   assign frd   = slv_reg2[7:0];
//   assign ready = slv_reg3[0];

//   always_ff @(posedge PCLK, posedge PRESET) begin
//     if (PRESET) begin
//       slv_reg0 <= 0;
//       slv_reg1 <= 0;
//       slv_reg2 <= 0;
//       slv_reg3 <= 0;
//     end else begin
//       if (PSEL && PENABLE) begin
//         PREADY <= 1'b1;
//         if (PWRITE) begin
//           case (PADDR[3:2])
//             2'd0: slv_reg0 <= PWDATA;
//             2'd1: slv_reg1 <= PWDATA;
//             // 2'd2: slv_reg2 <= PWDATA;
//             2'd3: slv_reg3 <= PWDATA;
//           endcase
//         end else begin
//           PRDATA <= 32'bx;
//           case (PADDR[3:2])
//             2'd0: PRDATA <= slv_reg0;
//             // 2'd1: PRDATA <= slv_reg1;
//             2'd2: PRDATA <= slv_reg2;
//             2'd3: PRDATA <= slv_reg3;
//           endcase
//         end
//       end else begin
//         PREADY <= 1'b0;
//       end
//     end
//   end

// endmodule

module APB_SlaveIntf (
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
    input  logic [ 1:0] fsr,
    output logic [ 7:0] fwd,
    output logic [ 7:0] frd,
    output logic        ready,
    output logic        wr_en,
    output logic        rd_en
);
  logic [31:0] slv_reg0, slv_reg1, slv_reg2, slv_reg3;

  assign fsr   = slv_reg0[1:0];
  assign fwd   = slv_reg1[7:0];
  assign frd   = slv_reg2[7:0];
  assign ready = slv_reg3[0];

  localparam IDLE = 2'b00, READ = 2'b01, WRITE = 2'b10, RW = 2'b11;
  logic [1:0] state;
  logic [1:0] fsr_reg, fsr_next;
  logic [7:0] fwd_reg, fwd_next;
  logic [7:0] frd_reg, frd_next;
  logic ready_reg, ready_next;

  assign {wr_en, rd_en} = state;
  assign fsr            = fsr_reg;
  assign fwd            = fwd_reg;
  assign frd            = frd_reg;
  assign ready          = ready_reg;

  always_ff @(posedge PCLK, posedge PRESET) begin
    if (PRESET) begin
      slv_reg0 <= 0;
      slv_reg1 <= 0;
      slv_reg2 <= 0;
      slv_reg3 <= 0;
      state    <= 0;
    end else begin
      if (PSEL && PENABLE) begin
        PREADY <= 1'b1;
        if (PWRITE) begin
          case (PADDR[3:2])
            2'd0: slv_reg0 <= PWDATA;
            2'd1: slv_reg1 <= PWDATA;
            // 2'd2: slv_reg2 <= PWDATA;
            2'd3: slv_reg3 <= PWDATA;
          endcase
        end else begin
          PRDATA <= 32'bx;
          case (PADDR[3:2])
            2'd0: PRDATA <= slv_reg0;
            // 2'd1: PRDATA <= slv_reg1;
            2'd2: PRDATA <= slv_reg2;
            2'd3: PRDATA <= slv_reg3;
          endcase
        end
      end else begin
        PREADY <= 1'b0;
      end
    end
  end

  always_comb begin
    case (state)
      IDLE: begin 
        
      end
      READ: begin

      end
      WRITE: begin
        
      end
      RW: begin

      end
    endcase
  end

endmodule
