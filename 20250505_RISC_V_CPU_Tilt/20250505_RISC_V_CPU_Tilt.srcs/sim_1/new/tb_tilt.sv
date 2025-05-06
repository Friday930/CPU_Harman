// `timescale 1ns / 1ps
// class transaction;

//   rand logic [ 3:0] PADDR;
//   rand logic [31:0] PWDATA;
//   rand logic        PWRITE;
//   rand logic        PENABLE;
//   rand logic        PSEL;
//   logic      [31:0] PRDATA;
//   logic             PREADY;
//   // IP input
//   logic             tilt_sensor;

// endclass  //transaction

// interface APB_Slave_Interface;
//   // global signal
//   logic        PCLK;
//   logic        PRESET;
//   // APB Interface Signals
//   logic [ 3:0] PADDR;
//   logic [31:0] PWDATA;
//   logic        PWRITE;
//   logic        PENABLE;
//   logic        PSEL;
//   logic [31:0] PRDATA;
//   logic        PREADY;
//   // internal signals
//   logic        tdr;
// endinterface  //APB_Slave_Interface

// class generator;
//   mailbox #(transaction) Gen2Drv_mbox;
//   event gen_next_event;

//   function new(mailbox#(transaction) Gen2Drv_mbox, event gen_next_event);
//     this.Gen2Drv_mbox   = Gen2Drv_mbox;
//     this.gen_next_event = gen_next_event;
//   endfunction  //new()

//   task run(int repeat_counter);
//     transaction fnd_tr;
//     repeat (repeat_counter) begin
//       fnd_tr = new();
//       if (!fnd_tr.randomize()) $error("Randomization fail!");
//       fnd_tr.display("GEN");
//       Gen2Drv_mbox.put(fnd_tr);
//       @(gen_next_event);
//     end
//   endtask  //
// endclass  //generator

// class driver;
//   virtual APB_Slave_Interface fnd_intf;
//   mailbox #(transaction) Gen2Drv_mbox;
//   transaction fnd_tr;

//   function new(virtual APB_Slave_Interface fnd_intf, mailbox#(transaction) Gen2Drv_mbox);
//     this.fnd_intf = fnd_intf;
//     this.Gen2Drv_mbox = Gen2Drv_mbox;
//   endfunction  //new()

//   task run();
//     forever begin
//       Gen2Drv_mbox.get(fnd_tr);
//       fnd_tr.display("DRV");
//       @(posedge fnd_intf.PCLK);
//       fnd_intf.PADDR <= fnd_tr.PADDR;
//       fnd_intf.PWDATA <= fnd_tr.PWDATA;
//       fnd_intf.PWRITE <= 1'b1;
//       fnd_intf.PENABLE <= 1'b0;
//       fnd_intf.PSEL <= 1'b1;
//       @(posedge fnd_intf.PCLK);
//       fnd_intf.PADDR   <= fnd_tr.PADDR;
//       fnd_intf.PWDATA  <= fnd_tr.PWDATA;
//       fnd_intf.PWRITE  <= 1'b1;
//       fnd_intf.PENABLE <= 1'b1;
//       fnd_intf.PSEL    <= 1'b1;
//       wait (fnd_intf.PREADY == 1'b1);
//       @(posedge fnd_intf.PCLK);
//       @(posedge fnd_intf.PCLK);
//       @(posedge fnd_intf.PCLK);
//     end
//   endtask  //
// endclass  //driver

// class monitor;
//   mailbox #(transaction) Mon2SCB_mbox;
//   virtual APB_Slave_Interface fnd_intf;
//   transaction fnd_tr;

//   function new(virtual APB_Slave_Intferface fnd_intf, mailbox#(transaction) Mon2SCB_mbox);
//     this.fnd_intf     = fnd_intf;
//     this.Mon2SCB_mbox = Mon2SCB_mbox;
//   endfunction  //new()

