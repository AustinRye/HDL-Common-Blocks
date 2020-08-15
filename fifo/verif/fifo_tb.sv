////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: counter_tb
// Description:
// FIFO verification testbench
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module fifo_tb;

parameter WIDTH = 8;
parameter DEPTH = 8;

logic clk;
logic rstn;
logic wr_en;
logic rd_en;
logic [WIDTH-1:0] data_in;
logic [WIDTH-1:0] data_out;
logic empty;
logic full;

always
    #5 clk = ~clk;

fifo #(
     .WIDTH (WIDTH)
    ,.DEPTH (WIDTH)
) fifo_dut (
     .clk      (clk)
    ,.rstn     (rstn)
    ,.wr_en    (wr_en)
    ,.rd_en    (rd_en)
    ,.data_in  (data_in)
    ,.data_out (data_out)
    ,.empty    (empty)
    ,.full     (full)
);

initial begin
    clk = 0;
    rstn = 0;
    wr_en = 0;
    rd_en = 0;
    data_in = 1;
    #10;

    rstn = 1;
    #90
	
    for (int i = 1; i <= 8; i++)
    begin
        data_in = i;
        wr_en = 1;
        #10;
    end
  	wr_en = 0;
  
  	#50;
  
    for (int i = 1; i <= 8; i++)
    begin
        rd_en = 1;
        #10;
    end
  	rd_en = 0;

    #50;

    $display("Test complete");
    $finish;
end

initial begin
    // dump vcd waveform file
    $dumpfile("waveform.vcd");
    $dumpvars(0, fifo_tb);
end

endmodule
