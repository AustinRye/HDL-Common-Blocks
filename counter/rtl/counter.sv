//
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Description:
// Counter with the following specifications:
//     - up/down counting
//     - bit count
//

module counter #(
        parameter    COUNT_WIDTH = 8
    ) (
        input  logic clk,
        input  logic rst,
        input  logic en,
        output logic [COUNT_WIDTH-1:0] count
    );

    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
            count <= 0;
        else if (en)
            count <= count + 1;
    end

endmodule
