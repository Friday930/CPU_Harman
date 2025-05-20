// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Tue May 20 16:09:44 2025
// Host        : DESKTOP-7CFQ9ND running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_mySPI_Peripheral_0_2_sim_netlist.v
// Design      : design_1_mySPI_Peripheral_0_2
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_SPI_Master
   (MISO_0,
    \temp_rx_data_reg_reg[0]_P_0 ,
    \temp_rx_data_reg_reg[0]_C_0 ,
    Q,
    D,
    SCLK,
    \axi_araddr_reg[2] ,
    \axi_araddr_reg[2]_0 ,
    \axi_araddr_reg[2]_1 ,
    \axi_araddr_reg[2]_2 ,
    \axi_araddr_reg[2]_3 ,
    \axi_araddr_reg[2]_4 ,
    MOSI,
    clk,
    MISO,
    rst,
    SCLK_0,
    \axi_rdata_reg[1] ,
    \axi_rdata_reg[1]_0 ,
    axi_araddr,
    \temp_tx_data_reg_reg[0]_0 ,
    \temp_tx_data_reg_reg[7]_0 );
  output MISO_0;
  output \temp_rx_data_reg_reg[0]_P_0 ;
  output \temp_rx_data_reg_reg[0]_C_0 ;
  output [1:0]Q;
  output [0:0]D;
  output SCLK;
  output \axi_araddr_reg[2] ;
  output \axi_araddr_reg[2]_0 ;
  output \axi_araddr_reg[2]_1 ;
  output \axi_araddr_reg[2]_2 ;
  output \axi_araddr_reg[2]_3 ;
  output \axi_araddr_reg[2]_4 ;
  output MOSI;
  input clk;
  input MISO;
  input rst;
  input [2:0]SCLK_0;
  input \axi_rdata_reg[1] ;
  input \axi_rdata_reg[1]_0 ;
  input [1:0]axi_araddr;
  input [0:0]\temp_tx_data_reg_reg[0]_0 ;
  input [6:0]\temp_tx_data_reg_reg[7]_0 ;

  wire [0:0]D;
  wire MISO;
  wire MISO_0;
  wire MOSI;
  wire [1:0]Q;
  wire SCLK;
  wire [2:0]SCLK_0;
  wire SCLK_INST_0_i_1_n_0;
  wire SCLK_INST_0_i_2_n_0;
  wire [1:0]axi_araddr;
  wire \axi_araddr_reg[2] ;
  wire \axi_araddr_reg[2]_0 ;
  wire \axi_araddr_reg[2]_1 ;
  wire \axi_araddr_reg[2]_2 ;
  wire \axi_araddr_reg[2]_3 ;
  wire \axi_araddr_reg[2]_4 ;
  wire \axi_rdata[1]_i_3_n_0 ;
  wire \axi_rdata[1]_i_5_n_0 ;
  wire \axi_rdata_reg[1] ;
  wire \axi_rdata_reg[1]_0 ;
  wire [1:1]bit_counter_next;
  wire [2:0]bit_counter_reg;
  wire \bit_counter_reg[0]_i_1_n_0 ;
  wire \bit_counter_reg[1]_i_1_n_0 ;
  wire \bit_counter_reg[1]_i_3_n_0 ;
  wire \bit_counter_reg[2]_i_1_n_0 ;
  wire \bit_counter_reg[2]_i_2_n_0 ;
  wire clk;
  wire [1:0]next__0;
  wire rst;
  wire [5:0]sclk_counter_next;
  wire [5:0]sclk_counter_reg;
  wire \sclk_counter_reg[4]_i_2_n_0 ;
  wire \sclk_counter_reg[5]_i_1_n_0 ;
  wire \sclk_counter_reg[5]_i_3_n_0 ;
  wire \sclk_counter_reg[5]_i_4_n_0 ;
  wire \sclk_counter_reg[5]_i_5_n_0 ;
  wire \temp_rx_data_reg[0]_C_i_1_n_0 ;
  wire \temp_rx_data_reg[1]_C_i_1_n_0 ;
  wire \temp_rx_data_reg[2]_C_i_1_n_0 ;
  wire \temp_rx_data_reg[3]_C_i_1_n_0 ;
  wire \temp_rx_data_reg[4]_C_i_1_n_0 ;
  wire \temp_rx_data_reg[5]_C_i_1_n_0 ;
  wire \temp_rx_data_reg[6]_C_i_1_n_0 ;
  wire \temp_rx_data_reg[7]_C_i_1_n_0 ;
  wire \temp_rx_data_reg[7]_P_i_1_n_0 ;
  wire \temp_rx_data_reg_reg[0]_C_0 ;
  wire \temp_rx_data_reg_reg[0]_LDC_i_1_n_0 ;
  wire \temp_rx_data_reg_reg[0]_LDC_i_2_n_0 ;
  wire \temp_rx_data_reg_reg[0]_P_0 ;
  wire \temp_rx_data_reg_reg[1]_C_n_0 ;
  wire \temp_rx_data_reg_reg[1]_LDC_i_1_n_0 ;
  wire \temp_rx_data_reg_reg[1]_LDC_i_2_n_0 ;
  wire \temp_rx_data_reg_reg[1]_LDC_n_0 ;
  wire \temp_rx_data_reg_reg[1]_P_n_0 ;
  wire \temp_rx_data_reg_reg[2]_C_n_0 ;
  wire \temp_rx_data_reg_reg[2]_LDC_i_1_n_0 ;
  wire \temp_rx_data_reg_reg[2]_LDC_i_2_n_0 ;
  wire \temp_rx_data_reg_reg[2]_LDC_n_0 ;
  wire \temp_rx_data_reg_reg[2]_P_n_0 ;
  wire \temp_rx_data_reg_reg[3]_C_n_0 ;
  wire \temp_rx_data_reg_reg[3]_LDC_i_1_n_0 ;
  wire \temp_rx_data_reg_reg[3]_LDC_i_2_n_0 ;
  wire \temp_rx_data_reg_reg[3]_LDC_n_0 ;
  wire \temp_rx_data_reg_reg[3]_P_n_0 ;
  wire \temp_rx_data_reg_reg[4]_C_n_0 ;
  wire \temp_rx_data_reg_reg[4]_LDC_i_1_n_0 ;
  wire \temp_rx_data_reg_reg[4]_LDC_i_2_n_0 ;
  wire \temp_rx_data_reg_reg[4]_LDC_n_0 ;
  wire \temp_rx_data_reg_reg[4]_P_n_0 ;
  wire \temp_rx_data_reg_reg[5]_C_n_0 ;
  wire \temp_rx_data_reg_reg[5]_LDC_i_1_n_0 ;
  wire \temp_rx_data_reg_reg[5]_LDC_i_2_n_0 ;
  wire \temp_rx_data_reg_reg[5]_LDC_n_0 ;
  wire \temp_rx_data_reg_reg[5]_P_n_0 ;
  wire \temp_rx_data_reg_reg[6]_C_n_0 ;
  wire \temp_rx_data_reg_reg[6]_LDC_i_1_n_0 ;
  wire \temp_rx_data_reg_reg[6]_LDC_i_2_n_0 ;
  wire \temp_rx_data_reg_reg[6]_LDC_n_0 ;
  wire \temp_rx_data_reg_reg[6]_P_n_0 ;
  wire \temp_rx_data_reg_reg[7]_C_n_0 ;
  wire \temp_rx_data_reg_reg[7]_LDC_i_1_n_0 ;
  wire \temp_rx_data_reg_reg[7]_LDC_i_2_n_0 ;
  wire \temp_rx_data_reg_reg[7]_LDC_n_0 ;
  wire \temp_rx_data_reg_reg[7]_P_n_0 ;
  wire [7:1]temp_tx_data_next;
  wire [6:0]temp_tx_data_reg;
  wire \temp_tx_data_reg[7]_i_1_n_0 ;
  wire [0:0]\temp_tx_data_reg_reg[0]_0 ;
  wire [6:0]\temp_tx_data_reg_reg[7]_0 ;

  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'hFF0008F8)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(SCLK_0[1]),
        .I1(SCLK_0[0]),
        .I2(Q[1]),
        .I3(SCLK_INST_0_i_1_n_0),
        .I4(Q[0]),
        .O(next__0[0]));
  LUT6 #(
    .INIT(64'hFBFBFBFB40407340)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(SCLK_INST_0_i_1_n_0),
        .I1(Q[0]),
        .I2(SCLK_INST_0_i_2_n_0),
        .I3(SCLK_0[0]),
        .I4(SCLK_0[1]),
        .I5(Q[1]),
        .O(next__0[1]));
  (* FSM_ENCODED_STATES = "CP_DELAY:01,CP1:11,CP0:10,IDLE:00" *) 
  FDCE \FSM_sequential_state_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(next__0[0]),
        .Q(Q[0]));
  (* FSM_ENCODED_STATES = "CP_DELAY:01,CP1:11,CP0:10,IDLE:00" *) 
  FDCE \FSM_sequential_state_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(next__0[1]),
        .Q(Q[1]));
  LUT6 #(
    .INIT(64'h969A69AAA6AA69AA)) 
    SCLK_INST_0
       (.I0(SCLK_0[2]),
        .I1(SCLK_INST_0_i_1_n_0),
        .I2(SCLK_0[1]),
        .I3(Q[1]),
        .I4(Q[0]),
        .I5(SCLK_INST_0_i_2_n_0),
        .O(SCLK));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFF7FF)) 
    SCLK_INST_0_i_1
       (.I0(sclk_counter_reg[0]),
        .I1(sclk_counter_reg[4]),
        .I2(sclk_counter_reg[3]),
        .I3(sclk_counter_reg[5]),
        .I4(sclk_counter_reg[2]),
        .I5(sclk_counter_reg[1]),
        .O(SCLK_INST_0_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    SCLK_INST_0_i_2
       (.I0(bit_counter_reg[2]),
        .I1(bit_counter_reg[0]),
        .I2(bit_counter_reg[1]),
        .I3(Q[1]),
        .O(SCLK_INST_0_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFAEAA)) 
    \axi_rdata[1]_i_1 
       (.I0(\axi_rdata_reg[1] ),
        .I1(Q[0]),
        .I2(SCLK_INST_0_i_1_n_0),
        .I3(\axi_rdata[1]_i_3_n_0 ),
        .I4(\axi_rdata_reg[1]_0 ),
        .I5(\axi_rdata[1]_i_5_n_0 ),
        .O(D));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \axi_rdata[1]_i_3 
       (.I0(axi_araddr[1]),
        .I1(axi_araddr[0]),
        .I2(Q[1]),
        .I3(bit_counter_reg[1]),
        .I4(bit_counter_reg[0]),
        .I5(bit_counter_reg[2]),
        .O(\axi_rdata[1]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h44400040)) 
    \axi_rdata[1]_i_5 
       (.I0(axi_araddr[0]),
        .I1(axi_araddr[1]),
        .I2(\temp_rx_data_reg_reg[1]_C_n_0 ),
        .I3(\temp_rx_data_reg_reg[1]_LDC_n_0 ),
        .I4(\temp_rx_data_reg_reg[1]_P_n_0 ),
        .O(\axi_rdata[1]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h44400040)) 
    \axi_rdata[2]_i_2 
       (.I0(axi_araddr[0]),
        .I1(axi_araddr[1]),
        .I2(\temp_rx_data_reg_reg[2]_C_n_0 ),
        .I3(\temp_rx_data_reg_reg[2]_LDC_n_0 ),
        .I4(\temp_rx_data_reg_reg[2]_P_n_0 ),
        .O(\axi_araddr_reg[2] ));
  LUT5 #(
    .INIT(32'h44400040)) 
    \axi_rdata[3]_i_2 
       (.I0(axi_araddr[0]),
        .I1(axi_araddr[1]),
        .I2(\temp_rx_data_reg_reg[3]_C_n_0 ),
        .I3(\temp_rx_data_reg_reg[3]_LDC_n_0 ),
        .I4(\temp_rx_data_reg_reg[3]_P_n_0 ),
        .O(\axi_araddr_reg[2]_0 ));
  LUT5 #(
    .INIT(32'h44400040)) 
    \axi_rdata[4]_i_2 
       (.I0(axi_araddr[0]),
        .I1(axi_araddr[1]),
        .I2(\temp_rx_data_reg_reg[4]_C_n_0 ),
        .I3(\temp_rx_data_reg_reg[4]_LDC_n_0 ),
        .I4(\temp_rx_data_reg_reg[4]_P_n_0 ),
        .O(\axi_araddr_reg[2]_1 ));
  LUT5 #(
    .INIT(32'h44400040)) 
    \axi_rdata[5]_i_2 
       (.I0(axi_araddr[0]),
        .I1(axi_araddr[1]),
        .I2(\temp_rx_data_reg_reg[5]_C_n_0 ),
        .I3(\temp_rx_data_reg_reg[5]_LDC_n_0 ),
        .I4(\temp_rx_data_reg_reg[5]_P_n_0 ),
        .O(\axi_araddr_reg[2]_2 ));
  LUT5 #(
    .INIT(32'h44400040)) 
    \axi_rdata[6]_i_2 
       (.I0(axi_araddr[0]),
        .I1(axi_araddr[1]),
        .I2(\temp_rx_data_reg_reg[6]_C_n_0 ),
        .I3(\temp_rx_data_reg_reg[6]_LDC_n_0 ),
        .I4(\temp_rx_data_reg_reg[6]_P_n_0 ),
        .O(\axi_araddr_reg[2]_3 ));
  LUT5 #(
    .INIT(32'h44400040)) 
    \axi_rdata[7]_i_2 
       (.I0(axi_araddr[0]),
        .I1(axi_araddr[1]),
        .I2(\temp_rx_data_reg_reg[7]_C_n_0 ),
        .I3(\temp_rx_data_reg_reg[7]_LDC_n_0 ),
        .I4(\temp_rx_data_reg_reg[7]_P_n_0 ),
        .O(\axi_araddr_reg[2]_4 ));
  LUT6 #(
    .INIT(64'hBFB0BFBF40004000)) 
    \bit_counter_reg[0]_i_1 
       (.I0(SCLK_INST_0_i_1_n_0),
        .I1(\sclk_counter_reg[5]_i_3_n_0 ),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(SCLK_0[0]),
        .I5(bit_counter_reg[0]),
        .O(\bit_counter_reg[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAFBFFAAAA0800)) 
    \bit_counter_reg[1]_i_1 
       (.I0(bit_counter_next),
        .I1(Q[0]),
        .I2(SCLK_INST_0_i_1_n_0),
        .I3(\sclk_counter_reg[5]_i_3_n_0 ),
        .I4(\bit_counter_reg[1]_i_3_n_0 ),
        .I5(bit_counter_reg[1]),
        .O(\bit_counter_reg[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h28)) 
    \bit_counter_reg[1]_i_2 
       (.I0(Q[1]),
        .I1(bit_counter_reg[1]),
        .I2(bit_counter_reg[0]),
        .O(bit_counter_next));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \bit_counter_reg[1]_i_3 
       (.I0(SCLK_0[0]),
        .I1(Q[1]),
        .I2(Q[0]),
        .O(\bit_counter_reg[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCDCCCC00CDCCCCCC)) 
    \bit_counter_reg[2]_i_1 
       (.I0(SCLK_INST_0_i_1_n_0),
        .I1(bit_counter_reg[2]),
        .I2(\bit_counter_reg[2]_i_2_n_0 ),
        .I3(Q[0]),
        .I4(Q[1]),
        .I5(SCLK_0[0]),
        .O(\bit_counter_reg[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \bit_counter_reg[2]_i_2 
       (.I0(bit_counter_reg[0]),
        .I1(bit_counter_reg[1]),
        .O(\bit_counter_reg[2]_i_2_n_0 ));
  FDCE \bit_counter_reg_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\bit_counter_reg[0]_i_1_n_0 ),
        .Q(bit_counter_reg[0]));
  FDCE \bit_counter_reg_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\bit_counter_reg[1]_i_1_n_0 ),
        .Q(bit_counter_reg[1]));
  FDCE \bit_counter_reg_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\bit_counter_reg[2]_i_1_n_0 ),
        .Q(bit_counter_reg[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sclk_counter_reg[0]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(sclk_counter_reg[0]),
        .O(sclk_counter_next[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h66600000)) 
    \sclk_counter_reg[1]_i_1 
       (.I0(sclk_counter_reg[0]),
        .I1(sclk_counter_reg[1]),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(SCLK_INST_0_i_1_n_0),
        .O(sclk_counter_next[1]));
  LUT6 #(
    .INIT(64'h7878780000000000)) 
    \sclk_counter_reg[2]_i_1 
       (.I0(sclk_counter_reg[1]),
        .I1(sclk_counter_reg[0]),
        .I2(sclk_counter_reg[2]),
        .I3(Q[0]),
        .I4(Q[1]),
        .I5(SCLK_INST_0_i_1_n_0),
        .O(sclk_counter_next[2]));
  LUT6 #(
    .INIT(64'h7F80000000000000)) 
    \sclk_counter_reg[3]_i_1 
       (.I0(sclk_counter_reg[0]),
        .I1(sclk_counter_reg[1]),
        .I2(sclk_counter_reg[2]),
        .I3(sclk_counter_reg[3]),
        .I4(\sclk_counter_reg[5]_i_4_n_0 ),
        .I5(SCLK_INST_0_i_1_n_0),
        .O(sclk_counter_next[3]));
  LUT6 #(
    .INIT(64'h7F80000000000000)) 
    \sclk_counter_reg[4]_i_1 
       (.I0(\sclk_counter_reg[4]_i_2_n_0 ),
        .I1(sclk_counter_reg[0]),
        .I2(sclk_counter_reg[1]),
        .I3(sclk_counter_reg[4]),
        .I4(\sclk_counter_reg[5]_i_4_n_0 ),
        .I5(SCLK_INST_0_i_1_n_0),
        .O(sclk_counter_next[4]));
  LUT2 #(
    .INIT(4'h8)) 
    \sclk_counter_reg[4]_i_2 
       (.I0(sclk_counter_reg[2]),
        .I1(sclk_counter_reg[3]),
        .O(\sclk_counter_reg[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hEEFFFFFC)) 
    \sclk_counter_reg[5]_i_1 
       (.I0(SCLK_INST_0_i_1_n_0),
        .I1(\sclk_counter_reg[5]_i_3_n_0 ),
        .I2(SCLK_0[0]),
        .I3(Q[1]),
        .I4(Q[0]),
        .O(\sclk_counter_reg[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAA00AA002A80A800)) 
    \sclk_counter_reg[5]_i_2 
       (.I0(\sclk_counter_reg[5]_i_4_n_0 ),
        .I1(sclk_counter_reg[1]),
        .I2(sclk_counter_reg[2]),
        .I3(sclk_counter_reg[5]),
        .I4(sclk_counter_reg[3]),
        .I5(\sclk_counter_reg[5]_i_5_n_0 ),
        .O(sclk_counter_next[5]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h7F00)) 
    \sclk_counter_reg[5]_i_3 
       (.I0(bit_counter_reg[2]),
        .I1(bit_counter_reg[0]),
        .I2(bit_counter_reg[1]),
        .I3(Q[1]),
        .O(\sclk_counter_reg[5]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \sclk_counter_reg[5]_i_4 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(\sclk_counter_reg[5]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \sclk_counter_reg[5]_i_5 
       (.I0(sclk_counter_reg[0]),
        .I1(sclk_counter_reg[4]),
        .O(\sclk_counter_reg[5]_i_5_n_0 ));
  FDCE \sclk_counter_reg_reg[0] 
       (.C(clk),
        .CE(\sclk_counter_reg[5]_i_1_n_0 ),
        .CLR(rst),
        .D(sclk_counter_next[0]),
        .Q(sclk_counter_reg[0]));
  FDCE \sclk_counter_reg_reg[1] 
       (.C(clk),
        .CE(\sclk_counter_reg[5]_i_1_n_0 ),
        .CLR(rst),
        .D(sclk_counter_next[1]),
        .Q(sclk_counter_reg[1]));
  FDCE \sclk_counter_reg_reg[2] 
       (.C(clk),
        .CE(\sclk_counter_reg[5]_i_1_n_0 ),
        .CLR(rst),
        .D(sclk_counter_next[2]),
        .Q(sclk_counter_reg[2]));
  FDCE \sclk_counter_reg_reg[3] 
       (.C(clk),
        .CE(\sclk_counter_reg[5]_i_1_n_0 ),
        .CLR(rst),
        .D(sclk_counter_next[3]),
        .Q(sclk_counter_reg[3]));
  FDCE \sclk_counter_reg_reg[4] 
       (.C(clk),
        .CE(\sclk_counter_reg[5]_i_1_n_0 ),
        .CLR(rst),
        .D(sclk_counter_next[4]),
        .Q(sclk_counter_reg[4]));
  FDCE \sclk_counter_reg_reg[5] 
       (.C(clk),
        .CE(\sclk_counter_reg[5]_i_1_n_0 ),
        .CLR(rst),
        .D(sclk_counter_next[5]),
        .Q(sclk_counter_reg[5]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \temp_rx_data_reg[0]_C_i_1 
       (.I0(MISO),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(SCLK_INST_0_i_1_n_0),
        .I4(\temp_rx_data_reg_reg[0]_C_0 ),
        .O(\temp_rx_data_reg[0]_C_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \temp_rx_data_reg[1]_C_i_1 
       (.I0(temp_tx_data_reg[0]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(SCLK_INST_0_i_1_n_0),
        .I4(\temp_rx_data_reg_reg[1]_C_n_0 ),
        .O(\temp_rx_data_reg[1]_C_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \temp_rx_data_reg[2]_C_i_1 
       (.I0(temp_tx_data_reg[1]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(SCLK_INST_0_i_1_n_0),
        .I4(\temp_rx_data_reg_reg[2]_C_n_0 ),
        .O(\temp_rx_data_reg[2]_C_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \temp_rx_data_reg[3]_C_i_1 
       (.I0(temp_tx_data_reg[2]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(SCLK_INST_0_i_1_n_0),
        .I4(\temp_rx_data_reg_reg[3]_C_n_0 ),
        .O(\temp_rx_data_reg[3]_C_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \temp_rx_data_reg[4]_C_i_1 
       (.I0(temp_tx_data_reg[3]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(SCLK_INST_0_i_1_n_0),
        .I4(\temp_rx_data_reg_reg[4]_C_n_0 ),
        .O(\temp_rx_data_reg[4]_C_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \temp_rx_data_reg[5]_C_i_1 
       (.I0(temp_tx_data_reg[4]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(SCLK_INST_0_i_1_n_0),
        .I4(\temp_rx_data_reg_reg[5]_C_n_0 ),
        .O(\temp_rx_data_reg[5]_C_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \temp_rx_data_reg[6]_C_i_1 
       (.I0(temp_tx_data_reg[5]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(SCLK_INST_0_i_1_n_0),
        .I4(\temp_rx_data_reg_reg[6]_C_n_0 ),
        .O(\temp_rx_data_reg[6]_C_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \temp_rx_data_reg[7]_C_i_1 
       (.I0(temp_tx_data_reg[6]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(SCLK_INST_0_i_1_n_0),
        .I4(\temp_rx_data_reg_reg[7]_C_n_0 ),
        .O(\temp_rx_data_reg[7]_C_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h02)) 
    \temp_rx_data_reg[7]_P_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(SCLK_INST_0_i_1_n_0),
        .O(\temp_rx_data_reg[7]_P_i_1_n_0 ));
  FDCE \temp_rx_data_reg_reg[0]_C 
       (.C(clk),
        .CE(1'b1),
        .CLR(\temp_rx_data_reg_reg[0]_LDC_i_2_n_0 ),
        .D(\temp_rx_data_reg[0]_C_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[0]_C_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  LDCE #(
    .INIT(1'b0)) 
    \temp_rx_data_reg_reg[0]_LDC 
       (.CLR(\temp_rx_data_reg_reg[0]_LDC_i_2_n_0 ),
        .D(1'b1),
        .G(\temp_rx_data_reg_reg[0]_LDC_i_1_n_0 ),
        .GE(1'b1),
        .Q(MISO_0));
  LUT5 #(
    .INIT(32'hCCCC08CC)) 
    \temp_rx_data_reg_reg[0]_LDC_i_1 
       (.I0(MISO),
        .I1(rst),
        .I2(SCLK_INST_0_i_1_n_0),
        .I3(Q[1]),
        .I4(Q[0]),
        .O(\temp_rx_data_reg_reg[0]_LDC_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00B00000)) 
    \temp_rx_data_reg_reg[0]_LDC_i_2 
       (.I0(SCLK_INST_0_i_1_n_0),
        .I1(MISO),
        .I2(rst),
        .I3(Q[0]),
        .I4(Q[1]),
        .O(\temp_rx_data_reg_reg[0]_LDC_i_2_n_0 ));
  FDPE \temp_rx_data_reg_reg[0]_P 
       (.C(clk),
        .CE(\temp_rx_data_reg[7]_P_i_1_n_0 ),
        .D(MISO),
        .PRE(\temp_rx_data_reg_reg[0]_LDC_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[0]_P_0 ));
  FDCE \temp_rx_data_reg_reg[1]_C 
       (.C(clk),
        .CE(1'b1),
        .CLR(\temp_rx_data_reg_reg[1]_LDC_i_2_n_0 ),
        .D(\temp_rx_data_reg[1]_C_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[1]_C_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  LDCE #(
    .INIT(1'b0)) 
    \temp_rx_data_reg_reg[1]_LDC 
       (.CLR(\temp_rx_data_reg_reg[1]_LDC_i_2_n_0 ),
        .D(1'b1),
        .G(\temp_rx_data_reg_reg[1]_LDC_i_1_n_0 ),
        .GE(1'b1),
        .Q(\temp_rx_data_reg_reg[1]_LDC_n_0 ));
  LUT5 #(
    .INIT(32'hCCCC08CC)) 
    \temp_rx_data_reg_reg[1]_LDC_i_1 
       (.I0(temp_tx_data_reg[0]),
        .I1(rst),
        .I2(SCLK_INST_0_i_1_n_0),
        .I3(Q[1]),
        .I4(Q[0]),
        .O(\temp_rx_data_reg_reg[1]_LDC_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00B00000)) 
    \temp_rx_data_reg_reg[1]_LDC_i_2 
       (.I0(SCLK_INST_0_i_1_n_0),
        .I1(temp_tx_data_reg[0]),
        .I2(rst),
        .I3(Q[0]),
        .I4(Q[1]),
        .O(\temp_rx_data_reg_reg[1]_LDC_i_2_n_0 ));
  FDPE \temp_rx_data_reg_reg[1]_P 
       (.C(clk),
        .CE(\temp_rx_data_reg[7]_P_i_1_n_0 ),
        .D(temp_tx_data_reg[0]),
        .PRE(\temp_rx_data_reg_reg[1]_LDC_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[1]_P_n_0 ));
  FDCE \temp_rx_data_reg_reg[2]_C 
       (.C(clk),
        .CE(1'b1),
        .CLR(\temp_rx_data_reg_reg[2]_LDC_i_2_n_0 ),
        .D(\temp_rx_data_reg[2]_C_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[2]_C_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  LDCE #(
    .INIT(1'b0)) 
    \temp_rx_data_reg_reg[2]_LDC 
       (.CLR(\temp_rx_data_reg_reg[2]_LDC_i_2_n_0 ),
        .D(1'b1),
        .G(\temp_rx_data_reg_reg[2]_LDC_i_1_n_0 ),
        .GE(1'b1),
        .Q(\temp_rx_data_reg_reg[2]_LDC_n_0 ));
  LUT5 #(
    .INIT(32'hCCCC08CC)) 
    \temp_rx_data_reg_reg[2]_LDC_i_1 
       (.I0(temp_tx_data_reg[1]),
        .I1(rst),
        .I2(SCLK_INST_0_i_1_n_0),
        .I3(Q[1]),
        .I4(Q[0]),
        .O(\temp_rx_data_reg_reg[2]_LDC_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00B00000)) 
    \temp_rx_data_reg_reg[2]_LDC_i_2 
       (.I0(SCLK_INST_0_i_1_n_0),
        .I1(temp_tx_data_reg[1]),
        .I2(rst),
        .I3(Q[0]),
        .I4(Q[1]),
        .O(\temp_rx_data_reg_reg[2]_LDC_i_2_n_0 ));
  FDPE \temp_rx_data_reg_reg[2]_P 
       (.C(clk),
        .CE(\temp_rx_data_reg[7]_P_i_1_n_0 ),
        .D(temp_tx_data_reg[1]),
        .PRE(\temp_rx_data_reg_reg[2]_LDC_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[2]_P_n_0 ));
  FDCE \temp_rx_data_reg_reg[3]_C 
       (.C(clk),
        .CE(1'b1),
        .CLR(\temp_rx_data_reg_reg[3]_LDC_i_2_n_0 ),
        .D(\temp_rx_data_reg[3]_C_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[3]_C_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  LDCE #(
    .INIT(1'b0)) 
    \temp_rx_data_reg_reg[3]_LDC 
       (.CLR(\temp_rx_data_reg_reg[3]_LDC_i_2_n_0 ),
        .D(1'b1),
        .G(\temp_rx_data_reg_reg[3]_LDC_i_1_n_0 ),
        .GE(1'b1),
        .Q(\temp_rx_data_reg_reg[3]_LDC_n_0 ));
  LUT5 #(
    .INIT(32'hCCCC08CC)) 
    \temp_rx_data_reg_reg[3]_LDC_i_1 
       (.I0(temp_tx_data_reg[2]),
        .I1(rst),
        .I2(SCLK_INST_0_i_1_n_0),
        .I3(Q[1]),
        .I4(Q[0]),
        .O(\temp_rx_data_reg_reg[3]_LDC_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00B00000)) 
    \temp_rx_data_reg_reg[3]_LDC_i_2 
       (.I0(SCLK_INST_0_i_1_n_0),
        .I1(temp_tx_data_reg[2]),
        .I2(rst),
        .I3(Q[0]),
        .I4(Q[1]),
        .O(\temp_rx_data_reg_reg[3]_LDC_i_2_n_0 ));
  FDPE \temp_rx_data_reg_reg[3]_P 
       (.C(clk),
        .CE(\temp_rx_data_reg[7]_P_i_1_n_0 ),
        .D(temp_tx_data_reg[2]),
        .PRE(\temp_rx_data_reg_reg[3]_LDC_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[3]_P_n_0 ));
  FDCE \temp_rx_data_reg_reg[4]_C 
       (.C(clk),
        .CE(1'b1),
        .CLR(\temp_rx_data_reg_reg[4]_LDC_i_2_n_0 ),
        .D(\temp_rx_data_reg[4]_C_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[4]_C_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  LDCE #(
    .INIT(1'b0)) 
    \temp_rx_data_reg_reg[4]_LDC 
       (.CLR(\temp_rx_data_reg_reg[4]_LDC_i_2_n_0 ),
        .D(1'b1),
        .G(\temp_rx_data_reg_reg[4]_LDC_i_1_n_0 ),
        .GE(1'b1),
        .Q(\temp_rx_data_reg_reg[4]_LDC_n_0 ));
  LUT5 #(
    .INIT(32'hCCCC08CC)) 
    \temp_rx_data_reg_reg[4]_LDC_i_1 
       (.I0(temp_tx_data_reg[3]),
        .I1(rst),
        .I2(SCLK_INST_0_i_1_n_0),
        .I3(Q[1]),
        .I4(Q[0]),
        .O(\temp_rx_data_reg_reg[4]_LDC_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00B00000)) 
    \temp_rx_data_reg_reg[4]_LDC_i_2 
       (.I0(SCLK_INST_0_i_1_n_0),
        .I1(temp_tx_data_reg[3]),
        .I2(rst),
        .I3(Q[0]),
        .I4(Q[1]),
        .O(\temp_rx_data_reg_reg[4]_LDC_i_2_n_0 ));
  FDPE \temp_rx_data_reg_reg[4]_P 
       (.C(clk),
        .CE(\temp_rx_data_reg[7]_P_i_1_n_0 ),
        .D(temp_tx_data_reg[3]),
        .PRE(\temp_rx_data_reg_reg[4]_LDC_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[4]_P_n_0 ));
  FDCE \temp_rx_data_reg_reg[5]_C 
       (.C(clk),
        .CE(1'b1),
        .CLR(\temp_rx_data_reg_reg[5]_LDC_i_2_n_0 ),
        .D(\temp_rx_data_reg[5]_C_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[5]_C_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  LDCE #(
    .INIT(1'b0)) 
    \temp_rx_data_reg_reg[5]_LDC 
       (.CLR(\temp_rx_data_reg_reg[5]_LDC_i_2_n_0 ),
        .D(1'b1),
        .G(\temp_rx_data_reg_reg[5]_LDC_i_1_n_0 ),
        .GE(1'b1),
        .Q(\temp_rx_data_reg_reg[5]_LDC_n_0 ));
  LUT5 #(
    .INIT(32'hCCCC08CC)) 
    \temp_rx_data_reg_reg[5]_LDC_i_1 
       (.I0(temp_tx_data_reg[4]),
        .I1(rst),
        .I2(SCLK_INST_0_i_1_n_0),
        .I3(Q[1]),
        .I4(Q[0]),
        .O(\temp_rx_data_reg_reg[5]_LDC_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00B00000)) 
    \temp_rx_data_reg_reg[5]_LDC_i_2 
       (.I0(SCLK_INST_0_i_1_n_0),
        .I1(temp_tx_data_reg[4]),
        .I2(rst),
        .I3(Q[0]),
        .I4(Q[1]),
        .O(\temp_rx_data_reg_reg[5]_LDC_i_2_n_0 ));
  FDPE \temp_rx_data_reg_reg[5]_P 
       (.C(clk),
        .CE(\temp_rx_data_reg[7]_P_i_1_n_0 ),
        .D(temp_tx_data_reg[4]),
        .PRE(\temp_rx_data_reg_reg[5]_LDC_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[5]_P_n_0 ));
  FDCE \temp_rx_data_reg_reg[6]_C 
       (.C(clk),
        .CE(1'b1),
        .CLR(\temp_rx_data_reg_reg[6]_LDC_i_2_n_0 ),
        .D(\temp_rx_data_reg[6]_C_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[6]_C_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  LDCE #(
    .INIT(1'b0)) 
    \temp_rx_data_reg_reg[6]_LDC 
       (.CLR(\temp_rx_data_reg_reg[6]_LDC_i_2_n_0 ),
        .D(1'b1),
        .G(\temp_rx_data_reg_reg[6]_LDC_i_1_n_0 ),
        .GE(1'b1),
        .Q(\temp_rx_data_reg_reg[6]_LDC_n_0 ));
  LUT5 #(
    .INIT(32'hCCCC08CC)) 
    \temp_rx_data_reg_reg[6]_LDC_i_1 
       (.I0(temp_tx_data_reg[5]),
        .I1(rst),
        .I2(SCLK_INST_0_i_1_n_0),
        .I3(Q[1]),
        .I4(Q[0]),
        .O(\temp_rx_data_reg_reg[6]_LDC_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00B00000)) 
    \temp_rx_data_reg_reg[6]_LDC_i_2 
       (.I0(SCLK_INST_0_i_1_n_0),
        .I1(temp_tx_data_reg[5]),
        .I2(rst),
        .I3(Q[0]),
        .I4(Q[1]),
        .O(\temp_rx_data_reg_reg[6]_LDC_i_2_n_0 ));
  FDPE \temp_rx_data_reg_reg[6]_P 
       (.C(clk),
        .CE(\temp_rx_data_reg[7]_P_i_1_n_0 ),
        .D(temp_tx_data_reg[5]),
        .PRE(\temp_rx_data_reg_reg[6]_LDC_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[6]_P_n_0 ));
  FDCE \temp_rx_data_reg_reg[7]_C 
       (.C(clk),
        .CE(1'b1),
        .CLR(\temp_rx_data_reg_reg[7]_LDC_i_2_n_0 ),
        .D(\temp_rx_data_reg[7]_C_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[7]_C_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  LDCE #(
    .INIT(1'b0)) 
    \temp_rx_data_reg_reg[7]_LDC 
       (.CLR(\temp_rx_data_reg_reg[7]_LDC_i_2_n_0 ),
        .D(1'b1),
        .G(\temp_rx_data_reg_reg[7]_LDC_i_1_n_0 ),
        .GE(1'b1),
        .Q(\temp_rx_data_reg_reg[7]_LDC_n_0 ));
  LUT5 #(
    .INIT(32'hCCCC08CC)) 
    \temp_rx_data_reg_reg[7]_LDC_i_1 
       (.I0(temp_tx_data_reg[6]),
        .I1(rst),
        .I2(SCLK_INST_0_i_1_n_0),
        .I3(Q[1]),
        .I4(Q[0]),
        .O(\temp_rx_data_reg_reg[7]_LDC_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00B00000)) 
    \temp_rx_data_reg_reg[7]_LDC_i_2 
       (.I0(SCLK_INST_0_i_1_n_0),
        .I1(temp_tx_data_reg[6]),
        .I2(rst),
        .I3(Q[0]),
        .I4(Q[1]),
        .O(\temp_rx_data_reg_reg[7]_LDC_i_2_n_0 ));
  FDPE \temp_rx_data_reg_reg[7]_P 
       (.C(clk),
        .CE(\temp_rx_data_reg[7]_P_i_1_n_0 ),
        .D(temp_tx_data_reg[6]),
        .PRE(\temp_rx_data_reg_reg[7]_LDC_i_1_n_0 ),
        .Q(\temp_rx_data_reg_reg[7]_P_n_0 ));
  LUT4 #(
    .INIT(16'hAAC0)) 
    \temp_tx_data_reg[1]_i_1 
       (.I0(temp_tx_data_reg[0]),
        .I1(\temp_tx_data_reg_reg[7]_0 [0]),
        .I2(SCLK_0[0]),
        .I3(Q[1]),
        .O(temp_tx_data_next[1]));
  LUT4 #(
    .INIT(16'hAAC0)) 
    \temp_tx_data_reg[2]_i_1 
       (.I0(temp_tx_data_reg[1]),
        .I1(\temp_tx_data_reg_reg[7]_0 [1]),
        .I2(SCLK_0[0]),
        .I3(Q[1]),
        .O(temp_tx_data_next[2]));
  LUT4 #(
    .INIT(16'hAAC0)) 
    \temp_tx_data_reg[3]_i_1 
       (.I0(temp_tx_data_reg[2]),
        .I1(\temp_tx_data_reg_reg[7]_0 [2]),
        .I2(SCLK_0[0]),
        .I3(Q[1]),
        .O(temp_tx_data_next[3]));
  LUT4 #(
    .INIT(16'hAAC0)) 
    \temp_tx_data_reg[4]_i_1 
       (.I0(temp_tx_data_reg[3]),
        .I1(\temp_tx_data_reg_reg[7]_0 [3]),
        .I2(SCLK_0[0]),
        .I3(Q[1]),
        .O(temp_tx_data_next[4]));
  LUT4 #(
    .INIT(16'hAAC0)) 
    \temp_tx_data_reg[5]_i_1 
       (.I0(temp_tx_data_reg[4]),
        .I1(\temp_tx_data_reg_reg[7]_0 [4]),
        .I2(SCLK_0[0]),
        .I3(Q[1]),
        .O(temp_tx_data_next[5]));
  LUT4 #(
    .INIT(16'hAAC0)) 
    \temp_tx_data_reg[6]_i_1 
       (.I0(temp_tx_data_reg[5]),
        .I1(\temp_tx_data_reg_reg[7]_0 [5]),
        .I2(SCLK_0[0]),
        .I3(Q[1]),
        .O(temp_tx_data_next[6]));
  LUT6 #(
    .INIT(64'h155500000000FFFF)) 
    \temp_tx_data_reg[7]_i_1 
       (.I0(SCLK_INST_0_i_1_n_0),
        .I1(bit_counter_reg[2]),
        .I2(bit_counter_reg[0]),
        .I3(bit_counter_reg[1]),
        .I4(Q[1]),
        .I5(Q[0]),
        .O(\temp_tx_data_reg[7]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hAAC0)) 
    \temp_tx_data_reg[7]_i_2 
       (.I0(temp_tx_data_reg[6]),
        .I1(\temp_tx_data_reg_reg[7]_0 [6]),
        .I2(SCLK_0[0]),
        .I3(Q[1]),
        .O(temp_tx_data_next[7]));
  FDCE \temp_tx_data_reg_reg[0] 
       (.C(clk),
        .CE(\temp_tx_data_reg[7]_i_1_n_0 ),
        .CLR(rst),
        .D(\temp_tx_data_reg_reg[0]_0 ),
        .Q(temp_tx_data_reg[0]));
  FDCE \temp_tx_data_reg_reg[1] 
       (.C(clk),
        .CE(\temp_tx_data_reg[7]_i_1_n_0 ),
        .CLR(rst),
        .D(temp_tx_data_next[1]),
        .Q(temp_tx_data_reg[1]));
  FDCE \temp_tx_data_reg_reg[2] 
       (.C(clk),
        .CE(\temp_tx_data_reg[7]_i_1_n_0 ),
        .CLR(rst),
        .D(temp_tx_data_next[2]),
        .Q(temp_tx_data_reg[2]));
  FDCE \temp_tx_data_reg_reg[3] 
       (.C(clk),
        .CE(\temp_tx_data_reg[7]_i_1_n_0 ),
        .CLR(rst),
        .D(temp_tx_data_next[3]),
        .Q(temp_tx_data_reg[3]));
  FDCE \temp_tx_data_reg_reg[4] 
       (.C(clk),
        .CE(\temp_tx_data_reg[7]_i_1_n_0 ),
        .CLR(rst),
        .D(temp_tx_data_next[4]),
        .Q(temp_tx_data_reg[4]));
  FDCE \temp_tx_data_reg_reg[5] 
       (.C(clk),
        .CE(\temp_tx_data_reg[7]_i_1_n_0 ),
        .CLR(rst),
        .D(temp_tx_data_next[5]),
        .Q(temp_tx_data_reg[5]));
  FDCE \temp_tx_data_reg_reg[6] 
       (.C(clk),
        .CE(\temp_tx_data_reg[7]_i_1_n_0 ),
        .CLR(rst),
        .D(temp_tx_data_next[6]),
        .Q(temp_tx_data_reg[6]));
  FDCE \temp_tx_data_reg_reg[7] 
       (.C(clk),
        .CE(\temp_tx_data_reg[7]_i_1_n_0 ),
        .CLR(rst),
        .D(temp_tx_data_next[7]),
        .Q(MOSI));
endmodule

(* CHECK_LICENSE_TYPE = "design_1_mySPI_Peripheral_0_2,mySPI_Peripheral_v1_0,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "mySPI_Peripheral_v1_0,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clk,
    rst,
    SCLK,
    MOSI,
    MISO,
    s00_axi_aclk,
    s00_axi_aresetn,
    s00_axi_awaddr,
    s00_axi_awprot,
    s00_axi_awvalid,
    s00_axi_awready,
    s00_axi_wdata,
    s00_axi_wstrb,
    s00_axi_wvalid,
    s00_axi_wready,
    s00_axi_bresp,
    s00_axi_bvalid,
    s00_axi_bready,
    s00_axi_araddr,
    s00_axi_arprot,
    s00_axi_arvalid,
    s00_axi_arready,
    s00_axi_rdata,
    s00_axi_rresp,
    s00_axi_rvalid,
    s00_axi_rready);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_1_clk_out1, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input rst;
  output SCLK;
  output MOSI;
  input MISO;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S00_AXI_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXI_CLK, ASSOCIATED_BUSIF S00_AXI, ASSOCIATED_RESET s00_axi_aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_1_clk_out1, INSERT_VIP 0" *) input s00_axi_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S00_AXI_RST RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXI_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s00_axi_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR" *) input [3:0]s00_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWPROT" *) input [2:0]s00_axi_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWVALID" *) input s00_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWREADY" *) output s00_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WDATA" *) input [31:0]s00_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WSTRB" *) input [3:0]s00_axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WVALID" *) input s00_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WREADY" *) output s00_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BRESP" *) output [1:0]s00_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BVALID" *) output s00_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BREADY" *) input s00_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR" *) input [3:0]s00_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT" *) input [2:0]s00_axi_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID" *) input s00_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY" *) output s00_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RDATA" *) output [31:0]s00_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RRESP" *) output [1:0]s00_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RVALID" *) output s00_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXI, WIZ_DATA_WIDTH 32, WIZ_NUM_REG 4, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 4, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_1_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input s00_axi_rready;

  wire \<const0> ;
  wire MISO;
  wire MOSI;
  wire SCLK;
  wire clk;
  wire rst;
  wire s00_axi_aclk;
  wire [3:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arready;
  wire s00_axi_arvalid;
  wire [3:0]s00_axi_awaddr;
  wire s00_axi_awready;
  wire s00_axi_awvalid;
  wire s00_axi_bready;
  wire s00_axi_bvalid;
  wire [31:0]s00_axi_rdata;
  wire s00_axi_rready;
  wire s00_axi_rvalid;
  wire [31:0]s00_axi_wdata;
  wire s00_axi_wready;
  wire [3:0]s00_axi_wstrb;
  wire s00_axi_wvalid;

  assign s00_axi_bresp[1] = \<const0> ;
  assign s00_axi_bresp[0] = \<const0> ;
  assign s00_axi_rresp[1] = \<const0> ;
  assign s00_axi_rresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mySPI_Peripheral_v1_0 inst
       (.MISO(MISO),
        .MOSI(MOSI),
        .SCLK(SCLK),
        .clk(clk),
        .rst(rst),
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_araddr(s00_axi_araddr[3:2]),
        .s00_axi_aresetn(s00_axi_aresetn),
        .s00_axi_arready(s00_axi_arready),
        .s00_axi_arvalid(s00_axi_arvalid),
        .s00_axi_awaddr(s00_axi_awaddr[3:2]),
        .s00_axi_awready(s00_axi_awready),
        .s00_axi_awvalid(s00_axi_awvalid),
        .s00_axi_bready(s00_axi_bready),
        .s00_axi_bvalid(s00_axi_bvalid),
        .s00_axi_rdata(s00_axi_rdata),
        .s00_axi_rready(s00_axi_rready),
        .s00_axi_rvalid(s00_axi_rvalid),
        .s00_axi_wdata(s00_axi_wdata),
        .s00_axi_wready(s00_axi_wready),
        .s00_axi_wstrb(s00_axi_wstrb),
        .s00_axi_wvalid(s00_axi_wvalid));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mySPI_Peripheral_v1_0
   (s00_axi_awready,
    s00_axi_wready,
    s00_axi_arready,
    MOSI,
    s00_axi_rdata,
    s00_axi_rvalid,
    SCLK,
    s00_axi_bvalid,
    clk,
    MISO,
    rst,
    s00_axi_aclk,
    s00_axi_awaddr,
    s00_axi_wvalid,
    s00_axi_awvalid,
    s00_axi_wdata,
    s00_axi_araddr,
    s00_axi_arvalid,
    s00_axi_wstrb,
    s00_axi_aresetn,
    s00_axi_bready,
    s00_axi_rready);
  output s00_axi_awready;
  output s00_axi_wready;
  output s00_axi_arready;
  output MOSI;
  output [31:0]s00_axi_rdata;
  output s00_axi_rvalid;
  output SCLK;
  output s00_axi_bvalid;
  input clk;
  input MISO;
  input rst;
  input s00_axi_aclk;
  input [1:0]s00_axi_awaddr;
  input s00_axi_wvalid;
  input s00_axi_awvalid;
  input [31:0]s00_axi_wdata;
  input [1:0]s00_axi_araddr;
  input s00_axi_arvalid;
  input [3:0]s00_axi_wstrb;
  input s00_axi_aresetn;
  input s00_axi_bready;
  input s00_axi_rready;

  wire MISO;
  wire MOSI;
  wire SCLK;
  wire U_SPI_Master_n_0;
  wire U_SPI_Master_n_1;
  wire U_SPI_Master_n_10;
  wire U_SPI_Master_n_11;
  wire U_SPI_Master_n_12;
  wire U_SPI_Master_n_2;
  wire U_SPI_Master_n_7;
  wire U_SPI_Master_n_8;
  wire U_SPI_Master_n_9;
  wire [3:2]axi_araddr;
  wire clk;
  wire cpha;
  wire cpol;
  wire mySPI_Peripheral_v1_0_S00_AXI_inst_n_18;
  wire mySPI_Peripheral_v1_0_S00_AXI_inst_n_19;
  wire [1:1]reg_data_out;
  wire rst;
  wire s00_axi_aclk;
  wire [1:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arready;
  wire s00_axi_arvalid;
  wire [1:0]s00_axi_awaddr;
  wire s00_axi_awready;
  wire s00_axi_awvalid;
  wire s00_axi_bready;
  wire s00_axi_bvalid;
  wire [31:0]s00_axi_rdata;
  wire s00_axi_rready;
  wire s00_axi_rvalid;
  wire [31:0]s00_axi_wdata;
  wire s00_axi_wready;
  wire [3:0]s00_axi_wstrb;
  wire s00_axi_wvalid;
  wire [7:1]slv_reg1;
  wire start;
  wire [1:0]state_reg;
  wire [0:0]temp_tx_data_next;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_SPI_Master U_SPI_Master
       (.D(reg_data_out),
        .MISO(MISO),
        .MISO_0(U_SPI_Master_n_0),
        .MOSI(MOSI),
        .Q(state_reg),
        .SCLK(SCLK),
        .SCLK_0({cpol,cpha,start}),
        .axi_araddr(axi_araddr),
        .\axi_araddr_reg[2] (U_SPI_Master_n_7),
        .\axi_araddr_reg[2]_0 (U_SPI_Master_n_8),
        .\axi_araddr_reg[2]_1 (U_SPI_Master_n_9),
        .\axi_araddr_reg[2]_2 (U_SPI_Master_n_10),
        .\axi_araddr_reg[2]_3 (U_SPI_Master_n_11),
        .\axi_araddr_reg[2]_4 (U_SPI_Master_n_12),
        .\axi_rdata_reg[1] (mySPI_Peripheral_v1_0_S00_AXI_inst_n_18),
        .\axi_rdata_reg[1]_0 (mySPI_Peripheral_v1_0_S00_AXI_inst_n_19),
        .clk(clk),
        .rst(rst),
        .\temp_rx_data_reg_reg[0]_C_0 (U_SPI_Master_n_2),
        .\temp_rx_data_reg_reg[0]_P_0 (U_SPI_Master_n_1),
        .\temp_tx_data_reg_reg[0]_0 (temp_tx_data_next),
        .\temp_tx_data_reg_reg[7]_0 (slv_reg1));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mySPI_Peripheral_v1_0_S00_AXI mySPI_Peripheral_v1_0_S00_AXI_inst
       (.D(reg_data_out),
        .\FSM_sequential_state_reg[1] (temp_tx_data_next),
        .Q(state_reg),
        .axi_araddr(axi_araddr),
        .\axi_araddr_reg[3]_0 (mySPI_Peripheral_v1_0_S00_AXI_inst_n_18),
        .\axi_araddr_reg[3]_1 (mySPI_Peripheral_v1_0_S00_AXI_inst_n_19),
        .axi_arready_reg_0(s00_axi_arready),
        .axi_awready_reg_0(s00_axi_awready),
        .\axi_rdata_reg[0]_0 (U_SPI_Master_n_1),
        .\axi_rdata_reg[0]_1 (U_SPI_Master_n_0),
        .\axi_rdata_reg[0]_2 (U_SPI_Master_n_2),
        .\axi_rdata_reg[2]_0 (U_SPI_Master_n_7),
        .\axi_rdata_reg[3]_0 (U_SPI_Master_n_8),
        .\axi_rdata_reg[4]_0 (U_SPI_Master_n_9),
        .\axi_rdata_reg[5]_0 (U_SPI_Master_n_10),
        .\axi_rdata_reg[6]_0 (U_SPI_Master_n_11),
        .\axi_rdata_reg[7]_0 (U_SPI_Master_n_12),
        .axi_wready_reg_0(s00_axi_wready),
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_araddr(s00_axi_araddr),
        .s00_axi_aresetn(s00_axi_aresetn),
        .s00_axi_arvalid(s00_axi_arvalid),
        .s00_axi_awaddr(s00_axi_awaddr),
        .s00_axi_awvalid(s00_axi_awvalid),
        .s00_axi_bready(s00_axi_bready),
        .s00_axi_bvalid(s00_axi_bvalid),
        .s00_axi_rdata(s00_axi_rdata),
        .s00_axi_rready(s00_axi_rready),
        .s00_axi_rvalid(s00_axi_rvalid),
        .s00_axi_wdata(s00_axi_wdata),
        .s00_axi_wstrb(s00_axi_wstrb),
        .s00_axi_wvalid(s00_axi_wvalid),
        .\slv_reg0_reg[2]_0 ({cpol,cpha,start}),
        .\slv_reg1_reg[7]_0 (slv_reg1));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mySPI_Peripheral_v1_0_S00_AXI
   (axi_awready_reg_0,
    axi_wready_reg_0,
    axi_arready_reg_0,
    s00_axi_bvalid,
    s00_axi_rvalid,
    \FSM_sequential_state_reg[1] ,
    \slv_reg0_reg[2]_0 ,
    \slv_reg1_reg[7]_0 ,
    axi_araddr,
    \axi_araddr_reg[3]_0 ,
    \axi_araddr_reg[3]_1 ,
    s00_axi_rdata,
    s00_axi_aclk,
    Q,
    D,
    \axi_rdata_reg[0]_0 ,
    \axi_rdata_reg[0]_1 ,
    \axi_rdata_reg[0]_2 ,
    \axi_rdata_reg[2]_0 ,
    \axi_rdata_reg[3]_0 ,
    \axi_rdata_reg[4]_0 ,
    \axi_rdata_reg[5]_0 ,
    \axi_rdata_reg[6]_0 ,
    \axi_rdata_reg[7]_0 ,
    s00_axi_aresetn,
    s00_axi_awvalid,
    s00_axi_wvalid,
    s00_axi_bready,
    s00_axi_arvalid,
    s00_axi_rready,
    s00_axi_awaddr,
    s00_axi_wdata,
    s00_axi_araddr,
    s00_axi_wstrb);
  output axi_awready_reg_0;
  output axi_wready_reg_0;
  output axi_arready_reg_0;
  output s00_axi_bvalid;
  output s00_axi_rvalid;
  output [0:0]\FSM_sequential_state_reg[1] ;
  output [2:0]\slv_reg0_reg[2]_0 ;
  output [6:0]\slv_reg1_reg[7]_0 ;
  output [1:0]axi_araddr;
  output \axi_araddr_reg[3]_0 ;
  output \axi_araddr_reg[3]_1 ;
  output [31:0]s00_axi_rdata;
  input s00_axi_aclk;
  input [1:0]Q;
  input [0:0]D;
  input \axi_rdata_reg[0]_0 ;
  input \axi_rdata_reg[0]_1 ;
  input \axi_rdata_reg[0]_2 ;
  input \axi_rdata_reg[2]_0 ;
  input \axi_rdata_reg[3]_0 ;
  input \axi_rdata_reg[4]_0 ;
  input \axi_rdata_reg[5]_0 ;
  input \axi_rdata_reg[6]_0 ;
  input \axi_rdata_reg[7]_0 ;
  input s00_axi_aresetn;
  input s00_axi_awvalid;
  input s00_axi_wvalid;
  input s00_axi_bready;
  input s00_axi_arvalid;
  input s00_axi_rready;
  input [1:0]s00_axi_awaddr;
  input [31:0]s00_axi_wdata;
  input [1:0]s00_axi_araddr;
  input [3:0]s00_axi_wstrb;

  wire [0:0]D;
  wire [0:0]\FSM_sequential_state_reg[1] ;
  wire [1:0]Q;
  wire aw_en_i_1_n_0;
  wire aw_en_reg_n_0;
  wire [1:0]axi_araddr;
  wire \axi_araddr[2]_i_1_n_0 ;
  wire \axi_araddr[3]_i_1_n_0 ;
  wire \axi_araddr_reg[3]_0 ;
  wire \axi_araddr_reg[3]_1 ;
  wire axi_arready0;
  wire axi_arready_reg_0;
  wire \axi_awaddr[2]_i_1_n_0 ;
  wire \axi_awaddr[3]_i_1_n_0 ;
  wire axi_awready0;
  wire axi_awready_i_1_n_0;
  wire axi_awready_reg_0;
  wire axi_bvalid_i_1_n_0;
  wire \axi_rdata[0]_i_2_n_0 ;
  wire \axi_rdata_reg[0]_0 ;
  wire \axi_rdata_reg[0]_1 ;
  wire \axi_rdata_reg[0]_2 ;
  wire \axi_rdata_reg[2]_0 ;
  wire \axi_rdata_reg[3]_0 ;
  wire \axi_rdata_reg[4]_0 ;
  wire \axi_rdata_reg[5]_0 ;
  wire \axi_rdata_reg[6]_0 ;
  wire \axi_rdata_reg[7]_0 ;
  wire axi_rvalid_i_1_n_0;
  wire axi_wready0;
  wire axi_wready_reg_0;
  wire [1:0]p_0_in;
  wire [31:0]reg_data_out;
  wire s00_axi_aclk;
  wire [1:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arvalid;
  wire [1:0]s00_axi_awaddr;
  wire s00_axi_awvalid;
  wire s00_axi_bready;
  wire s00_axi_bvalid;
  wire [31:0]s00_axi_rdata;
  wire s00_axi_rready;
  wire s00_axi_rvalid;
  wire [31:0]s00_axi_wdata;
  wire [3:0]s00_axi_wstrb;
  wire s00_axi_wvalid;
  wire \slv_reg0[15]_i_1_n_0 ;
  wire \slv_reg0[23]_i_1_n_0 ;
  wire \slv_reg0[31]_i_1_n_0 ;
  wire \slv_reg0[7]_i_1_n_0 ;
  wire [2:0]\slv_reg0_reg[2]_0 ;
  wire \slv_reg0_reg_n_0_[10] ;
  wire \slv_reg0_reg_n_0_[11] ;
  wire \slv_reg0_reg_n_0_[12] ;
  wire \slv_reg0_reg_n_0_[13] ;
  wire \slv_reg0_reg_n_0_[14] ;
  wire \slv_reg0_reg_n_0_[15] ;
  wire \slv_reg0_reg_n_0_[16] ;
  wire \slv_reg0_reg_n_0_[17] ;
  wire \slv_reg0_reg_n_0_[18] ;
  wire \slv_reg0_reg_n_0_[19] ;
  wire \slv_reg0_reg_n_0_[20] ;
  wire \slv_reg0_reg_n_0_[21] ;
  wire \slv_reg0_reg_n_0_[22] ;
  wire \slv_reg0_reg_n_0_[23] ;
  wire \slv_reg0_reg_n_0_[24] ;
  wire \slv_reg0_reg_n_0_[25] ;
  wire \slv_reg0_reg_n_0_[26] ;
  wire \slv_reg0_reg_n_0_[27] ;
  wire \slv_reg0_reg_n_0_[28] ;
  wire \slv_reg0_reg_n_0_[29] ;
  wire \slv_reg0_reg_n_0_[30] ;
  wire \slv_reg0_reg_n_0_[31] ;
  wire \slv_reg0_reg_n_0_[3] ;
  wire \slv_reg0_reg_n_0_[4] ;
  wire \slv_reg0_reg_n_0_[5] ;
  wire \slv_reg0_reg_n_0_[6] ;
  wire \slv_reg0_reg_n_0_[7] ;
  wire \slv_reg0_reg_n_0_[8] ;
  wire \slv_reg0_reg_n_0_[9] ;
  wire [31:0]slv_reg1;
  wire \slv_reg1[15]_i_1_n_0 ;
  wire \slv_reg1[23]_i_1_n_0 ;
  wire \slv_reg1[31]_i_1_n_0 ;
  wire \slv_reg1[7]_i_1_n_0 ;
  wire [6:0]\slv_reg1_reg[7]_0 ;
  wire slv_reg_rden__0;
  wire slv_reg_wren__0;

  LUT6 #(
    .INIT(64'hF7FFC4CCC4CCC4CC)) 
    aw_en_i_1
       (.I0(s00_axi_awvalid),
        .I1(aw_en_reg_n_0),
        .I2(axi_awready_reg_0),
        .I3(s00_axi_wvalid),
        .I4(s00_axi_bready),
        .I5(s00_axi_bvalid),
        .O(aw_en_i_1_n_0));
  FDSE aw_en_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(aw_en_i_1_n_0),
        .Q(aw_en_reg_n_0),
        .S(axi_awready_i_1_n_0));
  LUT4 #(
    .INIT(16'hFB08)) 
    \axi_araddr[2]_i_1 
       (.I0(s00_axi_araddr[0]),
        .I1(s00_axi_arvalid),
        .I2(axi_arready_reg_0),
        .I3(axi_araddr[0]),
        .O(\axi_araddr[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \axi_araddr[3]_i_1 
       (.I0(s00_axi_araddr[1]),
        .I1(s00_axi_arvalid),
        .I2(axi_arready_reg_0),
        .I3(axi_araddr[1]),
        .O(\axi_araddr[3]_i_1_n_0 ));
  FDRE \axi_araddr_reg[2] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_araddr[2]_i_1_n_0 ),
        .Q(axi_araddr[0]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_araddr_reg[3] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_araddr[3]_i_1_n_0 ),
        .Q(axi_araddr[1]),
        .R(axi_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    axi_arready_i_1
       (.I0(s00_axi_arvalid),
        .I1(axi_arready_reg_0),
        .O(axi_arready0));
  FDRE axi_arready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_arready0),
        .Q(axi_arready_reg_0),
        .R(axi_awready_i_1_n_0));
  LUT6 #(
    .INIT(64'hFBFFFFFF08000000)) 
    \axi_awaddr[2]_i_1 
       (.I0(s00_axi_awaddr[0]),
        .I1(s00_axi_wvalid),
        .I2(axi_awready_reg_0),
        .I3(aw_en_reg_n_0),
        .I4(s00_axi_awvalid),
        .I5(p_0_in[0]),
        .O(\axi_awaddr[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFBFFFFFF08000000)) 
    \axi_awaddr[3]_i_1 
       (.I0(s00_axi_awaddr[1]),
        .I1(s00_axi_wvalid),
        .I2(axi_awready_reg_0),
        .I3(aw_en_reg_n_0),
        .I4(s00_axi_awvalid),
        .I5(p_0_in[1]),
        .O(\axi_awaddr[3]_i_1_n_0 ));
  FDRE \axi_awaddr_reg[2] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_awaddr[2]_i_1_n_0 ),
        .Q(p_0_in[0]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_awaddr_reg[3] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_awaddr[3]_i_1_n_0 ),
        .Q(p_0_in[1]),
        .R(axi_awready_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    axi_awready_i_1
       (.I0(s00_axi_aresetn),
        .O(axi_awready_i_1_n_0));
  LUT4 #(
    .INIT(16'h2000)) 
    axi_awready_i_2
       (.I0(s00_axi_wvalid),
        .I1(axi_awready_reg_0),
        .I2(aw_en_reg_n_0),
        .I3(s00_axi_awvalid),
        .O(axi_awready0));
  FDRE axi_awready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_awready0),
        .Q(axi_awready_reg_0),
        .R(axi_awready_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000FFFF80008000)) 
    axi_bvalid_i_1
       (.I0(s00_axi_awvalid),
        .I1(s00_axi_wvalid),
        .I2(axi_awready_reg_0),
        .I3(axi_wready_reg_0),
        .I4(s00_axi_bready),
        .I5(s00_axi_bvalid),
        .O(axi_bvalid_i_1_n_0));
  FDRE axi_bvalid_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_bvalid_i_1_n_0),
        .Q(s00_axi_bvalid),
        .R(axi_awready_i_1_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAAAEFEAAAAA)) 
    \axi_rdata[0]_i_1 
       (.I0(\axi_rdata[0]_i_2_n_0 ),
        .I1(\axi_rdata_reg[0]_0 ),
        .I2(\axi_rdata_reg[0]_1 ),
        .I3(\axi_rdata_reg[0]_2 ),
        .I4(axi_araddr[1]),
        .I5(axi_araddr[0]),
        .O(reg_data_out[0]));
  LUT6 #(
    .INIT(64'h00AC00AC00AC30AC)) 
    \axi_rdata[0]_i_2 
       (.I0(slv_reg1[0]),
        .I1(\slv_reg0_reg[2]_0 [0]),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .I4(Q[1]),
        .I5(Q[0]),
        .O(\axi_rdata[0]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[10]_i_1 
       (.I0(slv_reg1[10]),
        .I1(\slv_reg0_reg_n_0_[10] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[10]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[11]_i_1 
       (.I0(slv_reg1[11]),
        .I1(\slv_reg0_reg_n_0_[11] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[11]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[12]_i_1 
       (.I0(slv_reg1[12]),
        .I1(\slv_reg0_reg_n_0_[12] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[12]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[13]_i_1 
       (.I0(slv_reg1[13]),
        .I1(\slv_reg0_reg_n_0_[13] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[13]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[14]_i_1 
       (.I0(slv_reg1[14]),
        .I1(\slv_reg0_reg_n_0_[14] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[14]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[15]_i_1 
       (.I0(slv_reg1[15]),
        .I1(\slv_reg0_reg_n_0_[15] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[15]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[16]_i_1 
       (.I0(slv_reg1[16]),
        .I1(\slv_reg0_reg_n_0_[16] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[16]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[17]_i_1 
       (.I0(slv_reg1[17]),
        .I1(\slv_reg0_reg_n_0_[17] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[17]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[18]_i_1 
       (.I0(slv_reg1[18]),
        .I1(\slv_reg0_reg_n_0_[18] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[18]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[19]_i_1 
       (.I0(slv_reg1[19]),
        .I1(\slv_reg0_reg_n_0_[19] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[19]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h10)) 
    \axi_rdata[1]_i_2 
       (.I0(axi_araddr[1]),
        .I1(axi_araddr[0]),
        .I2(\slv_reg0_reg[2]_0 [1]),
        .O(\axi_araddr_reg[3]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \axi_rdata[1]_i_4 
       (.I0(axi_araddr[1]),
        .I1(axi_araddr[0]),
        .I2(\slv_reg1_reg[7]_0 [0]),
        .O(\axi_araddr_reg[3]_1 ));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[20]_i_1 
       (.I0(slv_reg1[20]),
        .I1(\slv_reg0_reg_n_0_[20] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[20]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[21]_i_1 
       (.I0(slv_reg1[21]),
        .I1(\slv_reg0_reg_n_0_[21] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[21]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[22]_i_1 
       (.I0(slv_reg1[22]),
        .I1(\slv_reg0_reg_n_0_[22] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[22]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[23]_i_1 
       (.I0(slv_reg1[23]),
        .I1(\slv_reg0_reg_n_0_[23] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[23]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[24]_i_1 
       (.I0(slv_reg1[24]),
        .I1(\slv_reg0_reg_n_0_[24] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[24]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[25]_i_1 
       (.I0(slv_reg1[25]),
        .I1(\slv_reg0_reg_n_0_[25] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[25]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[26]_i_1 
       (.I0(slv_reg1[26]),
        .I1(\slv_reg0_reg_n_0_[26] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[26]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[27]_i_1 
       (.I0(slv_reg1[27]),
        .I1(\slv_reg0_reg_n_0_[27] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[27]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[28]_i_1 
       (.I0(slv_reg1[28]),
        .I1(\slv_reg0_reg_n_0_[28] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[28]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[29]_i_1 
       (.I0(slv_reg1[29]),
        .I1(\slv_reg0_reg_n_0_[29] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[29]));
  LUT5 #(
    .INIT(32'hFFFF5410)) 
    \axi_rdata[2]_i_1 
       (.I0(axi_araddr[1]),
        .I1(axi_araddr[0]),
        .I2(\slv_reg0_reg[2]_0 [2]),
        .I3(\slv_reg1_reg[7]_0 [1]),
        .I4(\axi_rdata_reg[2]_0 ),
        .O(reg_data_out[2]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[30]_i_1 
       (.I0(slv_reg1[30]),
        .I1(\slv_reg0_reg_n_0_[30] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[30]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[31]_i_1 
       (.I0(slv_reg1[31]),
        .I1(\slv_reg0_reg_n_0_[31] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[31]));
  LUT5 #(
    .INIT(32'hFFFF5410)) 
    \axi_rdata[3]_i_1 
       (.I0(axi_araddr[1]),
        .I1(axi_araddr[0]),
        .I2(\slv_reg0_reg_n_0_[3] ),
        .I3(\slv_reg1_reg[7]_0 [2]),
        .I4(\axi_rdata_reg[3]_0 ),
        .O(reg_data_out[3]));
  LUT5 #(
    .INIT(32'hFFFF5410)) 
    \axi_rdata[4]_i_1 
       (.I0(axi_araddr[1]),
        .I1(axi_araddr[0]),
        .I2(\slv_reg0_reg_n_0_[4] ),
        .I3(\slv_reg1_reg[7]_0 [3]),
        .I4(\axi_rdata_reg[4]_0 ),
        .O(reg_data_out[4]));
  LUT5 #(
    .INIT(32'hFFFF5410)) 
    \axi_rdata[5]_i_1 
       (.I0(axi_araddr[1]),
        .I1(axi_araddr[0]),
        .I2(\slv_reg0_reg_n_0_[5] ),
        .I3(\slv_reg1_reg[7]_0 [4]),
        .I4(\axi_rdata_reg[5]_0 ),
        .O(reg_data_out[5]));
  LUT5 #(
    .INIT(32'hFFFF5410)) 
    \axi_rdata[6]_i_1 
       (.I0(axi_araddr[1]),
        .I1(axi_araddr[0]),
        .I2(\slv_reg0_reg_n_0_[6] ),
        .I3(\slv_reg1_reg[7]_0 [5]),
        .I4(\axi_rdata_reg[6]_0 ),
        .O(reg_data_out[6]));
  LUT5 #(
    .INIT(32'hFFFF5410)) 
    \axi_rdata[7]_i_1 
       (.I0(axi_araddr[1]),
        .I1(axi_araddr[0]),
        .I2(\slv_reg0_reg_n_0_[7] ),
        .I3(\slv_reg1_reg[7]_0 [6]),
        .I4(\axi_rdata_reg[7]_0 ),
        .O(reg_data_out[7]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[8]_i_1 
       (.I0(slv_reg1[8]),
        .I1(\slv_reg0_reg_n_0_[8] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[8]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[9]_i_1 
       (.I0(slv_reg1[9]),
        .I1(\slv_reg0_reg_n_0_[9] ),
        .I2(axi_araddr[0]),
        .I3(axi_araddr[1]),
        .O(reg_data_out[9]));
  FDRE \axi_rdata_reg[0] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[0]),
        .Q(s00_axi_rdata[0]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[10] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[10]),
        .Q(s00_axi_rdata[10]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[11] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[11]),
        .Q(s00_axi_rdata[11]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[12] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[12]),
        .Q(s00_axi_rdata[12]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[13] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[13]),
        .Q(s00_axi_rdata[13]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[14] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[14]),
        .Q(s00_axi_rdata[14]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[15] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[15]),
        .Q(s00_axi_rdata[15]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[16] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[16]),
        .Q(s00_axi_rdata[16]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[17] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[17]),
        .Q(s00_axi_rdata[17]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[18] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[18]),
        .Q(s00_axi_rdata[18]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[19] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[19]),
        .Q(s00_axi_rdata[19]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[1] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(D),
        .Q(s00_axi_rdata[1]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[20] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[20]),
        .Q(s00_axi_rdata[20]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[21] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[21]),
        .Q(s00_axi_rdata[21]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[22] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[22]),
        .Q(s00_axi_rdata[22]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[23] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[23]),
        .Q(s00_axi_rdata[23]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[24] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[24]),
        .Q(s00_axi_rdata[24]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[25] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[25]),
        .Q(s00_axi_rdata[25]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[26] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[26]),
        .Q(s00_axi_rdata[26]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[27] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[27]),
        .Q(s00_axi_rdata[27]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[28] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[28]),
        .Q(s00_axi_rdata[28]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[29] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[29]),
        .Q(s00_axi_rdata[29]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[2] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[2]),
        .Q(s00_axi_rdata[2]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[30] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[30]),
        .Q(s00_axi_rdata[30]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[31] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[31]),
        .Q(s00_axi_rdata[31]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[3] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[3]),
        .Q(s00_axi_rdata[3]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[4] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[4]),
        .Q(s00_axi_rdata[4]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[5] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[5]),
        .Q(s00_axi_rdata[5]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[6] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[6]),
        .Q(s00_axi_rdata[6]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[7] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[7]),
        .Q(s00_axi_rdata[7]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[8] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[8]),
        .Q(s00_axi_rdata[8]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[9] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(reg_data_out[9]),
        .Q(s00_axi_rdata[9]),
        .R(axi_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h08F8)) 
    axi_rvalid_i_1
       (.I0(axi_arready_reg_0),
        .I1(s00_axi_arvalid),
        .I2(s00_axi_rvalid),
        .I3(s00_axi_rready),
        .O(axi_rvalid_i_1_n_0));
  FDRE axi_rvalid_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_rvalid_i_1_n_0),
        .Q(s00_axi_rvalid),
        .R(axi_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    axi_wready_i_1
       (.I0(s00_axi_awvalid),
        .I1(s00_axi_wvalid),
        .I2(axi_wready_reg_0),
        .I3(aw_en_reg_n_0),
        .O(axi_wready0));
  FDRE axi_wready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_wready0),
        .Q(axi_wready_reg_0),
        .R(axi_awready_i_1_n_0));
  LUT4 #(
    .INIT(16'h0200)) 
    \slv_reg0[15]_i_1 
       (.I0(slv_reg_wren__0),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(s00_axi_wstrb[1]),
        .O(\slv_reg0[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0200)) 
    \slv_reg0[23]_i_1 
       (.I0(slv_reg_wren__0),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(s00_axi_wstrb[2]),
        .O(\slv_reg0[23]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0200)) 
    \slv_reg0[31]_i_1 
       (.I0(slv_reg_wren__0),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(s00_axi_wstrb[3]),
        .O(\slv_reg0[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \slv_reg0[31]_i_2 
       (.I0(axi_wready_reg_0),
        .I1(axi_awready_reg_0),
        .I2(s00_axi_awvalid),
        .I3(s00_axi_wvalid),
        .O(slv_reg_wren__0));
  LUT4 #(
    .INIT(16'h0200)) 
    \slv_reg0[7]_i_1 
       (.I0(slv_reg_wren__0),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(s00_axi_wstrb[0]),
        .O(\slv_reg0[7]_i_1_n_0 ));
  FDRE \slv_reg0_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[0]),
        .Q(\slv_reg0_reg[2]_0 [0]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[10] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[10]),
        .Q(\slv_reg0_reg_n_0_[10] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[11] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[11]),
        .Q(\slv_reg0_reg_n_0_[11] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[12] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[12]),
        .Q(\slv_reg0_reg_n_0_[12] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[13] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[13]),
        .Q(\slv_reg0_reg_n_0_[13] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[14] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[14]),
        .Q(\slv_reg0_reg_n_0_[14] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[15] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[15]),
        .Q(\slv_reg0_reg_n_0_[15] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[16] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[16]),
        .Q(\slv_reg0_reg_n_0_[16] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[17] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[17]),
        .Q(\slv_reg0_reg_n_0_[17] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[18] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[18]),
        .Q(\slv_reg0_reg_n_0_[18] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[19] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[19]),
        .Q(\slv_reg0_reg_n_0_[19] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[1]),
        .Q(\slv_reg0_reg[2]_0 [1]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[20] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[20]),
        .Q(\slv_reg0_reg_n_0_[20] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[21] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[21]),
        .Q(\slv_reg0_reg_n_0_[21] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[22] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[22]),
        .Q(\slv_reg0_reg_n_0_[22] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[23] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[23]),
        .Q(\slv_reg0_reg_n_0_[23] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[24] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[24]),
        .Q(\slv_reg0_reg_n_0_[24] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[25] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[25]),
        .Q(\slv_reg0_reg_n_0_[25] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[26] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[26]),
        .Q(\slv_reg0_reg_n_0_[26] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[27] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[27]),
        .Q(\slv_reg0_reg_n_0_[27] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[28] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[28]),
        .Q(\slv_reg0_reg_n_0_[28] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[29] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[29]),
        .Q(\slv_reg0_reg_n_0_[29] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[2]),
        .Q(\slv_reg0_reg[2]_0 [2]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[30] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[30]),
        .Q(\slv_reg0_reg_n_0_[30] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[31] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[31]),
        .Q(\slv_reg0_reg_n_0_[31] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[3]),
        .Q(\slv_reg0_reg_n_0_[3] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[4] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[4]),
        .Q(\slv_reg0_reg_n_0_[4] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[5] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[5]),
        .Q(\slv_reg0_reg_n_0_[5] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[6] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[6]),
        .Q(\slv_reg0_reg_n_0_[6] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[7] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[7]),
        .Q(\slv_reg0_reg_n_0_[7] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[8] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[8]),
        .Q(\slv_reg0_reg_n_0_[8] ),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg0_reg[9] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[9]),
        .Q(\slv_reg0_reg_n_0_[9] ),
        .R(axi_awready_i_1_n_0));
  LUT4 #(
    .INIT(16'h0080)) 
    \slv_reg1[15]_i_1 
       (.I0(slv_reg_wren__0),
        .I1(s00_axi_wstrb[1]),
        .I2(p_0_in[0]),
        .I3(p_0_in[1]),
        .O(\slv_reg1[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0080)) 
    \slv_reg1[23]_i_1 
       (.I0(slv_reg_wren__0),
        .I1(s00_axi_wstrb[2]),
        .I2(p_0_in[0]),
        .I3(p_0_in[1]),
        .O(\slv_reg1[23]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0080)) 
    \slv_reg1[31]_i_1 
       (.I0(slv_reg_wren__0),
        .I1(s00_axi_wstrb[3]),
        .I2(p_0_in[0]),
        .I3(p_0_in[1]),
        .O(\slv_reg1[31]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0080)) 
    \slv_reg1[7]_i_1 
       (.I0(slv_reg_wren__0),
        .I1(s00_axi_wstrb[0]),
        .I2(p_0_in[0]),
        .I3(p_0_in[1]),
        .O(\slv_reg1[7]_i_1_n_0 ));
  FDRE \slv_reg1_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[0]),
        .Q(slv_reg1[0]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[10] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[10]),
        .Q(slv_reg1[10]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[11] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[11]),
        .Q(slv_reg1[11]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[12] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[12]),
        .Q(slv_reg1[12]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[13] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[13]),
        .Q(slv_reg1[13]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[14] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[14]),
        .Q(slv_reg1[14]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[15] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[15]),
        .Q(slv_reg1[15]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[16] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[16]),
        .Q(slv_reg1[16]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[17] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[17]),
        .Q(slv_reg1[17]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[18] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[18]),
        .Q(slv_reg1[18]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[19] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[19]),
        .Q(slv_reg1[19]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[1]),
        .Q(\slv_reg1_reg[7]_0 [0]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[20] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[20]),
        .Q(slv_reg1[20]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[21] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[21]),
        .Q(slv_reg1[21]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[22] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[22]),
        .Q(slv_reg1[22]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[23] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[23]),
        .Q(slv_reg1[23]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[24] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[24]),
        .Q(slv_reg1[24]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[25] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[25]),
        .Q(slv_reg1[25]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[26] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[26]),
        .Q(slv_reg1[26]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[27] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[27]),
        .Q(slv_reg1[27]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[28] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[28]),
        .Q(slv_reg1[28]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[29] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[29]),
        .Q(slv_reg1[29]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[2]),
        .Q(\slv_reg1_reg[7]_0 [1]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[30] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[30]),
        .Q(slv_reg1[30]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[31] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[31]),
        .Q(slv_reg1[31]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[3]),
        .Q(\slv_reg1_reg[7]_0 [2]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[4] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[4]),
        .Q(\slv_reg1_reg[7]_0 [3]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[5] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[5]),
        .Q(\slv_reg1_reg[7]_0 [4]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[6] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[6]),
        .Q(\slv_reg1_reg[7]_0 [5]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[7] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[7]),
        .Q(\slv_reg1_reg[7]_0 [6]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[8] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[8]),
        .Q(slv_reg1[8]),
        .R(axi_awready_i_1_n_0));
  FDRE \slv_reg1_reg[9] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[9]),
        .Q(slv_reg1[9]),
        .R(axi_awready_i_1_n_0));
  LUT3 #(
    .INIT(8'h20)) 
    slv_reg_rden
       (.I0(s00_axi_arvalid),
        .I1(s00_axi_rvalid),
        .I2(axi_arready_reg_0),
        .O(slv_reg_rden__0));
  LUT3 #(
    .INIT(8'h40)) 
    \temp_tx_data_reg[0]_i_1 
       (.I0(Q[1]),
        .I1(\slv_reg0_reg[2]_0 [0]),
        .I2(slv_reg1[0]),
        .O(\FSM_sequential_state_reg[1] ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
