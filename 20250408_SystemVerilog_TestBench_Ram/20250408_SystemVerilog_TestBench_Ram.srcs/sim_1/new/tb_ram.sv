`timescale 1ns / 1ps

interface ram_intf (
    input bit clk
);
    logic [4:0] addr;
    logic [7:0] wData;
    logic       we;
    logic [7:0] rData;

    clocking cb @(posedge clk);  // 타이밍 맞춰주는 기능 (tb 기준으로 방향 정한다)
        default input #1 output #1;
        output addr, wData, we;  // tb가 dut에게 준다
        input rData;  // tb가 dut에서 가져온다 
    endclocking

endinterface  //ram_intf

class transaction;
    rand logic [4:0] addr;
    rand logic [7:0] wData;
    logic      [7:0] rData;  // RAM 입장에서는 출력값
    rand logic       we;

    task display(string name);
        $display("[%S] addr = %h, wData = %h, we = %d, rData = %h", name, addr,
                 wData, we, rData);
    endtask  //
endclass  //transaction

class generator;
    mailbox #(transaction) GenToDrv_mbox;

    function new(mailbox#(transaction) GenToDrv_mbox);
        this.GenToDrv_mbox = GenToDrv_mbox;  // reference 값 넣음
    endfunction  //new()

    task run(int repeat_counter);  // 몇번 돌지 결정
        transaction ram_tr;  // transaction 정보(handler)
        repeat (repeat_counter) begin
            ram_tr = new();  // handler에 인스턴스 값 받음(transaction 생성)
            if (!ram_tr.randomize()) begin  // random이 안됐을때
                $error("Randomization failed");
            end
            ram_tr.display("GEN");
            GenToDrv_mbox.put(ram_tr);  // mailbox에 집어넣음
        end
    endtask  //
endclass  //generator

class driver;
    mailbox #(transaction) GenToDrv_mbox;
    virtual ram_intf ram_if;

    function new(mailbox#(transaction) GenToDrv_mbox, virtual ram_intf ram_if);
        this.GenToDrv_mbox = GenToDrv_mbox;
        this.ram_if = ram_if;
    endfunction  //new()

    task run();
        transaction ram_tr;
        forever begin
            @(ram_if.cb);
            GenToDrv_mbox.get(
                ram_tr); // mailbox에서 값을 가져와 ram_tr에 집어넣음, mailbox에 값 없으면 대기
            // hardware <= software
            ram_if.cb.addr  <= ram_tr.addr;  // sw값을 hw에 던짐
            ram_if.cb.wData <= ram_tr.wData;
            ram_if.cb.we    <= ram_tr.we;
            ram_tr.display("DRV");
            // @(posedge ram_if.clk);  // 한 클럭 기다림
            @(ram_if.cb);
            ram_if.cb.we <= 1'b0;
        end
    endtask  //

endclass  //driver

class monitor;
    mailbox #(transaction) MonToSCB_mbox;
    virtual ram_intf ram_if;  // 인터페이스 연결

    function new(mailbox#(transaction) MonToSCB_mbox, virtual ram_intf ram_if);
        this.MonToSCB_mbox = MonToSCB_mbox;
        this.ram_if = ram_if;
    endfunction  //new()

    task run();
        transaction ram_tr;
        forever begin
            // @(posedge ram_if.clk); // driver에서 클럭이 발생할 때 까지 기다림
            @(ram_if.cb);
            ram_tr = new();
            // software는 non-blocking 개념이 없음
            ram_tr.addr  = ram_if.addr;
            ram_tr.wData = ram_if.wData;
            ram_tr.we    = ram_if.we;
            ram_tr.rData = ram_if.rData;
            ram_tr.display("MON");
            MonToSCB_mbox.put(ram_tr);
        end  // hw 신호를 sw 신호로 넘겨주고 mailbox에 넣음
    endtask  //
endclass  //monitor

class scoreboard;
    mailbox #(transaction) MonToSCB_mbox;

    logic [7:0] ref_model[0:(2**5)-1];
    function new(mailbox#(transaction) MonToSCB_mbox);
        this.MonToSCB_mbox = MonToSCB_mbox;
        foreach (ref_model[i])
            ref_model[i] = 0; // ref_model 배열 개수만큼 반복하며 0 집어넣음
    endfunction  //new()

    task run();
        transaction ram_tr;
        forever begin
            MonToSCB_mbox.get(ram_tr);
            ram_tr.display("SCB");
            if (ram_tr.we) begin  // write
                ref_model[ram_tr.addr] = ram_tr.wData;
            end else begin  // read
                if (ref_model[ram_tr.addr] === ram_tr.rData) begin
                    $display(
                        "PASS, Matched Data   ref_model : %h === rData : %h",
                        ref_model[ram_tr.addr], ram_tr.rData);
                end else begin
                    $display(
                        "FAIL, Dismatched Data   ref_model : %h === rData : %h",
                        ref_model[ram_tr.addr], ram_tr.rData);
                end
            end
        end
    endtask  //
endclass  //scoreboard

class environment;
    mailbox #(transaction) GenToDrv_mbox;
    mailbox #(transaction) MonToSCB_mbox;
    generator              ram_gen;
    driver                 ram_drv;
    monitor                ram_mon;
    scoreboard             ram_scb;

    function new(virtual ram_intf ram_if);
        GenToDrv_mbox = new();
        MonToSCB_mbox = new();
        ram_gen = new(GenToDrv_mbox);
        ram_drv = new(GenToDrv_mbox, ram_if);
        ram_mon = new(MonToSCB_mbox, ram_if);
        ram_scb = new(MonToSCB_mbox);
    endfunction  //new()

    task run(int count);
        fork
            ram_gen.run(count);
            ram_drv.run();
            ram_mon.run();
            ram_scb.run();
        join_any
    endtask  //
endclass  //environment


module tb_ram ();
    bit clk;
    environment env;

    ram_intf ram_if (clk);

    // ram dut (.intf(ram_intf));
    ram dut (.intf(ram_if));

    always #5 clk = ~clk;
    initial begin
        clk = 0;
        env = new(ram_if);
        env.run(10);
        #50;
        $finish;
    end
endmodule
