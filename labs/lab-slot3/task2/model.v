// model.v -- Given, do not modify.
// meter_model: a purely behavioural model of the parking meter, written only to
// generate the correct expected outputs. It is not built like parking_meter.
module meter_model (input clk, rst_n, coin, tick,
                    output reg [3:0] t, output reg [1:0] status);
  always @(posedge clk or negedge rst_n)
    if (!rst_n)              t <= 4'd0;
    else if (coin)           t <= (t >= 4'd13) ? 4'd15 : t + 4'd3;
    else if (tick && t > 0)  t <= t - 4'd1;
  always @(*)
    case (t)
      4'd0:                status = 2'b10;
      4'd1, 4'd2, 4'd3:    status = 2'b01;
      default:             status = 2'b00;
    endcase
endmodule
