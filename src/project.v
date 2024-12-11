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
  wire uo_uio_out = {uo_out, uio_out};
  wire a;

  fir fir_filter( 
    .clk(clk),              // Clock
    .rst(rst),           // Reset
    .x_rsc_dat(ui_in),      // Input data
    .y_triosy_lz(a),
    .y_rsc_dat(uo_uio_out), // Output data
    .y_triosy_lz(a)    // Output enable
  );

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = uo_uio_out[15:8]; 
  assign uio_out = uo_uio_out[7:0];
  assign uio_oe  = 1;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0};

endmodule
