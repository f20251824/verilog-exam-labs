// tb.v -- Given, do not modify.
// Interface check only: confirms that walk_dir exists with the ports given in
// question B3. It does NOT check that it works.
`timescale 1ns/1ps
module tb;
  reg        clk = 0, rst_n = 0, dark = 0;
  reg  [1:0] m = 0;
  wire [1:0] dir;
  walk_dir UW (.clk(clk), .rst_n(rst_n), .dark(dark), .m(m), .dir(dir));

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
