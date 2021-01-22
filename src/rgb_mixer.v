`default_nettype none
`timescale 1ns/1ns
module rgb_mixer #(parameter W = 8)
(
    input clk,
    input reset,
    input enc0_a,
    input enc0_b,
    input enc1_a,
    input enc1_b,
    input enc2_a,
    input enc2_b,
    output pwm0_out,
    output pwm1_out,
    output pwm2_out
);

    localparam MAX = (2 ** W) - 1;

    wire [W-1:0] enc0;
    wire [W-1:0] enc1;
    wire [W-1:0] enc2;
    wire         deb0_a;
    wire         deb0_b;
    wire         deb1_a;
    wire         deb1_b;
    wire         deb2_a;
    wire         deb2_b;

    ///////////////////////////////////////////////////////////////////////////
    // ZERO

    debounce #(.SHIFT_WIDTH (W)) debounce_inst0_a
             (
              .clk       (clk),    // input
              .reset     (reset),  // input
              .button    (enc0_a), // input
              .debounced (deb0_a)  // output
             );

    debounce #(.SHIFT_WIDTH (W)) debounce_inst0_b
             (
              .clk       (clk),    // input
              .reset     (reset),  // input
              .button    (enc0_b), // input
              .debounced (deb0_b)  // output
             );

    encoder  #(.MAXVAL (MAX)) encoder_inst0
             (
              .clk   (clk),        // input
              .reset (reset),      // input
              .a     (deb0_a),     // input
              .b     (deb0_b),     // input
              .value (enc0)        // output [WIDTH-1:0]
             );

    pwm      #(.CNT_WIDTH (W)) pwm_inst0
             (
              .clk   (clk),        // input
              .reset (reset),      // input
              .out   (pwm0_out),   // output
              .level (enc0)        // input [CNT_WIDTH-1:0]
             );

    ///////////////////////////////////////////////////////////////////////////
    // ONE

    debounce #(.SHIFT_WIDTH (W)) debounce_inst1_a
             (
              .clk       (clk),    // input
              .reset     (reset),  // input
              .button    (enc1_a), // input
              .debounced (deb1_a)  // output
             );

    debounce #(.SHIFT_WIDTH (W)) debounce_inst1_b
             (
              .clk       (clk),    // input
              .reset     (reset),  // input
              .button    (enc1_b), // input
              .debounced (deb1_b)  // output
             );

    encoder  #(.MAXVAL (MAX)) encoder_inst1
             (
              .clk   (clk),        // input
              .reset (reset),      // input
              .a     (deb1_a),     // input
              .b     (deb1_b),     // input
              .value (enc1)        // output [WIDTH-1:0]
             );

    pwm      #(.CNT_WIDTH (W)) pwm_inst1
             (
              .clk   (clk),        // input
              .reset (reset),      // input
              .out   (pwm1_out),   // output
              .level (enc1)        // input [CNT_WIDTH-1:0]
             );

    ///////////////////////////////////////////////////////////////////////////
    // TWO

    debounce #(.SHIFT_WIDTH (W)) debounce_inst2_a
             (
              .clk       (clk),    // input
              .reset     (reset),  // input
              .button    (enc2_a), // input
              .debounced (deb2_a)  // output
             );

    debounce #(.SHIFT_WIDTH (W)) debounce_inst2_b
             (
              .clk       (clk),    // input
              .reset     (reset),  // input
              .button    (enc2_b), // input
              .debounced (deb2_b)  // output
             );

    encoder  #(.MAXVAL (MAX)) encoder_inst2
             (
              .clk   (clk),        // input
              .reset (reset),      // input
              .a     (deb2_a),     // input
              .b     (deb2_b),     // input
              .value (enc2)        // output [WIDTH-1:0]
             );

    pwm      #(.CNT_WIDTH (W)) pwm_inst2
             (
              .clk   (clk),        // input
              .reset (reset),      // input
              .out   (pwm2_out),   // output
              .level (enc2)        // input [CNT_WIDTH-1:0]
             );

endmodule
