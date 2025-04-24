// `timescale 1ns / 1ps

// module tb_APB_BUS ();
//     logic        PCLK;
//     logic        PRESET;
//     logic [31:0] PADDR;
//     logic [31:0] PWDATA;
//     logic        PWRITE;
//     logic        PENABLE;
//     logic        PSEL0;
//     logic        PSEL1;
//     logic        PSEL2;
//     logic        PSEL3;
//     logic [31:0] PRDATA0;
//     logic [31:0] PRDATA1;
//     logic [31:0] PRDATA2;
//     logic [31:0] PRDATA3;
//     logic        PREADY0;
//     logic        PREADY1;
//     logic        PREADY2;
//     logic        PREADY3;
//     logic        transfer;
//     logic        ready;
//     logic [31:0] addr;
//     logic [31:0] wdata;
//     logic [31:0] rdata;
//     logic        write;

//     APB_Master U_APB_Master (.*);

//     APB_Slave U_Periph0 (
//         .*,
//         .PSEL  (PSEL0),
//         .PRDATA(PRDATA0),
//         .PREADY(PREADY0)
//     );

//     APB_Slave U_Periph1 (
//         .*,
//         .PSEL  (PSEL0),
//         .PRDATA(PRDATA0),
//         .PREADY(PREADY0)
//     );

//     APB_Slave U_Periph2 (
//         .*,
//         .PSEL  (PSEL0),
//         .PRDATA(PRDATA0),
//         .PREADY(PREADY0)
//     );

//     APB_Slave U_Periph3 (
//         .*,
//         .PSEL  (PSEL0),
//         .PRDATA(PRDATA0),
//         .PREADY(PREADY0)
//     );

//     always #5 PCLK = ~PCLK;

//     initial begin
//         PCLK   = 0;
//         PRESET = 1;
//         #10 PRESET = 0;

//         // write
//         @(posedge PCLK);
//         #1 addr = 32'h1000_3000; write = 1; wdata = 10; transfer = 1;
//         @(posedge PCLK);
//         #1 transfer = 0;
//         wait (ready == 1'b1);

//         @(posedge PCLK);
//         #1 addr = 32'h1000_3004; write = 1; wdata = 11; transfer = 1;
//         @(posedge PCLK);
//         #1 transfer = 0;
//         wait (ready == 1'b1);

//         @(posedge PCLK);
//         #1 addr = 32'h1000_3008; write = 1; wdata = 12; transfer = 1;
//         @(posedge PCLK);
//         #1 transfer = 0;
//         wait (ready == 1'b1);

//         @(posedge PCLK);
//         #1 addr = 32'h1000_300c; write = 1; wdata = 13; transfer = 1;
//         @(posedge PCLK);
//         #1 transfer = 0;
//         wait (ready == 1'b1);

//         // read
//         @(posedge PCLK);
//         #1 addr = 32'h1000_3000; write = 0; transfer = 1;
//         @(posedge PCLK);
//         #1 transfer = 0;
//         wait (ready == 1'b1);

//         @(posedge PCLK);
//         #1 addr = 32'h1000_3004; write = 0; transfer = 1;
//         @(posedge PCLK);
//         #1 transfer = 0;
//         wait (ready == 1'b1);

//         @(posedge PCLK);
//         #1 addr = 32'h1000_3008; write = 0; transfer = 1;
//         @(posedge PCLK);
//         #1 transfer = 0;
//         wait (ready == 1'b1);

//         @(posedge PCLK);
//         #1 addr = 32'h1000_300c; write = 0; transfer = 1;
//         @(posedge PCLK);
//         #1 transfer = 0;
//         wait (ready == 1'b1);

//         #20 $finish;
//     end


// endmodule

