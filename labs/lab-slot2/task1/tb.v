// tb.v -- Given, do not modify.
// Interface check only: confirms that door_sense, fridge_alarm and door_timer
// exist with the ports of Figure A1. It does NOT check that they work.
`timescale 1ns/1ps
module tb;
  reg        a = 0, b = 0, l = 0, clk = 0, rst_n = 0, fault_i = 0;
  reg  [1:0] open = 0;
  reg  [5:0] sens = 0;
  wire       o, e, alarm1, alarm2, fault2;
  wire [2:0] t1, t2;
  wire [1:0] led1, led2;

  door_sense   US (.a(a), .b(b), .l(l), .o(o), .e(e));
  door_timer   UT (.clk(clk), .rst_n(rst_n), .open(open), .fault(fault_i),
                   .t(t1), .alarm(alarm1), .led(led1));
  fridge_alarm UF (.clk(clk), .rst_n(rst_n), .sens(sens),
                   .t(t2), .alarm(alarm2), .led(led2), .fault(fault2));

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
