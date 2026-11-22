// next_count: the head count after the next clock edge
module next_count (input [3:0] n, input enter, leave, clear, full,
                   output reg [3:0] next);
  always @(n or enter or clear or full) begin
    if (clear)                             next = 4'd0;     // room emptied
    else if (enter && !leave && !full)     next = n + 4'd1; // one in
    else if (leave && !enter && n != 4'd0) next = n - 4'd1; // one out
    else                                   next = n;        // no change
  end
endmodule

// count_reg: stores the head count; rst_n clears it
module count_reg (input clk, rst_n, input [3:0] d, output reg [3:0] q);
  always @(posedge clk or negedge rst_n)
    if (!rst_n) q <= 4'd0;
    else        q <= d;
endmodule

// full_check: full = 1 while the room is at capacity (10 people)
module full_check (input [3:0] n, output full);
  assign full = (n > 4'd10);
endmodule

// room_counter: top level
module room_counter (input clk, rst_n, enter, leave, clear,
                     output [3:0] n, output full);
  wire [3:0] next;
  next_count U1 (n, enter, leave, clear, full, next);
  count_reg  U2 (clk, rst_n, next, n);
  full_check U3 (n, full);
endmodule
