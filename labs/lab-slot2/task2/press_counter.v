// sync2: passes btn through two flip-flops (synchroniser); s is btn two edges later
module sync2 (input clk, rst_n, btn, output s);
  reg b1, b2;
  always @(posedge clk or negedge rst_n)
    if (!rst_n)       b1 <= 1'b0;
    else        begin b1 <= btn;  b2 <= b1;   end
  assign s = b2;
endmodule

// press_count: counts presses (0 to 1 changes of s) from 0 to 9, then back to 0
module press_count (input clk, rst_n, s, clear, output reg [3:0] n);
  reg sp;                                      // s at the previous edge
  always @(posedge clk or negedge rst_n)
    if (!rst_n) begin
      n  <= 4'd0;
      sp <= 1'b0;
    end
    else begin
      sp <= s;
      if (clear)                n <= 4'd0;     // clear wins
      else if (s && !sp) begin                 // a new press
        if (n == 4'd9)          n <= 4'd0;
        else                    n <= n + 4'd1;
      end
    end
endmodule

// nine_check: nine = 1 while n is 9
module nine_check (input [3:0] n, output nine);
  assign nine = n[3];
endmodule

// press_counter: top level
module press_counter (input clk, rst_n, btn, clear,
                      output [3:0] n, output nine);
  wire s;
  sync2       U1 (clk, rst_n, btn, s);
  press_count U2 (clk, rst_n, s, clear, n);
  nine_check  U3 (n, nine);
endmodule
