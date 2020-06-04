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

logic clk;
logic rst;
logic en;
logic [COUNT_WIDTH-1:0] count;

always
    #5 clk = ~clk;

counter #(
    .COUNT_WIDTH (COUNT_WIDTH),
    .ASYNC_RST   (ASYNC_RST),
    .LOW_RST     (LOW_RST)
) counter_dut (
    .clk         (clk),
    .rst         (rst),
    .en          (en),
    .count       (count)
);

initial begin
    clk = 0;
    rst = 1;
    en = 1;
    #20;

    rst = 0;
    #102;

    rst = 1;
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
