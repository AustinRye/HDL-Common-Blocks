////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: reg_file_tb
// Description:
// Register File verification testbench
////////////////////////////////////////////////////////////////////////////////

module reg_file_tb;

    parameter DATA_WIDTH = 3;
    parameter REG_WIDTH  = 2;

    logic clk, rst;
    logic write_en;
    logic [REG_WIDTH-1:0]  write_addr;
    logic [DATA_WIDTH-1:0] write_data;
    logic [REG_WIDTH-1:0]  read_addr_1, read_addr_2;
    logic [DATA_WIDTH-1:0] read_data_1, read_data_2;

    always
        #5 clk = ~clk;

    reg_file #(
        .DATA_WIDTH(DATA_WIDTH),
        .REG_WIDTH(REG_WIDTH)
    ) reg_file_dut (
        .clk(clk),
        .rst(rst),
        .write_en(write_en),
        .write_addr(write_addr),
        .write_data(write_data),
        .read_addr_1(read_addr_1),
        .read_addr_2(read_addr_2),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
    );

    initial begin
        clk = 0;
        rst = 1;
        write_en = 0;
        write_addr = 0;
        write_data = 0;
        read_addr_1 = 0;
        read_addr_2 = 0;
        #20;

        rst = 0;
        #10;

        write_en = 1;
        write_addr = 1;
        write_data = 5;
        #10;

        write_en = 0;
        read_addr_1 = 1;
        read_addr_2 = 0;

        #10;
        rst = 1;

        #10000;
        $finish;
    end

    initial begin
        // dump vcd waveform file
        $dumpfile("waveform.vcd");
        $dumpvars(0, reg_file_tb);
    end

endmodule