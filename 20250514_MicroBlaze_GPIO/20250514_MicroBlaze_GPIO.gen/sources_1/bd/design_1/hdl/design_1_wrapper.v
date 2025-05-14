//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Wed May 14 12:21:03 2025
//Host        : DESKTOP-7CFQ9ND running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (GPIOA_tri_io,
    GPIOB,
    reset,
    sys_clock,
    usb_uart_rxd,
    usb_uart_txd);
  inout [15:0]GPIOA_tri_io;
  inout [7:0]GPIOB;
  input reset;
  input sys_clock;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire [0:0]GPIOA_tri_i_0;
  wire [1:1]GPIOA_tri_i_1;
  wire [10:10]GPIOA_tri_i_10;
  wire [11:11]GPIOA_tri_i_11;
  wire [12:12]GPIOA_tri_i_12;
  wire [13:13]GPIOA_tri_i_13;
  wire [14:14]GPIOA_tri_i_14;
  wire [15:15]GPIOA_tri_i_15;
  wire [2:2]GPIOA_tri_i_2;
  wire [3:3]GPIOA_tri_i_3;
  wire [4:4]GPIOA_tri_i_4;
  wire [5:5]GPIOA_tri_i_5;
  wire [6:6]GPIOA_tri_i_6;
  wire [7:7]GPIOA_tri_i_7;
  wire [8:8]GPIOA_tri_i_8;
  wire [9:9]GPIOA_tri_i_9;
  wire [0:0]GPIOA_tri_io_0;
  wire [1:1]GPIOA_tri_io_1;
  wire [10:10]GPIOA_tri_io_10;
  wire [11:11]GPIOA_tri_io_11;
  wire [12:12]GPIOA_tri_io_12;
  wire [13:13]GPIOA_tri_io_13;
  wire [14:14]GPIOA_tri_io_14;
  wire [15:15]GPIOA_tri_io_15;
  wire [2:2]GPIOA_tri_io_2;
  wire [3:3]GPIOA_tri_io_3;
  wire [4:4]GPIOA_tri_io_4;
  wire [5:5]GPIOA_tri_io_5;
  wire [6:6]GPIOA_tri_io_6;
  wire [7:7]GPIOA_tri_io_7;
  wire [8:8]GPIOA_tri_io_8;
  wire [9:9]GPIOA_tri_io_9;
  wire [0:0]GPIOA_tri_o_0;
  wire [1:1]GPIOA_tri_o_1;
  wire [10:10]GPIOA_tri_o_10;
  wire [11:11]GPIOA_tri_o_11;
  wire [12:12]GPIOA_tri_o_12;
  wire [13:13]GPIOA_tri_o_13;
  wire [14:14]GPIOA_tri_o_14;
  wire [15:15]GPIOA_tri_o_15;
  wire [2:2]GPIOA_tri_o_2;
  wire [3:3]GPIOA_tri_o_3;
  wire [4:4]GPIOA_tri_o_4;
  wire [5:5]GPIOA_tri_o_5;
  wire [6:6]GPIOA_tri_o_6;
  wire [7:7]GPIOA_tri_o_7;
  wire [8:8]GPIOA_tri_o_8;
  wire [9:9]GPIOA_tri_o_9;
  wire [0:0]GPIOA_tri_t_0;
  wire [1:1]GPIOA_tri_t_1;
  wire [10:10]GPIOA_tri_t_10;
  wire [11:11]GPIOA_tri_t_11;
  wire [12:12]GPIOA_tri_t_12;
  wire [13:13]GPIOA_tri_t_13;
  wire [14:14]GPIOA_tri_t_14;
  wire [15:15]GPIOA_tri_t_15;
  wire [2:2]GPIOA_tri_t_2;
  wire [3:3]GPIOA_tri_t_3;
  wire [4:4]GPIOA_tri_t_4;
  wire [5:5]GPIOA_tri_t_5;
  wire [6:6]GPIOA_tri_t_6;
  wire [7:7]GPIOA_tri_t_7;
  wire [8:8]GPIOA_tri_t_8;
  wire [9:9]GPIOA_tri_t_9;
  wire [7:0]GPIOB;
  wire reset;
  wire sys_clock;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  IOBUF GPIOA_tri_iobuf_0
       (.I(GPIOA_tri_o_0),
        .IO(GPIOA_tri_io[0]),
        .O(GPIOA_tri_i_0),
        .T(GPIOA_tri_t_0));
  IOBUF GPIOA_tri_iobuf_1
       (.I(GPIOA_tri_o_1),
        .IO(GPIOA_tri_io[1]),
        .O(GPIOA_tri_i_1),
        .T(GPIOA_tri_t_1));
  IOBUF GPIOA_tri_iobuf_10
       (.I(GPIOA_tri_o_10),
        .IO(GPIOA_tri_io[10]),
        .O(GPIOA_tri_i_10),
        .T(GPIOA_tri_t_10));
  IOBUF GPIOA_tri_iobuf_11
       (.I(GPIOA_tri_o_11),
        .IO(GPIOA_tri_io[11]),
        .O(GPIOA_tri_i_11),
        .T(GPIOA_tri_t_11));
  IOBUF GPIOA_tri_iobuf_12
       (.I(GPIOA_tri_o_12),
        .IO(GPIOA_tri_io[12]),
        .O(GPIOA_tri_i_12),
        .T(GPIOA_tri_t_12));
  IOBUF GPIOA_tri_iobuf_13
       (.I(GPIOA_tri_o_13),
        .IO(GPIOA_tri_io[13]),
        .O(GPIOA_tri_i_13),
        .T(GPIOA_tri_t_13));
  IOBUF GPIOA_tri_iobuf_14
       (.I(GPIOA_tri_o_14),
        .IO(GPIOA_tri_io[14]),
        .O(GPIOA_tri_i_14),
        .T(GPIOA_tri_t_14));
  IOBUF GPIOA_tri_iobuf_15
       (.I(GPIOA_tri_o_15),
        .IO(GPIOA_tri_io[15]),
        .O(GPIOA_tri_i_15),
        .T(GPIOA_tri_t_15));
  IOBUF GPIOA_tri_iobuf_2
       (.I(GPIOA_tri_o_2),
        .IO(GPIOA_tri_io[2]),
        .O(GPIOA_tri_i_2),
        .T(GPIOA_tri_t_2));
  IOBUF GPIOA_tri_iobuf_3
       (.I(GPIOA_tri_o_3),
        .IO(GPIOA_tri_io[3]),
        .O(GPIOA_tri_i_3),
        .T(GPIOA_tri_t_3));
  IOBUF GPIOA_tri_iobuf_4
       (.I(GPIOA_tri_o_4),
        .IO(GPIOA_tri_io[4]),
        .O(GPIOA_tri_i_4),
        .T(GPIOA_tri_t_4));
  IOBUF GPIOA_tri_iobuf_5
       (.I(GPIOA_tri_o_5),
        .IO(GPIOA_tri_io[5]),
        .O(GPIOA_tri_i_5),
        .T(GPIOA_tri_t_5));
  IOBUF GPIOA_tri_iobuf_6
       (.I(GPIOA_tri_o_6),
        .IO(GPIOA_tri_io[6]),
        .O(GPIOA_tri_i_6),
        .T(GPIOA_tri_t_6));
  IOBUF GPIOA_tri_iobuf_7
       (.I(GPIOA_tri_o_7),
        .IO(GPIOA_tri_io[7]),
        .O(GPIOA_tri_i_7),
        .T(GPIOA_tri_t_7));
  IOBUF GPIOA_tri_iobuf_8
       (.I(GPIOA_tri_o_8),
        .IO(GPIOA_tri_io[8]),
        .O(GPIOA_tri_i_8),
        .T(GPIOA_tri_t_8));
  IOBUF GPIOA_tri_iobuf_9
       (.I(GPIOA_tri_o_9),
        .IO(GPIOA_tri_io[9]),
        .O(GPIOA_tri_i_9),
        .T(GPIOA_tri_t_9));
  design_1 design_1_i
       (.GPIOA_tri_i({GPIOA_tri_i_15,GPIOA_tri_i_14,GPIOA_tri_i_13,GPIOA_tri_i_12,GPIOA_tri_i_11,GPIOA_tri_i_10,GPIOA_tri_i_9,GPIOA_tri_i_8,GPIOA_tri_i_7,GPIOA_tri_i_6,GPIOA_tri_i_5,GPIOA_tri_i_4,GPIOA_tri_i_3,GPIOA_tri_i_2,GPIOA_tri_i_1,GPIOA_tri_i_0}),
        .GPIOA_tri_o({GPIOA_tri_o_15,GPIOA_tri_o_14,GPIOA_tri_o_13,GPIOA_tri_o_12,GPIOA_tri_o_11,GPIOA_tri_o_10,GPIOA_tri_o_9,GPIOA_tri_o_8,GPIOA_tri_o_7,GPIOA_tri_o_6,GPIOA_tri_o_5,GPIOA_tri_o_4,GPIOA_tri_o_3,GPIOA_tri_o_2,GPIOA_tri_o_1,GPIOA_tri_o_0}),
        .GPIOA_tri_t({GPIOA_tri_t_15,GPIOA_tri_t_14,GPIOA_tri_t_13,GPIOA_tri_t_12,GPIOA_tri_t_11,GPIOA_tri_t_10,GPIOA_tri_t_9,GPIOA_tri_t_8,GPIOA_tri_t_7,GPIOA_tri_t_6,GPIOA_tri_t_5,GPIOA_tri_t_4,GPIOA_tri_t_3,GPIOA_tri_t_2,GPIOA_tri_t_1,GPIOA_tri_t_0}),
        .GPIOB(GPIOB),
        .reset(reset),
        .sys_clock(sys_clock),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
endmodule
