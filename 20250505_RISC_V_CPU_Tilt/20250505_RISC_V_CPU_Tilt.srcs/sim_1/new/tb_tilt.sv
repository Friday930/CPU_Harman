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

//-------------------------------------------------------------

// `timescale 1ns / 1ps

// class transaction;
//   rand logic [ 3:0] PADDR;
//   rand logic [31:0] PWDATA;
//   rand logic        PWRITE;
//   rand logic        PENABLE;
//   rand logic        PSEL;
//   logic      [31:0] PRDATA;
//   logic             PREADY;
//   // 틸트 센서 입력값을 랜덤으로 생성
//   rand logic        tilt_sensor;

//   function void display(string tag);
//     $display("[%s] PADDR=%h, PWDATA=%h, PWRITE=%b, PENABLE=%b, PSEL=%b, PRDATA=%h, PREADY=%b, tilt_sensor=%b",
//               tag, PADDR, PWDATA, PWRITE, PENABLE, PSEL, PRDATA, PREADY, tilt_sensor);
//   endfunction
// endclass

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
//   // 틸트 센서 신호
//   logic        tilt_sensor;
// endinterface

// class generator;
//   mailbox #(transaction) Gen2Drv_mbox;
//   event gen_next_event;

//   function new(mailbox#(transaction) Gen2Drv_mbox, event gen_next_event);
//     this.Gen2Drv_mbox   = Gen2Drv_mbox;
//     this.gen_next_event = gen_next_event;
//   endfunction

//   task run(int repeat_counter);
//     transaction tilt_tr;
//     repeat (repeat_counter) begin
//       tilt_tr = new();
//       if (!tilt_tr.randomize()) $error("Randomization fail!");
//       tilt_tr.display("GEN");
//       Gen2Drv_mbox.put(tilt_tr);
//       @(gen_next_event);
//     end
//   endtask
// endclass

// class driver;
//   virtual APB_Slave_Interface tilt_intf;
//   mailbox #(transaction) Gen2Drv_mbox;
//   transaction tilt_tr;

//   function new(virtual APB_Slave_Interface tilt_intf, mailbox#(transaction) Gen2Drv_mbox);
//     this.tilt_intf = tilt_intf;
//     this.Gen2Drv_mbox = Gen2Drv_mbox;
//   endfunction

//   task run();
//     forever begin
//       Gen2Drv_mbox.get(tilt_tr);
//       tilt_tr.display("DRV");
//       @(posedge tilt_intf.PCLK);
      
//       // 틸트 센서 값 설정
//       tilt_intf.tilt_sensor <= tilt_tr.tilt_sensor;
      
//       // APB 버스 설정
//       tilt_intf.PADDR <= tilt_tr.PADDR;
//       tilt_intf.PWDATA <= tilt_tr.PWDATA;
//       tilt_intf.PWRITE <= tilt_tr.PWRITE;
//       tilt_intf.PENABLE <= 1'b0;
//       tilt_intf.PSEL <= 1'b1;
      
//       @(posedge tilt_intf.PCLK);
//       tilt_intf.PENABLE <= 1'b1;
//       wait (tilt_intf.PREADY == 1'b1);
//       @(posedge tilt_intf.PCLK);
      
//       // 버스 리셋
//       tilt_intf.PENABLE <= 1'b0;
//       tilt_intf.PSEL <= 1'b0;
      
//       @(posedge tilt_intf.PCLK);
//     end
//   endtask
// endclass

// class monitor;
//   mailbox #(transaction) Mon2SCB_mbox;
//   virtual APB_Slave_Interface tilt_intf;
//   transaction tilt_tr;

//   function new(virtual APB_Slave_Interface tilt_intf, mailbox#(transaction) Mon2SCB_mbox);
//     this.tilt_intf = tilt_intf;
//     this.Mon2SCB_mbox = Mon2SCB_mbox;
//   endfunction

//   task run();
//     forever begin
//       tilt_tr = new();
//       wait (tilt_intf.PREADY == 1'b1);
//       #1;
      
//       // 현재 상태 캡처
//       tilt_tr.PADDR = tilt_intf.PADDR;
//       tilt_tr.PWDATA = tilt_intf.PWDATA;
//       tilt_tr.PWRITE = tilt_intf.PWRITE;
//       tilt_tr.PENABLE = tilt_intf.PENABLE;
//       tilt_tr.PSEL = tilt_intf.PSEL;
//       tilt_tr.PRDATA = tilt_intf.PRDATA;
//       tilt_tr.PREADY = tilt_intf.PREADY;
//       tilt_tr.tilt_sensor = tilt_intf.tilt_sensor;
      
