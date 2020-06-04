//
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: Counter Testbench
// Description:
// Counter verification testbench
//

`timescale 1ns / 1ns

module counter_tb;

parameter   COUNT_WIDTH = 3;
parameter   ASYNC_RST   = 1;
parameter   LOW_RST     = 0;
parameter   COUNT_FROM  = 2;
parameter   COUNT_TO    = 5;

logic clk;
logic rst;
logic en;
logic load_en;
logic [COUNT_WIDTH-1:0] load_count;
logic [COUNT_WIDTH-1:0] count;

always
    #5 clk = ~clk;

counter #(
     .COUNT_WIDTH (COUNT_WIDTH)
    ,.ASYNC_RST   (ASYNC_RST)
    ,.LOW_RST     (LOW_RST)
    ,.COUNT_FROM  (COUNT_FROM)
    ,.COUNT_TO    (COUNT_TO)
) counter_dut (
     .clk         (clk)
    ,.rst         (rst)
    ,.en          (en)
    ,.load_en     (load_en)
    ,.load_count  (load_count)
    ,.count       (count)
);

initial begin
    clk = 0;
    rst = 1;
    en = 1;
    load_en = 0;
    load_count = 0;
    #10;

    rst = 0;
    #100

    load_en = 1;
    load_count = 5;
    #20;

    load_en = 0;

    #10000;

    $display("Test complete");
    $finish;
end

initial begin
    // dump vcd waveform file
    $dumpfile("waveform.vcd");
    $dumpvars(0, counter_tb);
end

endmodule
