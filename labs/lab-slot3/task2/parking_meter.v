// next_time: works out the time left after the next clock edge
module next_time (input [3:0] t, input coin, tick, output reg [3:0] next);
  always @(*) begin
    if (coin)                   next = (t > 4'd12) ? 4'd15 : t + 4'd3;
    else if (tick && t != 4'd0) next = t - 4'd1;
    else                        next = t;
  end
endmodule

// time_reg: stores the time left; rst_n clears it
module time_reg (input clk, rst_n, input [3:0] d, output reg [3:0] q);
  always @(posedge clk or negedge rst_n)
    if (!rst_n) q <= 4'd0;
    else        q <= d;
endmodule

// status_check: 10 = expired, 01 = 3 minutes or less, 00 = more than 3 minutes
module status_check (input [3:0] t, output reg [1:0] status);
  always @(*) begin
    if (t == 4'd0)       status = 2'b10;
    else if (t <= 4'd3)  status = 2'b01;
  end
endmodule

// parking_meter: top level
module parking_meter (input clk, rst_n, coin, tick,
                      output [3:0] t, output [1:0] status);
  wire [3:0] next;
  next_time    U1 (t, tick, coin, next);
  time_reg     U2 (clk, rst_n, next, t);
  status_check U3 (t, status);
endmodule
