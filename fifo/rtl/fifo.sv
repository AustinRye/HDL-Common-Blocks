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

    

endmodule