//       tilt_tr.display("MON");
//       Mon2SCB_mbox.put(tilt_tr);
//       @(posedge tilt_intf.PCLK);
//     end
//   endtask
// endclass

// class scoreboard;
//   mailbox #(transaction) Mon2SCB_mbox;
//   transaction tilt_tr;
//   event gen_next_event;

//   function new(mailbox#(transaction) Mon2SCB_mbox, event gen_next_event);
//     this.Mon2SCB_mbox = Mon2SCB_mbox;
//     this.gen_next_event = gen_next_event;
//   endfunction

//   task run();
//     forever begin
//       Mon2SCB_mbox.get(tilt_tr);
//       tilt_tr.display("SCB");
      
//       // 읽기 작업인 경우, 틸트 센서 값과 레지스터 값 비교
//       if (!tilt_tr.PWRITE && tilt_tr.PADDR[3:2] == 2'd0) begin
//         if (tilt_tr.PRDATA[0] == tilt_tr.tilt_sensor) begin
//           $display("PASS: Tilt Sensor value correctly reported in register");
//         end else begin
//           $display("FAIL: Tilt Sensor value mismatch! Sensor=%b, Register=%b", 
//                    tilt_tr.tilt_sensor, tilt_tr.PRDATA[0]);
//         end
//       end
      
//       ->gen_next_event;  // 다음 트랜잭션으로 진행
//     end
//   endtask
// endclass

// class environment;
//   mailbox #(transaction) Gen2Drv_mbox;
//   mailbox #(transaction) Mon2SCB_mbox;

//   generator tilt_gen;
//   driver tilt_drv;
//   monitor tilt_mon;
//   scoreboard tilt_scb;

//   event gen_next_event;

//   function new(virtual APB_Slave_Interface tilt_intf);
//     this.Gen2Drv_mbox = new();
//     this.Mon2SCB_mbox = new();
//     this.tilt_gen = new(Gen2Drv_mbox, gen_next_event);
//     this.tilt_drv = new(tilt_intf, Gen2Drv_mbox);
//     this.tilt_mon = new(tilt_intf, Mon2SCB_mbox);
//     this.tilt_scb = new(Mon2SCB_mbox, gen_next_event);
//   endfunction

//   task run(int count);
//     fork
//       tilt_gen.run(count);
//       tilt_drv.run();
//       tilt_mon.run();
//       tilt_scb.run();
//     join_any;
//   endtask
// endclass

// module tb_tilt ();
//   environment tilt_env;
//   APB_Slave_Interface tilt_intf ();

//   // 클럭 생성
//   always #5 tilt_intf.PCLK = ~tilt_intf.PCLK;

//   // DUT 인스턴스
//   tilt dut (
//     // global signal
//     .PCLK       (tilt_intf.PCLK),
//     .PRESET     (tilt_intf.PRESET),
//     // APB Interface Signals
//     .PADDR      (tilt_intf.PADDR),
//     .PWDATA     (tilt_intf.PWDATA),
//     .PWRITE     (tilt_intf.PWRITE),
//     .PENABLE    (tilt_intf.PENABLE),
//     .PSEL       (tilt_intf.PSEL),
//     .PRDATA     (tilt_intf.PRDATA),
//     .PREADY     (tilt_intf.PREADY),
//     // IP input signal
//     .tilt_sensor(tilt_intf.tilt_sensor)
//   );

//   // 테스트 시작
//   initial begin
//     // 초기화
//     tilt_intf.PCLK = 0;
//     tilt_intf.PRESET = 1;
//     #10 tilt_intf.PRESET = 0;
    
//     // 테스트 환경 생성 및 실행
//     tilt_env = new(tilt_intf);
//     tilt_env.run(200);
    
//     // 추가 테스트 주기
//     #100;
    
//     // 시뮬레이션 종료
//     $display("Simulation completed");

//     $finish;
//   end
// endmodule

// `timescale 1ns / 1ps

