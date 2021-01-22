`default_nettype none
`timescale 1ns/1ns
module pwm #(parameter CNT_WIDTH = 8,
                       INV_OUT   = 0
            )
            (input  wire                 clk,
             input  wire                 reset,
             output wire                 out,
             input  wire [CNT_WIDTH-1:0] level
            );

    wire                preout;
    reg [CNT_WIDTH-1:0] count;

    assign preout = reset   ? 1'b0    : (count < level) ? 1'b1 : 1'b0;
    assign out    = INV_OUT ? !preout : preout;

    always @(posedge clk) begin
        if (reset) begin
            count <= {CNT_WIDTH{1'b0}};
        end
        else begin
            count <= count + 1'b1;
        end
    end

endmodule
