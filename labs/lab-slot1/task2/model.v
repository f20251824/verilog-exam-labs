// model.v -- Given, do not modify.
// room_model: a purely behavioural model of the room head-counter, written only to
// generate the correct expected outputs. It is not built like room_counter.
module room_model (input clk, rst_n, enter, leave, clear,
                   output reg [3:0] n, output reg full);
  always @(posedge clk or negedge rst_n)
    if (!rst_n)                          n <= 4'd0;
    else if (clear)                      n <= 4'd0;
    else if (enter && !leave && n < 10)  n <= n + 4'd1;
    else if (leave && !enter && n > 0)   n <= n - 4'd1;
  always @(*)
    full = (n == 4'd10);
endmodule
