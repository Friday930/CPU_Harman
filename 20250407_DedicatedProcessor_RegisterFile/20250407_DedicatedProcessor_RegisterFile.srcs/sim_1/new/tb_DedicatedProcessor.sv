`timescale 1ns / 1ps


module tb_DedicatedProcessor();
    logic           clk;
    logic           rst;
    logic   [7:0]   out;

    top_DedicatedProcessor dut(.*);

    always  #5  clk = ~clk;

    initial begin
        clk = 0; rst = 1;
        #10 rst = 0;
        wait(out == 8'd55);
        #40 $finish;
    end

endmodule