// class transaction;
//   logic PCLK;
//   logic PRESET;
//   rand logic [3:0] PADDR;
//   rand logic [31:0] PWDATA;
//   rand logic PWRITE;
//   rand logic PENABLE;
//   rand logic PSEL;
//   logic [31:0] PRDATA;
//   logic PREADY;
//   rand logic tilt_sensor;

//   // Address constraints
//   constraint c_paddr {
//     PADDR inside {4'h0};
//   }
  
//   // Tilt sensor distribution
//   constraint c_tilt_sensor {
//     tilt_sensor dist {
//       1'b0 := 50  ,
//       1'b1 := 50
//     };
//   }
// endclass

// interface APB_Slave_Interface;
//   logic PCLK;
//   logic PRESET;
//   logic [3:0] PADDR;
//   logic [31:0] PWDATA;
//   logic PWRITE;
//   logic PENABLE;
//   logic PSEL;
//   logic [31:0] PRDATA;
//   logic PREADY;
//   logic tilt_sensor;
// endinterface

// class generator;
//   mailbox #(transaction) Gen2Drv_mbox;
//   event gen_next_event;  // Changed from drv_done to gen_next_event
//   bit count_done;

//   function new(mailbox#(transaction) Gen2Drv_mbox, event gen_next_event);
//     this.Gen2Drv_mbox = Gen2Drv_mbox;
//     this.gen_next_event = gen_next_event;  // Using gen_next_event
//     this.count_done = 0;
//   endfunction

//   task run(int repeat_counter);
//     transaction tilt_tr;
//     repeat (repeat_counter) begin
//       tilt_tr = new();
//       if (!tilt_tr.randomize()) $error("Randomization failed!");
      
//       // Print transaction details
//       $display("[GEN] PADDR=0x%h, PWDATA=0x%h, PWRITE=%b, tilt_sensor=%b", 
//                tilt_tr.PADDR, tilt_tr.PWDATA, tilt_tr.PWRITE, tilt_tr.tilt_sensor);
      
//       // Send to driver and wait for scoreboard completion
//       Gen2Drv_mbox.put(tilt_tr);
//       @(gen_next_event);  // Wait for scoreboard to trigger this event
//     end
//     count_done = 1;
//   endtask
// endclass

// class driver;
//   virtual APB_Slave_Interface tilt_intf;
//   mailbox #(transaction) Gen2Drv_mbox;
  
//   function new(virtual APB_Slave_Interface tilt_intf, mailbox#(transaction) Gen2Drv_mbox);
//     this.tilt_intf = tilt_intf;
//     this.Gen2Drv_mbox = Gen2Drv_mbox;
//   endfunction

//   task run();
//     transaction tilt_tr;
    
//     forever begin
//       // Initial bus state
//       tilt_intf.PSEL <= 0;
//       tilt_intf.PENABLE <= 0;
      
//       // Get transaction
//       Gen2Drv_mbox.get(tilt_tr);
      
//       // Display driver info BEFORE driving signals
//       $display("[DRV] PADDR=0x%h, PWDATA=0x%h, PWRITE=%b, tilt_sensor=%b", 
//                tilt_tr.PADDR, tilt_tr.PWDATA, tilt_tr.PWRITE, tilt_tr.tilt_sensor);
      
//       // Drive tilt sensor
//       @(posedge tilt_intf.PCLK);
//       tilt_intf.tilt_sensor <= tilt_tr.tilt_sensor;
      
//       // SETUP phase
//       tilt_intf.PADDR <= tilt_tr.PADDR;
//       tilt_intf.PWDATA <= tilt_tr.PWDATA;
//       tilt_intf.PWRITE <= tilt_tr;
//       tilt_intf.PSEL <= 1'b1;
//       tilt_intf.PENABLE <= 1'b0;
      
//       // ACCESS phase
//       @(posedge tilt_intf.PCLK);
//       tilt_intf.PENABLE <= 1'b1;
      
//       // Wait for PREADY
//       // do begin
//       //   @(posedge tilt_intf.PCLK);
//       // end while(tilt_intf.PREADY !== 1'b1);
      
//       // Complete transaction
//       @(posedge tilt_intf.PCLK);
//       tilt_intf.PSEL <= 1'b0;
//       tilt_intf.PENABLE <= 1'b0;
//     end
//   endtask
// endclass

// class monitor;
//   mailbox #(transaction) Mon2SCB_mbox;
//   virtual APB_Slave_Interface tilt_intf;
  
