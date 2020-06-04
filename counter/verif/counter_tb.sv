//
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: Counter Testbench
// Description:
// Counter verification testbench
//

`timescale 1ns / 1ns

module counter_tb;

parameter   COUNT_WIDTH = 4;
parameter   ASYNC_RST   = 1;
parameter   LOW_RST     = 0;
parameter   COUNT_START = 2;
parameter   COUNT_END   = 11;
parameter   COUNT_STEP  = 2;

logic clk;
logic rst;
logic en;
logic up_down;
logic load_en;
logic [COUNT_WIDTH-1:0] load_count;
logic [COUNT_WIDTH-1:0] count;

always
    #5 clk = ~clk;

counter #(
     .COUNT_WIDTH (COUNT_WIDTH)
    ,.ASYNC_RST   (ASYNC_RST)
    ,.LOW_RST     (LOW_RST)
    ,.COUNT_START (COUNT_START)
    ,.COUNT_END   (COUNT_END)
    ,.COUNT_STEP  (COUNT_STEP)
) counter_dut (
     .clk         (clk)
    ,.rst         (rst)
    ,.en          (en)
    ,.up_down     (up_down)
    ,.load_en     (load_en)
    ,.load_count  (load_count)
    ,.count       (count)
);

initial begin
    clk = 0;
    rst = 1;
    en = 1;
    up_down = 1;
    load_en = 0;
    load_count = 0;
    #10;

    rst = 0;
    #290

    up_down = 0;
    #300;

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