//   task run();
//     forever begin
//       fnd_tr = new();
//       wait (fnd_intf.PREADY == 1'b1);
//       #1;
//       fnd_tr.PADDR   = fnd_intf.PADDR;
//       fnd_tr.PWDATA  = fnd_intf.PWDATA;
//       fnd_tr.PWRITE  = fnd_intf.PWRITE;
//       fnd_tr.PENABLE = fnd_intf.PENABLE;
//       fnd_tr.PSEL    = fnd_intf.PSEL;
//       fnd_tr.PRDATA  = fnd_intf.PRDATA;
//       fnd_tr.PREADY  = fnd_intf.PREADY;
//       fnd_tr.fndCom  = fnd_intf.fndCom;
//       fnd_tr.fndFont = fnd_intf.fndFont;
//       fnd_tr.display("MON");
//       Mon2SCB_mbox.put(fnd_tr);  // mailbox에 fnd_tr의 핸들러의 ref값 넣겠다
//       @(posedge fnd_intf.PCLK);
//       @(posedge fnd_intf.PCLK);
//       @(posedge fnd_intf.PCLK);
//     end
//   endtask  //

// endclass  //monitor

// class scoreboard;
//   mailbox #(transaction) Mon2SCB_mbox;
//   transaction fnd_tr;
//   event gen_next_event;

//   // reference model(가상의 register)
//   logic [31:0] refFndReg[0:2];
//   int refFndFont[16] = '{
//       8'hc0,
//       8'hf9,
//       8'ha4,
//       8'hb0,
//       8'h99,
//       8'h92,
//       8'h82,
//       8'hf8,
//       8'h80,
//       8'h90,
//       8'h88,
//       8'h83,
//       8'hc6,
//       8'ha1,
//       8'h86,
//       8'h8e
//   };

//   function new(mailbox#(transaction) Mon2SCB_mbox, event gen_next_event);
//     this.Mon2SCB_mbox   = Mon2SCB_mbox;
//     this.gen_next_event = gen_next_event;
//     for (int i = 0; i < 3; i++) begin
//       refFndReg[i] = 0;
//     end
//   endfunction  //new()

//   task run();
//     forever begin
//       Mon2SCB_mbox.get(fnd_tr);
//       fnd_tr.display("SCB");
//       if (fnd_tr.PWRITE) begin  // write mode
//         refFndReg[fnd_tr.PADDR[3:2]] = fnd_tr.PWDATA;
//         if (refFndFont[refFndReg[2]] == fnd_tr.fndFont) begin  // PASS
//           $display("FND Font PASS");
//         end else begin  // FAIL
//           $display("FND Font FAIL");
//         end

//         if (refFndReg[0] == 0) begin  // en = 0 : fndCom == 4'b1111
//           if (4'hf == fnd_tr.fndCom) begin
//             $display("FND Enable PASS");
//           end else begin
//             $display("FND Enable FAIL");
//           end
//         end else begin  // en = 1
//           if (refFndReg[1] == ~fnd_tr.fndCom[3:0]) begin
//             $display("FND ComPort PASS");
//           end else begin
//             $display("FND ComPort FAIL");
//           end
//         end
//       end else begin  // read mode

//       end
//       ->gen_next_event;  // event trigger
//     end
//   endtask  //
// endclass  //scoreboard

// class envirnment;
//   mailbox #(transaction) Gen2Drv_mbox;
//   mailbox #(transaction) Mon2SCB_mbox;

//   generator fnd_gen;
//   driver fnd_drv;
//   monitor fnd_mon;
//   scoreboard fnd_scb;

//   event gen_next_event;

//   function new(virtual APB_Slave_Intferface fnd_intf);
//     this.Gen2Drv_mbox = new();
//     this.Mon2SCB_mbox = new();
//     this.fnd_gen      = new(Gen2Drv_mbox, gen_next_event);
//     this.fnd_drv      = new(fnd_intf, Gen2Drv_mbox);
//     this.fnd_mon      = new(fnd_intf, Mon2SCB_mbox);
//     this.fnd_scb      = new(Mon2SCB_mbox, gen_next_event);
//   endfunction  //new()

//   task run(int count);
//     fork
//       fnd_gen.run(count);
//       fnd_drv.run();
//       fnd_mon.run();
//       fnd_scb.run();
//     join_any
//     ;
//   endtask  //
// endclass  //envirnment

// module tb_tilt ();
//   envirnment fnd_env;
//   APB_Slave_Intferface fnd_intf ();

//   always #5 fnd_intf.PCLK = ~fnd_intf.PCLK;

//   FndController_Periph dut (
//       // global signal
//       .PCLK   (fnd_intf.PCLK),
//       .PRESET (fnd_intf.PRESET),
//       // APB Interface Signals
//       .PADDR  (fnd_intf.PADDR),
//       .PWDATA (fnd_intf.PWDATA),
//       .PWRITE (fnd_intf.PWRITE),
//       .PENABLE(fnd_intf.PENABLE),
//       .PSEL   (fnd_intf.PSEL),
//       .PRDATA (fnd_intf.PRDATA),
//       .PREADY (fnd_intf.PREADY),
//       // outport signals
//       .fndCom (fnd_intf.fndCom),
//       .fndFont(fnd_intf.fndFont)
//   );

