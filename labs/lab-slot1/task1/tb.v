// tb.v -- Given, do not modify.
// Interface check only: confirms that level_enc, tank_system and pump_ctrl
// exist with the ports of Figure A1. It does NOT check that they work.
`timescale 1ns/1ps
module tb;
  reg        l = 0, m = 0, h = 0, clk = 0, rst_n = 0, fault_i = 0;
  reg  [1:0] up = 0, low = 0;
  reg  [5:0] sens = 0;
  wire       q1, q0, e, pump1, buzz1, pump2, buzz2, fault2;
  wire [1:0] led1, led2;

  level_enc   UL (.l(l), .m(m), .h(h), .q1(q1), .q0(q0), .e(e));
  pump_ctrl   UP (.clk(clk), .rst_n(rst_n), .up(up), .low(low), .fault(fault_i),
                  .pump(pump1), .buzz(buzz1), .led(led1));
  tank_system UT (.clk(clk), .rst_n(rst_n), .sens(sens),
                  .pump(pump2), .buzz(buzz2), .led(led2), .fault(fault2));

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
