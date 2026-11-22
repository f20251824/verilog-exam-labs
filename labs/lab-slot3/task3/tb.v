// tb.v -- Part B2. Do NOT change the input sequence.
// You may add $display / $monitor statements here and inside parking_meter.v.
`timescale 1ns/1ps
module tb;
  reg clk = 0, rst_n = 0, coin = 0, tick = 0;
  wire [3:0] t;
  wire [1:0] status;
  parking_meter dut (.clk(clk), .rst_n(rst_n), .coin(coin), .tick(tick),
                     .t(t), .status(status));
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
    @(negedge clk) coin = 1;
    @(negedge clk) coin = 0;
    @(negedge clk) coin = 1;
    @(negedge clk) coin = 0;
    repeat (2) @(negedge clk);
    repeat (3) begin
      tick = 1;
      @(negedge clk) tick = 0;
      @(negedge clk);
    end
    repeat (2) @(negedge clk);
    $finish;
  end
endmodule
