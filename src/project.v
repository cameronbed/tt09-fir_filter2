/*
 * Copyright (c) 2024 Cameron Bedard and James Xie
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_fir_filter2 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire rst = ~rst_n;
  wire [7:0] fir_input = ui_in;
  wire [15:0] fir_output;
  wire a;
  wire b;

  // output [15:0] y_rsc_dat;
  // output y_triosy_lz;
  // input [7:0] x_rsc_dat;
  // output x_triosy_lz;
  fir fir_filter( 
    .clk(clk),                // Clock
    .rst(rst),                // Reset
    .y_rsc_dat(fir_output),   // Output data
    .y_triosy_lz(b),          // Output enable
    .x_rsc_dat(fir_input),    // Input data
    .x_triosy_lz(a)   
  );

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = fir_output[15:8]; 
  assign uio_out = fir_output[7:0];
  assign uio_oe  = 1;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0, a, b};

endmodule
