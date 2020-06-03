//
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Description:
// Counter testbench
//

`timescale 1ns / 100ps

module counter_tb;

logic       clk;
logic       rst;
logic       en;
logic [3:0] count;

always
    #5 clk = ~clk;

counter counter_dut (
    .clk    (clk),
    .rst    (rst),
    .en     (en),
    .count  (count)
);

initial begin
    clk = 0;
    rst = 1;
    en = 1;
    #20;

    rst = 0;
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
