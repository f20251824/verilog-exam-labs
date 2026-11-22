// tb.v -- Part B2. Do NOT change the input sequence.
// You may add $display / $monitor statements here and inside press_counter.v.
`timescale 1ns/1ps
module tb;
  reg clk = 0, rst_n = 0, btn = 0, clear = 0;
  wire [3:0] n;
  wire nine;
  press_counter dut (.clk(clk), .rst_n(rst_n), .btn(btn), .clear(clear),
                     .n(n), .nine(nine));
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  always #5 clk = ~clk;
  initial begin
    #12 rst_n = 1;
    repeat (8) begin                          // presses, one every two cycles
      @(negedge clk) btn = 1;
      @(negedge clk) btn = 0;
    end
    repeat (3) @(negedge clk);
    btn = 1;                                  // one more press ...
    @(negedge clk) btn = 0;
    @(posedge clk) #2 rst_n = 0;              // ... with a reset pulse after it
    #2 rst_n = 1;
    repeat (5) @(negedge clk);
    $finish;
  end
endmodule
