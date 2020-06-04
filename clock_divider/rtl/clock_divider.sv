////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: clock_divider
// Description:
// Takes a higher frequency input clock and divides it down to give a lower
// frequency output clock
////////////////////////////////////////////////////////////////////////////////

module clock_divider 
    #(
        parameter ASYNC_RST = 0 // enable async reset
    ) (
        input  logic clk_in, // input clock rate
        input  logic rst,    // reset
        output logic clk_out // output clock rate
    );

    logic [2:0] count;

    if (ASYNC_RST) begin
        always_ff @(posedge rst)
        begin
            clk_out <= 0;
            count <= 0;
        end
    end

    always_ff @(posedge clk_in)
        if (rst)
        begin
            clk_out <= 0;
            count <= 0;
        end
        else
            if (count == 5)
            begin
                clk_out <= ~clk_out;
                count <= 0;
            end
            else
                count <= count + 1;

endmodule
