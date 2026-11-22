// tb.v -- Given, do not modify.
// Interface check only: confirms that motion_cell, street_light and light_fsm
// exist with the ports of Figure A1. It does NOT check that they work.
`timescale 1ns/1ps
module tb;
  reg        a = 0, b = 0, c = 0, clk = 0, rst_n = 0, dark = 0, fault_i = 0;
  reg  [1:0] m = 0;
  reg  [5:0] sens = 0;
  wire       d, e, on1, on2, fault2;
  wire [1:0] state1, state2, code1, code2;

  motion_cell  UM (.a(a), .b(b), .c(c), .d(d), .e(e));
  light_fsm    UL (.clk(clk), .rst_n(rst_n), .dark(dark), .m(m), .fault(fault_i),
                   .state(state1), .on(on1), .code(code1));
  street_light US (.clk(clk), .rst_n(rst_n), .dark(dark), .sens(sens),
                   .state(state2), .on(on2), .code(code2), .fault(fault2));

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  initial begin
    #1 $display("INTERFACE CHECK DONE (compile warnings about ports, if any, must be fixed)");
    $finish;
  end
endmodule
