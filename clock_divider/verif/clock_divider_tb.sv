////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: clock_divider_tb
// Description:
// Clock divider verification testbench
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module clock_divider_tb;

logic clk_in;
logic rst;
logic clk_out;

always
    #5 clk_in = ~clk_in;

clock_divider clock_divider_dut (
     .clk_in      (clk_in)
    ,.rst         (rst)
    ,.clk_out     (clk_out)
);

initial begin
    clk_in = 0;
    rst = 1;
    #30;

    rst = 0;

    #10000;

    $display("Test complete");
    $finish;
end

initial begin
    // dump vcd waveform file
    $dumpfile("waveform.vcd");
    $dumpvars(0, clock_divider_tb);
end

endmodule
