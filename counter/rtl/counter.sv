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
        parameter    LOW_RST     = 0  // enable active low reset
    ) (
        input  logic clk, // counter clock rate
        input  logic rst, // reset, sync/async controlled by ASYNC_RST
        input  logic en,  // enable counter
        output logic [COUNT_WIDTH-1:0] count // count number
    );

    if (ASYNC_RST) begin
        if (LOW_RST) begin
            always_ff @(negedge rst)
            begin
                count <= 0;
            end
        end
        else begin
            always_ff @(posedge rst)
            begin
                count <= 0;
            end
        end
    end

    always_ff @(posedge clk)
    begin
        if ((!LOW_RST & rst) | (LOW_RST & !rst))
            count <= 0;
        else if (en)
            count <= count + 1;
    end

endmodule
