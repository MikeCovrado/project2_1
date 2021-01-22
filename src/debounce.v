`default_nettype none
`timescale 1ns/1ns
module debounce #( parameter SHIFT_WIDTH = 8
                 )
                 (input wire clk,
                  input wire reset,
                  input wire button,
                  output reg debounced
                );

    wire                  ones;
    wire                  zeros;
    reg [SHIFT_WIDTH-1:0] sreg;

    assign ones  = (sreg == {SHIFT_WIDTH{1'b1}}) ? 1'b1 : 1'b0;
    assign zeros = (sreg == {SHIFT_WIDTH{1'b0}}) ? 1'b1 : 1'b0;

    always @(posedge clk) begin
        if (reset) begin
            sreg        <= {SHIFT_WIDTH{1'b0}};
            debounced <= 1'b0;
        end
        else begin
            sreg <= {sreg[SHIFT_WIDTH-2:0], button};
            case ({ones, zeros})
                2'b10:   debounced <= 1'b1;
                2'b01:   debounced <= 1'b0;
                default: debounced <= debounced;
            endcase
        end
    end

endmodule
