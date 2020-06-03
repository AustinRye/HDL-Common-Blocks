//
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Description:
// Counter with the following specifications:
//     - up/down counting
//     - bit count
//

module counter (
        input  logic       clk,
        input  logic       rst,
        input  logic       en,
        output logic [3:0] count
    );

    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
            count <= 4'h0;
        else if (en) 
            count <= count + 4'h1;
    end

endmodule