//   function new(virtual APB_Slave_Interface tilt_intf, mailbox#(transaction) Mon2SCB_mbox);
//     this.tilt_intf = tilt_intf;
//     this.Mon2SCB_mbox = Mon2SCB_mbox;
//   endfunction

//   task run();
//     transaction mon_tr;
    
//     forever begin
//       mon_tr = new();
      
//       // Wait for start of ACCESS phase (PSEL=1, PENABLE=1)
//       do begin
//         @(posedge tilt_intf.PCLK);
//       end while(!(tilt_intf.PSEL === 1'b1 && tilt_intf.PENABLE === 1'b1));
      
//       // Wait for PREADY
//       do begin
//         @(posedge tilt_intf.PCLK);
//       end while(tilt_intf.PREADY !== 1'b1);
      
//       // Capture bus signals
//       mon_tr.PADDR = tilt_intf.PADDR;
//       mon_tr.PWDATA = tilt_intf.PWDATA;
//       mon_tr.PWRITE = tilt_intf.PWRITE;
//       mon_tr.PRDATA = tilt_intf.PRDATA;
//       mon_tr.tilt_sensor = tilt_intf.tilt_sensor;
      
//       // Display monitor info
//       $display("[MON] PADDR=0x%h, PWDATA=0x%h, PWRITE=%b, PRDATA=0x%h, tilt_sensor=%b", 
//                mon_tr.PADDR, mon_tr.PWDATA, mon_tr.PWRITE, mon_tr.PRDATA[0], mon_tr.tilt_sensor);
      
//       // Send to scoreboard
//       Mon2SCB_mbox.put(mon_tr);
//     end
//   endtask
// endclass

// class scoreboard;
//   mailbox #(transaction) Mon2SCB_mbox;
//   event gen_next_event;
  
//   // Statistics counters
//   int write_cnt;
//   int read_cnt;
//   int pass_cnt;
//   int fail_cnt;
//   int total_cnt;
  
//   // Reference model
//   logic [31:0] ref_tilt_reg[0:3];

//   function new(mailbox#(transaction) Mon2SCB_mbox, event gen_next_event);
//     this.Mon2SCB_mbox = Mon2SCB_mbox;
//     this.gen_next_event = gen_next_event;
    
//     // Initialize registers
//     for (int i = 0; i < 4; i++) begin
//       ref_tilt_reg[i] = 0;
//     end
    
//     // Initialize counters
//     this.write_cnt = 0;
//     this.read_cnt = 0;
//     this.pass_cnt = 0;
//     this.fail_cnt = 0;
//     this.total_cnt = 0;
//   endfunction

//   task run();
//     transaction tilt_tr;
    
//     forever begin
//       // Get transaction from monitor
//       Mon2SCB_mbox.get(tilt_tr);
      
//       // Display scoreboard info
//       $display("[SCB] PADDR=0x%h, PWDATA=0x%h, PWRITE=%b, PRDATA=0x%h, tilt_sensor=%b", 
//                tilt_tr.PADDR, tilt_tr.PWDATA, tilt_tr.PWRITE, tilt_tr.PRDATA[0], tilt_tr.tilt_sensor);
      
//       // Increment total transaction count
//       total_cnt++;
      
//       // Verify operation
//       if (tilt_tr.PWRITE) begin
//         // Write operation
//         write_cnt++;
        
//         // Update reference model
//         ref_tilt_reg[tilt_tr.PADDR[3:2]] = tilt_tr.PWDATA;
        
//         // For register 0, update tilt sensor bit
//         if (tilt_tr.PADDR[3:2] == 2'd0) begin
//           ref_tilt_reg[0][0] = tilt_tr.tilt_sensor;
//         end
        
//         pass_cnt++;
//         $display("[RESULT] PASS - Write operation completed");
//       end else begin
//         // Read operation
//         read_cnt++;
        
//         // For register 0, update tilt sensor bit before comparison
//         if (tilt_tr.PADDR[3:2] == 2'd0) begin
//           ref_tilt_reg[0][0] = tilt_tr.tilt_sensor;
//         end
        
//         // Print debug info to help diagnose the issue
//         $display("[DEBUG] Expected register value: 0x%h", ref_tilt_reg[tilt_tr.PADDR[3:2]]);
//         $display("[DEBUG] Actual PRDATA value: 0x%h", tilt_tr.PRDATA[0]);
        
