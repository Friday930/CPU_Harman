`timescale 1ns / 1ps

module tb_FND ();

  logic sys_clk;
  logic rst;
  logic btn;
  logic [15:0] number;
  logic [7:0] fnd_font;
  logic [3:0] fnd_comm;

  // 내부 신호 모니터링 추가
  logic start;
  logic SCLK;
  logic MOSI;
  logic MISO;
  logic CS;  // CS 신호 추가
  logic done;
  logic [1:0] master_state;


  SPI_FND dut (.*);

  assign CS = dut.CS;  // Top 모듈에서 CS 신호 접근
  assign start = dut.start;
  assign SCLK = dut.U_SPI_Master.SCLK;
  assign MOSI = dut.U_SPI_Master.MOSI;
  assign MISO = dut.U_SPI_Slave_IP.MISO;
  assign done = dut.U_SPI_Master.done;
  assign ready = dut.U_SPI_Master.ready;

  always #5 sys_clk = ~sys_clk;

  initial begin
    sys_clk = 0;
    rst = 1;
    btn = 0;
    number = 0;
    #10;
    rst = 0;

    // 테스트 케이스 1: 0번 스위치만 ON (이진수 1)
    number = 16'h0001;  // 0번 스위치만 ON -> FND에 1 표시
    #100;
    btn = 1;
    #100;
    btn = 0;
    #5000;

    // 테스트 케이스 2: 0번, 1번 스위치 ON (이진수 3)
    number = 16'h0003;  // 0번, 1번 스위치 ON -> FND에 3 표시
    #100;
    btn = 1;
    #100;
    btn = 0;
    #5000;

    // 테스트 케이스 3: 0, 1, 2번 스위치 ON (이진수 7)
    number = 16'h0007;  // 0, 1, 2번 스위치 ON -> FND에 7 표시
    #100;
    btn = 1;
    #100;
    btn = 0;
    #5000;

    // 테스트 케이스 4: 3번 스위치만 ON (이진수 8)
    number = 16'h0008;  // 3번 스위치만 ON -> FND에 8 표시
    #100;
    btn = 1;
    #100;
    btn = 0;
    #5000;

    // 테스트 케이스 5: 0, 3번 스위치 ON (이진수 9)
    number = 16'h0009;  // 0, 3번 스위치 ON -> FND에 9 표시
    #100;
    btn = 1;
    #100;
    btn = 0;
    #5000;

    // 테스트 케이스 6: 0, 1, 2, 3번 스위치 ON (이진수 15 = 16진수 F)
    number = 16'h000F;  // 0~3번 스위치 ON -> FND에 F 표시
    #100;
    btn = 1;
    #100;
    btn = 0;
    #5000;

    $finish;

  end

endmodule

// `timescale 1ns / 1ps

// module tb_FND ();

//   logic sys_clk;
//   logic rst;
//   logic btn;
//   logic [15:0] number;
//   logic [7:0] fnd_font;
//   logic [3:0] fnd_comm;

//   // 디버깅용 신호
//   logic start;
//   logic SCLK;
//   logic MOSI;
//   logic MISO;
//   logic CS;
//   logic done;
//   logic [1:0] master_state;
//   logic [1:0] slave_state;
//   logic [7:0] tx_data;
//   logic [15:0] fnd_data;

//   SPI_FND dut (.*);

//   // 내부 신호 접근
//   assign start = dut.start;
//   assign SCLK = dut.SCLK;
//   assign MOSI = dut.MOSI;
//   assign MISO = dut.MISO;
//   assign CS = dut.CS;
//   assign done = dut.done;
//   assign master_state = dut.U_SPI_Master.state;
//   assign slave_state = dut.U_SPI_Slave_IP.U_FSM.state;
//   assign tx_data = dut.tx_data;
//   assign fnd_data = dut.U_SPI_Slave_IP.fnd_data;

//   always #5 sys_clk = ~sys_clk;

//   initial begin
//     sys_clk = 0; rst = 1; btn = 0; number = 16'h0000;
    
//     // 명확한 리셋
//     #100; rst = 0;
//     #100;
    
//     // 테스트 케이스 1: 0번 스위치만 ON (이진수 1)
//     number = 16'h0001;
//     #100;
//     btn = 1;
//     #20;  // 짧게 버튼 누름
//     btn = 0;
//     #10000;  // 충분한 시간 대기
    
//     // 테스트 케이스 2: 0번, 1번 스위치 ON (이진수 3)
//     number = 16'h0003;
//     #100;
//     btn = 1;
//     #20;
//     btn = 0;
//     #10000;
    
//     $finish;
//   end


// endmodule
