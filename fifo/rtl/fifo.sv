////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: fifo
// Description:
// First In/First Out data structure
////////////////////////////////////////////////////////////////////////////////

module fifo
    #(
        parameter DATA_WIDTH = 8,
        parameter ADDR_WIDTH = 8
    ) (
        input  logic clk,   // clock
        input  logic rstn,  // reset active low
        input  logic wr_en, // write enable
        input  logic rd_en, // read enable
        input  logic [DATA_WIDTH-1:0] data_in,  // data in
        output logic [DATA_WIDTH-1:0] data_out, // data out
        output logic empty, // empty flag
        output logic full   // full flag
    );

    logic [DATA_WIDTH] mem [2**ADDR_WIDTH-1:0]; // memory
    logic [ADDR_WIDTH-1:0] wr_ptr; // write pointer
    logic [ADDR_WIDTH-1:0] rd_ptr; // read pointer
    
    always_ff @(posedge clk)
        if (!rstn)
        begin
            data_out <= 0;
            wr_ptr <= 0;
            rd_ptr <= 0;
            empty <= 1;
            full <= 0;
        end
        else
        begin
            if (wr_en & !full)
            begin
                mem[wr_ptr] <= data_in;
                empty <= 0;
                wr_ptr <= wr_ptr + 1;
                if (wr_ptr == rd_ptr)
                    full <= 1;
            end
            if (rd_en & !empty)
            begin
                data_out <= mem[rd_ptr];
                full <= 0;
                rd_ptr <= rd_ptr + 1;
                if (wr_ptr == rd_ptr)
                    empty <= 1;
            end
        end

endmodule