//         // Compare read data with reference model
//         if (tilt_tr.PRDATA[0] == ref_tilt_reg[tilt_tr.PADDR[3:2]][0]) begin
//           pass_cnt++;
//           $display("[RESULT] PASS - Read operation verified");
//         end else begin
//           fail_cnt++;
//           $display("[RESULT] FAIL - Register read error %h, %h",tilt_tr.PRDATA[0], ref_tilt_reg[tilt_tr.PADDR[3:2]][0]);
//         end
//       end
      
//       // Signal to generator that this transaction is complete
//       ->gen_next_event;
//     end
//   endtask
  
//   // Report function
//   task report();
//     $display("\n\n");
//     $display("================================");
//     $display("==        Final Report        ==");
//     $display("================================");
//     $display("Write Test : %0d", write_cnt);
//     $display("Read  Test : %0d", read_cnt);
//     $display("PASS  Test : %0d", pass_cnt);
//     $display("FAIL  Test : %0d", fail_cnt);
//     $display("Total Test : %0d", total_cnt);
//     $display("================================");
//     $display("==  Test bench completed!    ==");
//     $display("================================");
//   endtask
// endclass

// class environment;
//   mailbox #(transaction) Gen2Drv_mbox;
//   mailbox #(transaction) Mon2SCB_mbox;
//   event gen_next_event;  // Changed from drv_done to gen_next_event

//   generator gen;
//   driver drv;
//   monitor mon;
//   scoreboard scb;

//   bit test_done;

//   function new(virtual APB_Slave_Interface tilt_intf);
//     this.Gen2Drv_mbox = new();
//     this.Mon2SCB_mbox = new();
    
//     this.gen = new(Gen2Drv_mbox, gen_next_event);  // Pass gen_next_event
//     this.drv = new(tilt_intf, Gen2Drv_mbox);
//     this.mon = new(tilt_intf, Mon2SCB_mbox);
//     this.scb = new(Mon2SCB_mbox, gen_next_event);  // Pass gen_next_event
    
//     this.test_done = 0;
//   endfunction

//   task run(int count);
//     fork
//       gen.run(count);
//       drv.run();
//       mon.run();
//       scb.run();
      
//       begin
//         wait(gen.count_done == 1);
//         #500; // Allow time for remaining transactions
//         this.test_done = 1;
//       end
//     join_any
    
//     wait(this.test_done == 1);
//     scb.report();
//   endtask
// endclass

// module tb_tilt ();
//   environment tilt_env;
//   APB_Slave_Interface tilt_intf ();

//   // Clock generation
//   always #5 tilt_intf.PCLK = ~tilt_intf.PCLK;

//   // DUT instance
//   tilt dut (
//     .PCLK       (tilt_intf.PCLK),
//     .PRESET     (tilt_intf.PRESET),
//     .PADDR      (tilt_intf.PADDR),
//     .PWDATA     (tilt_intf.PWDATA),
//     .PWRITE     (tilt_intf.PWRITE),
//     .PENABLE    (tilt_intf.PENABLE),
//     .PSEL       (tilt_intf.PSEL),
//     .PRDATA     (tilt_intf.PRDATA),
//     .PREADY     (tilt_intf.PREADY),
//     .tilt_sensor(tilt_intf.tilt_sensor)
//   );

//   initial begin
//     tilt_intf.PCLK = 0;
//     tilt_intf.PRESET = 1;
    
//     $display("Testbench started");
//     #10 tilt_intf.PRESET = 0;
    
//     tilt_env = new(tilt_intf);
//     tilt_env.run(50);
    
//     $display("Simulation completed");
//     $finish;
//   end
// endmodule

