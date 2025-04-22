`timescale 1ns / 1ps

class transaction;
    // APB Interface Signals
    rand logic [ 3:0] PADDR;
    rand logic [31:0] PWDATA;
    rand logic        PWRITE;
    rand logic        PENABLE;
    rand logic        PSEL;
    logic      [31:0] PRDATA;  // dut out data
    logic             PREADY;  // dut out data
    // outport signals
    logic      [ 3:0] fndCom;  // dut out data
    logic      [ 7:0] fndFont;  // dut out data

    // 제약 사항
    constraint c_paddr {PADDR inside {4'h0, 4'h4, 4'h8};}
    constraint c_wdata {PWDATA < 10;}

    task display(string name);
        $display(
            "[%s] PADDR=%h, PWDATA=%h, PWRITE=%h, PENABLE=%h, PSEL=%h, PRDATA=%h, PREADY=%h, fndCom=%h, fndFont=%h",
            name, PADDR, PWDATA, PWRITE, PENABLE, PSEL, PRDATA, PREADY, fndCom,
            fndFont);
    endtask  //

endclass  //transaction -> intf 입력값

interface APB_Slave_Interface;
    logic        PCLK;
    logic        PRESET;
    logic [ 3:0] PADDR;
    logic [31:0] PWDATA;
    logic        PWRITE;
    logic        PENABLE;
    logic        PSEL;
    logic [31:0] PRDATA;  // dut out data
    logic        PREADY;  // dut out data
    // outport signals
    logic [ 3:0] fndCom;  // dut out data
    logic [ 7:0] fndFont;  // dut out data

endinterface  //APB_Slave_Interface

class generator;
    mailbox #(transaction) Gen2Drv_mbox;  // ref값을 받음
    event gen_next_event;

    function new(mailbox#(transaction) Gen2Drv_mbox, event gen_next_event);
        this.Gen2Drv_mbox   = Gen2Drv_mbox;
        this.gen_next_event = gen_next_event;
    endfunction  //new()

    task run(int repeat_counter);
        transaction fnd_tr;
        repeat (repeat_counter) begin
            fnd_tr = new();  // make instance (실체화)
            if (!fnd_tr.randomize()) begin
                $error("Randomization fail");
            end
            fnd_tr.display("GEN");
            Gen2Drv_mbox.put(fnd_tr);
            @(gen_next_event);  // wait event until driver come
        end
    endtask  //
endclass  //generator

class driver;
    virtual APB_Slave_Interface fnd_interf;
    mailbox #(transaction) Gen2Drv_mbox;
    event gen_next_event;
    transaction fnd_tr;

    function new(virtual APB_Slave_Interface fnd_interf,
                 mailbox#(transaction) Gen2Drv_mbox, event gen_next_event);
        this.fnd_interf = fnd_interf;
        this.Gen2Drv_mbox = Gen2Drv_mbox;
        this.gen_next_event = gen_next_event;
    endfunction  //new()

    task run();
        forever begin
            Gen2Drv_mbox.get(fnd_tr);
            fnd_tr.display("DRV");

            @(posedge fnd_interf.PCLK);
            fnd_interf.PADDR   <= fnd_tr.PADDR;
            fnd_interf.PWDATA  <= fnd_tr.PWDATA;
            fnd_interf.PWRITE  <= 1'b1;
            fnd_interf.PENABLE <= 1'b0; // SETUP 구간
            fnd_interf.PSEL    <= 1'b1;

            @(posedge fnd_interf.PCLK);
            fnd_interf.PADDR   <= fnd_tr.PADDR;
            fnd_interf.PWDATA  <= fnd_tr.PWDATA;
            fnd_interf.PWRITE  <= 1'b1;
            fnd_interf.PENABLE <= 1'b1; // ACCESS 구간
            fnd_interf.PSEL    <= 1'b1;
            wait (fnd_interf.PREADY == 1'b1);
            @(posedge fnd_interf.PCLK);
            @(posedge fnd_interf.PCLK);
            @(posedge fnd_interf.PCLK);

            ->gen_next_event;  // event trigger
        end
    endtask  //
endclass  //driver

class environment;
    mailbox #(transaction) Gen2Drv_mbox;
    generator fnd_gen;
    driver fnd_drv;
    event gen_next_event;

    function new(virtual APB_Slave_Interface fnd_intf);
        Gen2Drv_mbox = new();
        this.fnd_gen = new(Gen2Drv_mbox, gen_next_event);
        this.fnd_drv = new(fnd_intf, Gen2Drv_mbox, gen_next_event);
    endfunction  //new()

    task run(int count);
        fork
            fnd_gen.run(count);
            fnd_drv.run();
        join_any
    endtask  //
endclass  //environment

module tb_fndController_APB_Periph ();

    environment fnd_env;
    APB_Slave_Interface fnd_intf ();

    always #5 fnd_intf.PCLK = ~fnd_intf.PCLK;

    FndController_Periph dut (
        .PCLK   (fnd_intf.PCLK),
        .PRESET (fnd_intf.PRESET),
        .PADDR  (fnd_intf.PADDR),
        .PWDATA (fnd_intf.PWDATA),
        .PWRITE (fnd_intf.PWRITE),
        .PENABLE(fnd_intf.PENABLE),
        .PSEL   (fnd_intf.PSEL),
        .PRDATA (fnd_intf.PRDATA),
        .PREADY (fnd_intf.PREADY),
        .fndCom (fnd_intf.fndCom),
        .fndFont(fnd_intf.fndFont)
    );


    initial begin
        fnd_intf.PCLK   = 0;
        fnd_intf.PRESET = 1;
        #10 fnd_intf.PRESET = 0;
        fnd_env = new(fnd_intf);
        fnd_env.run(10);
        #30;
        $finish;
    end

endmodule
