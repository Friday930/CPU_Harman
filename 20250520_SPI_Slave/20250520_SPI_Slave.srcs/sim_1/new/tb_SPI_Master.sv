`timescale 1ns / 1ps

module tb_SPI_Master ();


    logic       clk;
    logic       rst;

    logic       cpol;
    logic       cpha;
    logic       start;
    logic [7:0] tx_data;
    logic [7:0] rx_data;
    logic       done;
    logic       ready;

    logic       SCLK;
    logic       MISO;
    logic       MOSI;
    logic       SS;

    // assign MISO = MOSI; // loop

    SPI_Master dut (.*);
    SPI_Slave slave_dut (.*);


    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;
        SS = 1;

        repeat (3) @(posedge clk);

        // @(posedge clk);
        // tx_data = 8'haa; start = 1;
        // @(posedge clk);
        // start = 0;
        // wait (done == 1);
        // @(posedge clk);

        // @(posedge clk);
        // tx_data = 8'h55; start = 1;
        // @(posedge clk);
        // start = 0;
        // wait (done == 1);
        // @(posedge clk);

        // address byte
        SS = 0;

        @(posedge clk);
        tx_data = 8'b10000000;
        start = 1;
        cpol = 0;
        cpha = 0;
        // SS = 0;
        @(posedge clk);
        start = 0;
        wait (done == 1);
        @(posedge clk);

        // write data byte on 0x00 address
        @(posedge clk);
        tx_data = 8'h10;
        start = 1;
        cpol = 0;
        cpha = 0;
        // SS = 0;
        @(posedge clk);
        start = 0;
        wait (done == 1);
        @(posedge clk);

        // write data byte on 0x01 address
        @(posedge clk);
        tx_data = 8'h20;
        start = 1;
        cpol = 0;
        cpha = 0;
        // SS = 0;
        @(posedge clk);
        start = 0;
        wait (done == 1);
        @(posedge clk);

        // write data byte on 0x02 address
        @(posedge clk);
        tx_data = 8'h30;
        start = 1;
        cpol = 0;
        cpha = 0;
        // SS = 0;
        @(posedge clk);
        start = 0;
        wait (done == 1);
        @(posedge clk);

        // write data byte on 0x03 address
        @(posedge clk);
        tx_data = 8'h40;
        start = 1;
        cpol = 0;
        cpha = 0;
        // SS = 0;
        @(posedge clk);
        start = 0;
        wait (done == 1);
        @(posedge clk);

        SS = 1;  // select disable

        repeat (5) @(posedge clk);
        SS = 0;  // select able
        @(posedge clk);
        tx_data = 8'h00;
        start = 1;
        cpol = 0;
        cpha = 0;
        @(posedge clk);
        start = 0;
        wait (done == 1);

        for (int i = 0; i < 4; i++) begin
            tx_data = 8'hff;
            start = 1;
            @(posedge clk);
            start = 1;
            @(posedge clk);
            start = 0;
            wait (done == 1);
            @(posedge clk);
        end

        SS = 1;

        #200 $finish;
    end


endmodule