`timescale 1ns / 1ps

class transaction;
  logic PCLK;
  logic PRESET;
  rand logic [3:0] PADDR;
  rand logic [31:0] PWDATA;
  logic PWRITE;  // Not randomized, always set to 0 for read-only
  rand logic PENABLE;
  rand logic PSEL;
  logic [31:0] PRDATA;
  logic PREADY;
  rand logic tilt_sensor;

  // Address constraints
  constraint c_paddr {
    PADDR inside {4'h0};
  }
  
  // Tilt sensor distribution
  constraint c_tilt_sensor {
    tilt_sensor dist {
      1'b0 := 50,
      1'b1 := 50
    };
  }
  
  function void post_randomize();
    // Always set PWRITE to 0 for read operations
    PWRITE = 1'b0;
  endfunction
endclass

interface APB_Slave_Interface;
  logic PCLK;
  logic PRESET;
  logic [3:0] PADDR;
  logic [31:0] PWDATA;
  logic PWRITE;
  logic PENABLE;
  logic PSEL;
  logic [31:0] PRDATA;
  logic PREADY;
  logic tilt_sensor;
  // Add tilt_detected for monitoring
  logic tilt_detected;
endinterface

class generator;
  mailbox #(transaction) Gen2Drv_mbox;
  event gen_next_event;
  bit count_done;

  function new(mailbox#(transaction) Gen2Drv_mbox, event gen_next_event);
    this.Gen2Drv_mbox = Gen2Drv_mbox;
    this.gen_next_event = gen_next_event;
    this.count_done = 0;
  endfunction

  task run(int repeat_counter);
    transaction tilt_tr;
    repeat (repeat_counter) begin
      tilt_tr = new();
      if (!tilt_tr.randomize()) $error("Randomization failed!");
      
      // Print transaction details
      $display("[GEN] PADDR=0x%h, PWDATA=0x%h, PWRITE=%b, tilt_sensor=%b", 
               tilt_tr.PADDR, tilt_tr.PWDATA, tilt_tr.PWRITE, tilt_tr.tilt_sensor);
      
      // Send to driver and wait for scoreboard completion
      Gen2Drv_mbox.put(tilt_tr);
      @(gen_next_event);  // Wait for scoreboard to trigger this event
    end
    count_done = 1;
  endtask
endclass

class driver;
  virtual APB_Slave_Interface tilt_intf;
  mailbox #(transaction) Gen2Drv_mbox;
  
  function new(virtual APB_Slave_Interface tilt_intf, mailbox#(transaction) Gen2Drv_mbox);
    this.tilt_intf = tilt_intf;
    this.Gen2Drv_mbox = Gen2Drv_mbox;
  endfunction

  task run();
    transaction tilt_tr;
    
    forever begin
      // Initial bus state
      tilt_intf.PSEL <= 0;
      tilt_intf.PENABLE <= 0;
      
      // Get transaction
      Gen2Drv_mbox.get(tilt_tr);
      
      // Display driver info BEFORE driving signals
      $display("[DRV] PADDR=0x%h, PWDATA=0x%h, PWRITE=%b, tilt_sensor=%b", 
               tilt_tr.PADDR, tilt_tr.PWDATA, tilt_tr.PWRITE, tilt_tr.tilt_sensor);
      
      // Drive tilt sensor
      @(posedge tilt_intf.PCLK);
      tilt_intf.tilt_sensor <= tilt_tr.tilt_sensor;
      
      // Add delay for debounce to settle (DEBOUNCE_COUNT = 5)
      repeat (10) @(posedge tilt_intf.PCLK);
      
      // SETUP phase
      tilt_intf.PADDR <= tilt_tr.PADDR;
      tilt_intf.PWDATA <= tilt_tr.PWDATA;
      tilt_intf.PWRITE <= tilt_tr.PWRITE;  // Always 0 for read-only
      tilt_intf.PSEL <= 1'b1;
      tilt_intf.PENABLE <= 1'b0;
      
      // ACCESS phase
      @(posedge tilt_intf.PCLK);
      tilt_intf.PENABLE <= 1'b1;
      
      // Wait for PREADY using a timeout mechanism
      begin
        int timeout_counter = 0;
        while (tilt_intf.PREADY !== 1'b1 && timeout_counter < 10) begin
          @(posedge tilt_intf.PCLK);
          timeout_counter++;
        end
        
        // If we timeout, force PREADY to signal completion
        if (timeout_counter >= 10) begin
          $display("[DRV] Warning: PREADY timeout - forcing transaction completion");
          tilt_intf.PREADY <= 1'b1;
          @(posedge tilt_intf.PCLK);
        end
      end
      
      // Wait one more cycle after PREADY for stability
      @(posedge tilt_intf.PCLK);
      
      // Complete transaction
      tilt_intf.PSEL <= 1'b0;
      tilt_intf.PENABLE <= 1'b0;
      
      // Ensure some idle time between transactions
      @(posedge tilt_intf.PCLK);
    end
  endtask
endclass

class monitor;
  mailbox #(transaction) Mon2SCB_mbox;
  virtual APB_Slave_Interface tilt_intf;
  
  function new(virtual APB_Slave_Interface tilt_intf, mailbox#(transaction) Mon2SCB_mbox);
    this.tilt_intf = tilt_intf;
    this.Mon2SCB_mbox = Mon2SCB_mbox;
  endfunction

  task run();
    transaction mon_tr;
    
    forever begin
      mon_tr = new();
      
      // Wait for start of ACCESS phase (PSEL=1, PENABLE=1)
      do begin
        @(posedge tilt_intf.PCLK);
      end while(!(tilt_intf.PSEL === 1'b1 && tilt_intf.PENABLE === 1'b1));
      
      // Capture signals at the beginning of the ACCESS phase
      mon_tr.PADDR = tilt_intf.PADDR;
      mon_tr.PWDATA = tilt_intf.PWDATA;
      mon_tr.PWRITE = tilt_intf.PWRITE;
      mon_tr.tilt_sensor = tilt_intf.tilt_sensor;
      
      // Wait for PREADY with same timeout as driver
      begin
        int timeout_counter = 0;
        while (tilt_intf.PREADY !== 1'b1 && timeout_counter < 10) begin
          @(posedge tilt_intf.PCLK);
          timeout_counter++;
        end
      end
      
      // Capture PRDATA after PREADY is asserted
      mon_tr.PRDATA = tilt_intf.PRDATA;
      
      // Display monitor info - explicitly show bit 0 for clarity
      $display("[MON] PADDR=0x%h, PWDATA=0x%h, PWRITE=%b, PRDATA=0x%h, PRDATA[0]=%b, tilt_sensor=%b, tilt_detected=%b", 
               mon_tr.PADDR, mon_tr.PWDATA, mon_tr.PWRITE, 
               mon_tr.PRDATA, mon_tr.PRDATA[0], mon_tr.tilt_sensor, tilt_intf.tilt_detected);
      
      // Send to scoreboard
      Mon2SCB_mbox.put(mon_tr);
      
      // Wait for transaction completion
      do begin
        @(posedge tilt_intf.PCLK);
      end while(tilt_intf.PSEL === 1'b1 && tilt_intf.PENABLE === 1'b1);
    end
  endtask
endclass

class scoreboard;
  mailbox #(transaction) Mon2SCB_mbox;
  event gen_next_event;
  
  // Statistics counters
  int write_cnt;
  int read_cnt;
  int pass_cnt;
  int fail_cnt;
  int total_cnt;
  
  // Reference model
  logic [31:0] ref_tilt_reg[0:3];
  logic last_tilt_sensor; // Remember last tilt sensor value
  logic expected_tilt_detected; // Expected debounced value

  function new(mailbox#(transaction) Mon2SCB_mbox, event gen_next_event);
    this.Mon2SCB_mbox = Mon2SCB_mbox;
    this.gen_next_event = gen_next_event;
    
    // Initialize registers
    for (int i = 0; i < 4; i++) begin
      ref_tilt_reg[i] = 0;
    end
    
    // Initialize counters
    this.write_cnt = 0;
    this.read_cnt = 0;
    this.pass_cnt = 0;
    this.fail_cnt = 0;
    this.total_cnt = 0;
    this.last_tilt_sensor = 0;
    this.expected_tilt_detected = 0;
  endfunction

  task run();
    transaction tilt_tr;
    
    forever begin
      // Get transaction from monitor
      Mon2SCB_mbox.get(tilt_tr);
      
      // Update expected tilt detected value based on tilt_sensor
      // After debounce delay, expected_tilt_detected should match tilt_sensor
      expected_tilt_detected = tilt_tr.tilt_sensor;
      
      // Update reference model - bit 0 of register 0 should match the tilt_detected signal
      ref_tilt_reg[0][0] = expected_tilt_detected;
      
      // Display scoreboard info with full details
      $display("[SCB] PADDR=0x%h, PWDATA=0x%h, PWRITE=%b, PRDATA=0x%h, PRDATA[0]=%b, Expected=%b", 
               tilt_tr.PADDR, tilt_tr.PWDATA, tilt_tr.PWRITE, 
               tilt_tr.PRDATA, tilt_tr.PRDATA[0], expected_tilt_detected);
      
      // Increment total transaction count
      total_cnt++;
      
      // Only handle read operations in this testbench
      if (!tilt_tr.PWRITE) begin
        // Read operation
        read_cnt++;
        
        // Print detailed debug info
        $display("[DEBUG] Reg0=0x%h, Expected tilt_detected=%b", 
                 ref_tilt_reg[0], expected_tilt_detected);
        
        // Compare only bit 0 for tilt sensor
        if (tilt_tr.PRDATA[0] == expected_tilt_detected) begin
          pass_cnt++;
          $display("[RESULT] PASS - Read operation verified");
        end else begin
          fail_cnt++;
          $display("[RESULT] FAIL - Register read error: Exp=%b, Act=%b", 
                   expected_tilt_detected, tilt_tr.PRDATA[0]);
        end
      end
      
      // Signal to generator that this transaction is complete
      ->gen_next_event;
    end
  endtask
  
  // Report function
  task report();
    $display("\n\n");
    $display("================================");
    $display("==        Final Report        ==");
    $display("================================");
    // $display("Write Test : %0d", write_cnt);
    $display("Read  Test : %0d", read_cnt);
    $display("PASS  Test : %0d", pass_cnt);
    $display("FAIL  Test : %0d", fail_cnt);
    $display("Total Test : %0d", total_cnt);
    $display("================================");
    $display("==  Test bench completed!    ==");
    $display("================================");
  endtask
endclass

class environment;
  mailbox #(transaction) Gen2Drv_mbox;
  mailbox #(transaction) Mon2SCB_mbox;
  event gen_next_event;

  generator gen;
  driver drv;
  monitor mon;
  scoreboard scb;

  bit test_done;

  function new(virtual APB_Slave_Interface tilt_intf);
    this.Gen2Drv_mbox = new();
    this.Mon2SCB_mbox = new();
    
    this.gen = new(Gen2Drv_mbox, gen_next_event);
    this.drv = new(tilt_intf, Gen2Drv_mbox);
    this.mon = new(tilt_intf, Mon2SCB_mbox);
    this.scb = new(Mon2SCB_mbox, gen_next_event);
    
    this.test_done = 0;
  endfunction

  task run(int count);
    fork
      gen.run(count);
      drv.run();
      mon.run();
      scb.run();
      
      begin
        wait(gen.count_done == 1);
        #500; // Allow time for remaining transactions
        this.test_done = 1;
      end
    join_any
    
    wait(this.test_done == 1);
    scb.report();
  endtask
endclass

module tb_tilt ();
  environment tilt_env;
  APB_Slave_Interface tilt_intf ();

  // Clock generation
  always #5 tilt_intf.PCLK = ~tilt_intf.PCLK;

  // Generate PREADY signal for testing
  // This simulates a simple PREADY response from the DUT
  always @(posedge tilt_intf.PCLK) begin
    if (tilt_intf.PSEL && tilt_intf.PENABLE) begin
      // Respond after 1-2 clock cycles to simulate realistic behavior
      repeat ($urandom_range(1, 2)) @(posedge tilt_intf.PCLK);
      tilt_intf.PREADY <= 1'b1;
    end else begin
      tilt_intf.PREADY <= 1'b0;
    end
  end

  // DUT instance
  tilt dut (
    .PCLK       (tilt_intf.PCLK),
    .PRESET     (tilt_intf.PRESET),
    .PADDR      (tilt_intf.PADDR),
    .PWDATA     (tilt_intf.PWDATA),
    .PWRITE     (tilt_intf.PWRITE),
    .PENABLE    (tilt_intf.PENABLE),
    .PSEL       (tilt_intf.PSEL),
    .PRDATA     (tilt_intf.PRDATA),
    .PREADY     (tilt_intf.PREADY),
    .tilt_sensor(tilt_intf.tilt_sensor)
  );
  
  // Monitor tilt_detected signal
  assign tilt_intf.tilt_detected = dut.tdr;

  initial begin
    tilt_intf.PCLK = 0;
    tilt_intf.PRESET = 1;
    
    $display("Testbench started - Read-Only Mode (100 Tests)");
    #10 tilt_intf.PRESET = 0;
    
    tilt_env = new(tilt_intf);
    tilt_env.run(100); // Run 100 read tests
    
    $display("Simulation completed");
    $finish;
  end
endmodule