//   initial begin
//     fnd_intf.PCLK   = 0;
//     fnd_intf.PRESET = 1;
//     #10 fnd_intf.PRESET = 0;
//     fnd_env = new(fnd_intf);
//     fnd_env.run(10);
//     #30;
//     $finish;
//   end
// endmodule
`timescale 1ns / 1ps

class transaction;
  rand logic [ 3:0] PADDR;
  rand logic [31:0] PWDATA;
  rand logic        PWRITE;
  rand logic        PENABLE;
  rand logic        PSEL;
  logic      [31:0] PRDATA;
  logic             PREADY;
  // 틸트 센서 입력값을 랜덤으로 생성
  rand logic        tilt_sensor;

  function void display(string tag);
    $display("[%s] PADDR=%h, PWDATA=%h, PWRITE=%b, PENABLE=%b, PSEL=%b, PRDATA=%h, PREADY=%b, tilt_sensor=%b",
              tag, PADDR, PWDATA, PWRITE, PENABLE, PSEL, PRDATA, PREADY, tilt_sensor);
  endfunction
endclass

interface APB_Slave_Interface;
  // global signal
  logic        PCLK;
  logic        PRESET;
  // APB Interface Signals
  logic [ 3:0] PADDR;
  logic [31:0] PWDATA;
  logic        PWRITE;
  logic        PENABLE;
  logic        PSEL;
  logic [31:0] PRDATA;
  logic        PREADY;
  // 틸트 센서 신호
  logic        tilt_sensor;
endinterface

class generator;
  mailbox #(transaction) Gen2Drv_mbox;
  event gen_next_event;

  function new(mailbox#(transaction) Gen2Drv_mbox, event gen_next_event);
    this.Gen2Drv_mbox   = Gen2Drv_mbox;
    this.gen_next_event = gen_next_event;
  endfunction

  task run(int repeat_counter);
    transaction tilt_tr;
    repeat (repeat_counter) begin
      tilt_tr = new();
      if (!tilt_tr.randomize()) $error("Randomization fail!");
      tilt_tr.display("GEN");
      Gen2Drv_mbox.put(tilt_tr);
      @(gen_next_event);
    end
  endtask
endclass

class driver;
  virtual APB_Slave_Interface tilt_intf;
  mailbox #(transaction) Gen2Drv_mbox;
  transaction tilt_tr;

  function new(virtual APB_Slave_Interface tilt_intf, mailbox#(transaction) Gen2Drv_mbox);
    this.tilt_intf = tilt_intf;
    this.Gen2Drv_mbox = Gen2Drv_mbox;
  endfunction

  task run();
    forever begin
      Gen2Drv_mbox.get(tilt_tr);
      tilt_tr.display("DRV");
      @(posedge tilt_intf.PCLK);
      
      // 틸트 센서 값 설정
      tilt_intf.tilt_sensor <= tilt_tr.tilt_sensor;
      
      // APB 버스 설정
      tilt_intf.PADDR <= tilt_tr.PADDR;
      tilt_intf.PWDATA <= tilt_tr.PWDATA;
      tilt_intf.PWRITE <= tilt_tr.PWRITE;
      tilt_intf.PENABLE <= 1'b0;
      tilt_intf.PSEL <= 1'b1;
      
      @(posedge tilt_intf.PCLK);
      tilt_intf.PENABLE <= 1'b1;
      wait (tilt_intf.PREADY == 1'b1);
      @(posedge tilt_intf.PCLK);
      
      // 버스 리셋
      tilt_intf.PENABLE <= 1'b0;
      tilt_intf.PSEL <= 1'b0;
      
      @(posedge tilt_intf.PCLK);
    end
  endtask
endclass

class monitor;
  mailbox #(transaction) Mon2SCB_mbox;
  virtual APB_Slave_Interface tilt_intf;
  transaction tilt_tr;

  function new(virtual APB_Slave_Interface tilt_intf, mailbox#(transaction) Mon2SCB_mbox);
    this.tilt_intf = tilt_intf;
    this.Mon2SCB_mbox = Mon2SCB_mbox;
  endfunction

  task run();
    forever begin
      tilt_tr = new();
      wait (tilt_intf.PREADY == 1'b1);
      #1;
      
      // 현재 상태 캡처
      tilt_tr.PADDR = tilt_intf.PADDR;
      tilt_tr.PWDATA = tilt_intf.PWDATA;
      tilt_tr.PWRITE = tilt_intf.PWRITE;
      tilt_tr.PENABLE = tilt_intf.PENABLE;
      tilt_tr.PSEL = tilt_intf.PSEL;
      tilt_tr.PRDATA = tilt_intf.PRDATA;
      tilt_tr.PREADY = tilt_intf.PREADY;
      tilt_tr.tilt_sensor = tilt_intf.tilt_sensor;
      
      tilt_tr.display("MON");
      Mon2SCB_mbox.put(tilt_tr);
      @(posedge tilt_intf.PCLK);
    end
  endtask
endclass

class scoreboard;
  mailbox #(transaction) Mon2SCB_mbox;
  transaction tilt_tr;
  event gen_next_event;

  function new(mailbox#(transaction) Mon2SCB_mbox, event gen_next_event);
    this.Mon2SCB_mbox = Mon2SCB_mbox;
    this.gen_next_event = gen_next_event;
  endfunction

  task run();
    forever begin
      Mon2SCB_mbox.get(tilt_tr);
      tilt_tr.display("SCB");
      
      // 읽기 작업인 경우, 틸트 센서 값과 레지스터 값 비교
      if (!tilt_tr.PWRITE && tilt_tr.PADDR[3:2] == 2'd0) begin
        if (tilt_tr.PRDATA[0] == tilt_tr.tilt_sensor) begin
          $display("PASS: Tilt Sensor value correctly reported in register");
        end else begin
          $display("FAIL: Tilt Sensor value mismatch! Sensor=%b, Register=%b", 
                   tilt_tr.tilt_sensor, tilt_tr.PRDATA[0]);
        end
      end
      
      ->gen_next_event;  // 다음 트랜잭션으로 진행
    end
  endtask
endclass

class environment;
  mailbox #(transaction) Gen2Drv_mbox;
  mailbox #(transaction) Mon2SCB_mbox;

  generator tilt_gen;
  driver tilt_drv;
  monitor tilt_mon;
  scoreboard tilt_scb;

  event gen_next_event;

  function new(virtual APB_Slave_Interface tilt_intf);
    this.Gen2Drv_mbox = new();
    this.Mon2SCB_mbox = new();
    this.tilt_gen = new(Gen2Drv_mbox, gen_next_event);
    this.tilt_drv = new(tilt_intf, Gen2Drv_mbox);
    this.tilt_mon = new(tilt_intf, Mon2SCB_mbox);
    this.tilt_scb = new(Mon2SCB_mbox, gen_next_event);
  endfunction

  task run(int count);
    fork
      tilt_gen.run(count);
      tilt_drv.run();
      tilt_mon.run();
      tilt_scb.run();
    join_any;
  endtask
endclass

module tb_tilt ();
  environment tilt_env;
  APB_Slave_Interface tilt_intf ();

  // 클럭 생성
  always #5 tilt_intf.PCLK = ~tilt_intf.PCLK;

  // DUT 인스턴스
  tilt dut (
    // global signal
    .PCLK       (tilt_intf.PCLK),
    .PRESET     (tilt_intf.PRESET),
    // APB Interface Signals
    .PADDR      (tilt_intf.PADDR),
    .PWDATA     (tilt_intf.PWDATA),
    .PWRITE     (tilt_intf.PWRITE),
    .PENABLE    (tilt_intf.PENABLE),
    .PSEL       (tilt_intf.PSEL),
    .PRDATA     (tilt_intf.PRDATA),
    .PREADY     (tilt_intf.PREADY),
    // IP input signal
    .tilt_sensor(tilt_intf.tilt_sensor)
  );

  // 테스트 시작
  initial begin
    // 초기화
    tilt_intf.PCLK = 0;
    tilt_intf.PRESET = 1;
    #10 tilt_intf.PRESET = 0;
    
    // 테스트 환경 생성 및 실행
    tilt_env = new(tilt_intf);
    tilt_env.run(200);
    
    // 추가 테스트 주기
    #100;
    
    // 시뮬레이션 종료
    $display("Simulation completed");

    $finish;
  end
endmodule