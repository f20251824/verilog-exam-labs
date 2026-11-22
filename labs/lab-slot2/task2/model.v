// model.v -- Given, do not modify.
// press_model: a purely behavioural model of the press counter, written only to
// generate the correct expected outputs. It is not built like press_counter.
module press_model (input clk, rst_n, btn, clear,
                    output reg [3:0] n, output reg nine);
  reg [2:0] h;                                  // btn at the last three edges
  always @(posedge clk or negedge rst_n)
    if (!rst_n) begin
      h <= 3'b000;  n <= 4'd0;
    end
    else begin
      h <= {h[1:0], btn};
      if (clear)                   n <= 4'd0;
      else if (h[1] && !h[2])      n <= (n == 4'd9) ? 4'd0 : n + 4'd1;
    end
  always @(*)
    nine = (n == 4'd9);
endmodule
