//
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: Counter
// Description:
// Fully customizable counter with the following features:
//     - variable count bit width
//     - sync/async reset control
//

module counter #(
        parameter    COUNT_WIDTH = 8, // count bit width
        parameter    ASYNC_RST   = 0, // enable async reset
        parameter    LOW_RST     = 0, // enable active low reset
        parameter    COUNT_FROM  = 0, // start counting from the given number
        parameter    COUNT_TO    = (2**COUNT_WIDTH)-1 // end counting at the given number
    ) (
        input  logic clk,     // counter clock rate
        input  logic rst,     // reset, sync/async controlled by ASYNC_RST
        input  logic en,      // enable counter
        input  logic load_en, // enable count loading
        input  logic [COUNT_WIDTH-1:0] load_count, // load the count number
        output logic [COUNT_WIDTH-1:0] count       // count number
    );

    if (ASYNC_RST) begin
        if (LOW_RST) begin
            always_ff @(negedge rst)
            begin
                count <= COUNT_FROM;
            end
        end
        else begin
            always_ff @(posedge rst)
            begin
                count <= COUNT_FROM;
            end
        end
    end

    always_ff @(posedge clk)
    begin
        if ((!LOW_RST & rst) | (LOW_RST & !rst))
            count <= COUNT_FROM;
        else if (load_en)
            count <= load_count;
        else if (en)
            if (count == COUNT_TO)
                count <= COUNT_FROM;
            else
                count <= count + 1;
    end

endmodule
