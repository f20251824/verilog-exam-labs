// tb.v -- Given, do not modify.
// Interface check only: confirms that pump_guard exists with the ports given in
// question B3. It does NOT check that it works.
`timescale 1ns/1ps
module tb;
  reg        clk = 0, rst_n = 0, fault = 0;
  reg  [1:0] up = 0, low = 0;
  wire       pump, stuck;
  pump_guard UG (.clk(clk), .rst_n(rst_n), .up(up), .low(low), .fault(fault),
                  .pump(pump), .stuck(stuck));

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
