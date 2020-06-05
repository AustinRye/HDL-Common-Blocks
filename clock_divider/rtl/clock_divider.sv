////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: clock_divider
// Description:
// Takes a higher frequency input clock and divides it down to give a lower
// frequency output clock. Note: factor (CLK_IN/CLK_OUT)/2 must be an integer
////////////////////////////////////////////////////////////////////////////////

module clock_divider
    #(
        parameter ASYNC_RST = 0, // enable async reset
        parameter LOW_RST   = 0, // enable active low reset
        parameter CLK_IN    = 1, // input reference clock frequency
        parameter CLK_OUT   = 1  // desired output clock frequency
    ) (
        input  logic clk_in, // input clock rate
        input  logic rst,    // reset
        output logic clk_out // output clock rate
    );

    logic [$clog2((CLK_IN/CLK_OUT)/2)-1:0] count;

    if (ASYNC_RST) begin
        if (LOW_RST) begin
            always_ff @(negedge rst)
            begin
                clk_out <= 0;
                count <= 0;
            end
        end
        else begin
            always_ff @(posedge rst)
            begin
                clk_out <= 0;
                count <= 0;
            end
        end
    end

    always_ff @(posedge clk_in)
        if ((!LOW_RST & rst) | (LOW_RST & !rst))
        begin
            clk_out <= 0;
            count <= 0;
        end
        else
            if (count == (CLK_IN/CLK_OUT)/2 - 1)
            begin
                clk_out <= ~clk_out;
                count <= 0;
            end
            else
                count <= count + 1;

endmodule
