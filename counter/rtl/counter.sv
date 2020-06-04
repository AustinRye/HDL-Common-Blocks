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
        parameter    COUNT_START = 0, // start counting from the given number
        parameter    COUNT_END   = (2**COUNT_WIDTH)-1, // end counting at the given number
        parameter    COUNT_STEP  = 1 // step count
    ) (
        input  logic clk,     // counter clock rate
        input  logic rst,     // reset, sync/async controlled by ASYNC_RST
        input  logic en,      // enable counter
        input  logic up_down, // count up/down
        input  logic load_en, // enable count loading
        input  logic [COUNT_WIDTH-1:0] load_count, // load the count number
        output logic [COUNT_WIDTH-1:0] count       // count number
    );

    if (ASYNC_RST) begin
        if (LOW_RST) begin
            always_ff @(negedge rst)
            begin
                if (up_down)
                    count <= COUNT_START;
                else
                    count <= COUNT_END;
            end
        end
        else begin
            always_ff @(posedge rst)
            begin
                if (up_down)
                    count <= COUNT_START;
                else
                    count <= COUNT_END;
            end
        end
    end

    always_ff @(posedge clk)
    begin
        if ((!LOW_RST & rst) | (LOW_RST & !rst))
            if (up_down)
                count <= COUNT_START;
            else
                count <= COUNT_END;
        else if (load_en)
            count <= load_count;
        else if (en)
            if (up_down)
                if (count + COUNT_STEP > COUNT_END)
                    count <= COUNT_START;
                else
                    count <= count + COUNT_STEP;
            else
                if (count - COUNT_STEP < COUNT_START)
                    count <= COUNT_END;
                else
                    count <= count - COUNT_STEP;
    end

endmodule