`timescale 1ns / 1ps

module tb_APB_BUS(

    );

    logic         PCLK;
    logic         PRESET;

     logic [31:0] PADDR;
     logic [31:0] PWDATA;
     logic        PWRITE;
     logic        PSEL0;
     logic        PSEL1;
     logic        PSEL2;
     logic        PSEL3;
     logic        PENABLE;
    logic  [31:0] PRDATA0;
    logic  [31:0] PRDATA1;
    logic  [31:0] PRDATA2;
    logic  [31:0] PRDATA3;
    logic         PREADY0; 
    logic         PREADY1; 
    logic         PREADY2; 
    logic         PREADY3; 
   
    logic         transfer; //trigger signal(신호가 idle -> setup으로 넘어갈 수 있게 함)
     logic        ready;
    logic  [31:0] addr;
    logic  [31:0] wdata;
     logic [31:0] rdata;
    logic         write;

    APB_Master U_MASTER(

   .*
    );


APB_Slave U_slave_periph0(
  //global signal
    .*,

    .PSEL(PSEL0),
    .PRDATA(PRDATA0),
    .PREADY(PREADY0)


    );

APB_Slave U_slave_periph1(
  //global signal
    .*,

    .PSEL(PSEL1),
    .PRDATA(PRDATA1),
    .PREADY(PREADY1)


    );

    always #5 PCLK = ~PCLK;

    initial begin
        PCLK = 0; PRESET = 1;
        #10 PRESET = 0;
        @(posedge PCLK);
        #1 addr = 32'h1000_0000; write = 1; wdata = 10; transfer = 1;
        @(posedge PCLK);
        #1 transfer = 0;
        wait(ready == 1'b1) //ready가 1이 될때까지 기다림
        @(posedge PCLK); //ready 후에 clk  하나 받기
//////////////////////////////////// 기존 시나리오

        #1 addr = 32'h1000_0004; write = 1; wdata = 11; transfer = 1;
        //추가 시나리오 : RESISTER에 새로운 값 넣어주기
        @(posedge PCLK);
        #1 transfer = 0;
        wait(ready == 1'b1) //ready가 1이 될때까지 기다림
        @(posedge PCLK); //ready 후에 clk  하나 받기
        #1 addr = 32'h1000_0008; write = 1; wdata = 12; transfer = 1;
        @(posedge PCLK);
        #1 transfer = 0;
        wait(ready == 1'b1) //ready가 1이 될때까지 기다림
        @(posedge PCLK); //ready 후에 clk  하나 받기
        #1 addr = 32'h1000_000C; write = 1; wdata = 13; transfer = 1;
        @(posedge PCLK);
        #1 transfer = 0;
        wait(ready == 1'b1) //ready가 1이 될때까지 기다림
        @(posedge PCLK); //ready 후에 clk  하나 받기


////////////////////////////////READ 해보기기


        #1 addr = 32'h1000_0000; write = 0; transfer = 1;
        @(posedge PCLK);
        #1 transfer = 0;
        wait(ready == 1'b1) //ready가 1이 될때까지 기다림
        @(posedge PCLK); //ready 후에 clk  하나 받기
        #1 addr = 32'h1000_0004; write = 0; transfer = 1;
        @(posedge PCLK);
        #1 transfer = 0;
        wait(ready == 1'b1) //ready가 1이 될때까지 기다림
        @(posedge PCLK); //ready 후에 clk  하나 받기
        #1 addr = 32'h1000_0008; write = 0; transfer = 1;
        @(posedge PCLK);
        #1 transfer = 0;
        wait(ready == 1'b1) //ready가 1이 될때까지 기다림
        @(posedge PCLK); //ready 후에 clk  하나 받기
        #1 addr = 32'h1000_000C; write = 0; transfer = 1;
        @(posedge PCLK);
        #1 transfer = 0;
        wait(ready == 1'b1) //ready가 1이 될때까지 기다림
        @(posedge PCLK); //ready 후에 clk  하나 받기

    
        #20 $finish;

//4개 WRITE, 4개 READ 관찰하기

    end


endmodule
