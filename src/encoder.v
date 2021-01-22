`default_nettype none
`timescale 1ns/1ns
module encoder #(parameter MAXVAL = 255,
                           WIDTH  = $clog2(MAXVAL)
                )
                (input                  clk,
                 input                  reset,
                 input                  a,
                 input                  b,
                 output reg [WIDTH-1:0] value
                );

    reg  ap;
    reg  bp;
    wire inc;
    wire dec;

    assign inc = ({a,ap,b,bp} == 4'b1000) || ({a,ap,b,bp} == 4'b0111);
    assign dec = ({a,ap,b,bp} == 4'b0010) || ({a,ap,b,bp} == 4'b1101);

    always @(posedge clk) begin
        if (reset) begin
            value <= {WIDTH{1'b0}};
            ap    <= 1'b0;
            bp    <= 1'b0;
        end
        else begin
            ap    <= a;
            bp    <= b;
            case ({inc, dec})
                2'b00:   value <= value;
                2'b01:   value <= value - 1'b1;
                2'b10:   value <= value + 1'b1;
                2'b11:   $display("ERROR @ %0t! inc and dec cannot be both true", $time);
            endcase
        end
    end

endmodule
