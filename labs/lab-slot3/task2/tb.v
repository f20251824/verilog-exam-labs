// tb.v -- Part B1: complete this self-checking testbench for parking_meter.
// Keep the instance name dut. Do not change model.v.
// It must end by printing one line: RESULT: PASS or RESULT: FAIL
`timescale 1ns/1ps
module tb;
  reg        clk = 0, rst_n = 0, coin = 0, tick = 0;
  wire [3:0] t;
  wire [1:0] status;
  parking_meter dut (.clk(clk), .rst_n(rst_n), .coin(coin), .tick(tick),
                     .t(t), .status(status));

  always #5 clk = ~clk;

  // (a) TODO: instantiate meter_model (in model.v) as the reference model,
  //     driven by the same inputs as dut.

  // (a) TODO: after every clock edge, compare t and status of dut with the
  //     model's outputs; on a mismatch add 1 to errors ($display helps debug).
  integer errors = 0;

  // (b) TODO: test cases. Change inputs only at falling clock edges.
  //     Cover every rule in the specification.
  initial begin
    #12 rst_n = 1;
    @(negedge clk) coin = 1;
    @(negedge clk) coin = 0;
    // ... your test cases here ...
    @(negedge clk); #1;                       // let the last check finish
    if (errors == 0) $display("RESULT: PASS");
    else             $display("RESULT: FAIL");
    $finish;
  end

  // waveform dump for the Run button: keep this block
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end
endmodule
