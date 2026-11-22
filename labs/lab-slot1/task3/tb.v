// tb.v -- Part B2. Do NOT change the input sequence.
// You may add $display / $monitor statements here and inside room_counter.v.
`timescale 1ns/1ps
module tb;
  reg clk = 0, rst_n = 0, enter = 0, leave = 0, clear = 0;
  wire [3:0] n;
  wire full;
  room_counter dut (.clk(clk), .rst_n(rst_n), .enter(enter),
                    .leave(leave), .clear(clear), .n(n), .full(full));
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
    @(negedge clk) enter = 1;
    repeat (3) @(negedge clk);
    enter = 0;
    @(negedge clk) leave = 1;
    @(negedge clk) leave = 0;
    @(negedge clk) clear = 1;
    @(negedge clk) clear = 0; enter = 1;
    repeat (11) @(negedge clk);
    enter = 0;
    @(negedge clk) $finish;
  end
endmodule
