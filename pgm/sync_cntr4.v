module jk_ff (
    input  wire J,
    input  wire K,
    input  wire clk,
    input  wire reset,
    output reg  Q
);
    always @(posedge clk) begin
        if (reset)
            Q <= 1'b0;
        else begin
            case ({J, K})
                2'b00: Q <= Q;     // Hold
                2'b01: Q <= 1'b0;  // Reset
                2'b10: Q <= 1'b1;  // Set
                2'b11: Q <= ~Q;    // Toggle
            endcase
        end
    end
endmodule


// a. 4-bit synchronous up counter
module sync_counter (
    input  wire       clk,
    input  wire       reset,
    output wire [3:0] q
);
    jk_ff ff0 (1'b1, 1'b1, clk, reset, q[0]);
    jk_ff ff1 (q[0], q[0], clk, reset, q[1]);
    jk_ff ff2 (q[0] & q[1], q[0] & q[1], clk, reset, q[2]);
    jk_ff ff3 (q[0] & q[1] & q[2],
            q[0] & q[1] & q[2], clk,
			reset, q[3]);
endmodule


// b. 4-bit synchronous down counter
module sync_down_counter (
    input  wire       clk,
    input  wire       reset,
    output wire [3:0] q
);
    jk_ff ff0 (1'b1, 1'b1, clk, reset, q[0]);
    jk_ff ff1 (~q[0], ~q[0], clk, reset, q[1]);
    jk_ff ff2 (~q[0] & ~q[1], ~q[0] & ~q[1],
	  	clk, reset, q[2]);
    jk_ff ff3 (~q[0] & ~q[1] & ~q[2],
               ~q[0] & ~q[1] & ~q[2],
			   clk, reset, q[3]);
endmodule


// c. Mod-10 up counter
module mod10_counter (
    input  wire       clk,
    input  wire       reset,
    output wire [3:0] q
);
    wire ff_reset = reset | (q == 4'd9);

    jk_ff ff0 (1'b1, 1'b1, clk, ff_reset, q[0]);
    jk_ff ff1 (q[0], q[0], clk, ff_reset, q[1]);
    jk_ff ff2 (q[0] & q[1], q[0] & q[1], clk,
	   	ff_reset, q[2]);
    jk_ff ff3 (q[0] & q[1] & q[2],
                q[0] & q[1] & q[2], clk,
			   	ff_reset, q[3]);
endmodule


// d. 4-bit synchronous up/down counter
module sync_updown_counter (
    input  wire       clk,
    input  wire       reset,
    input  wire       mode,
    output wire [3:0] q
);
    wire toggle1 = mode ? q[0] : ~q[0];
    wire toggle2 = mode ? (q[0] & q[1]) : (~q[0] & ~q[1]);
    wire toggle3 = mode ? (q[0] & q[1] & q[2])
                        : (~q[0] & ~q[1] & ~q[2]);

    jk_ff ff0 (1'b1, 1'b1, clk, reset, q[0]);
    jk_ff ff1 (toggle1, toggle1, clk, reset, q[1]);
    jk_ff ff2 (toggle2, toggle2, clk, reset, q[2]);
    jk_ff ff3 (toggle3, toggle3, clk, reset, q[3]);
endmodule


// Testbench for the up counter
module tb_up_counter;
    reg clk = 0;
    reg reset = 1;
    wire [3:0] q;
    sync_counter dut (.clk(clk), .reset(reset), .q(q));
    always #5 clk = ~clk;
    initial begin
        $dumpfile("sync_counter.vcd");
        $dumpvars(1, tb_up_counter);
		$display(" time | reset |  q");
		$monitor("%5t |   %b   | %04b", $time, reset, q);
        #12 reset = 0;
        #200 $finish;
    end
endmodule


// Testbench for the down counter
module tb_down_counter;
    reg clk = 0;
    reg reset = 1;
    wire [3:0] q;
    sync_down_counter dut (.clk(clk), .reset(reset), .q(q));
    always #5 clk = ~clk;
    initial begin
        $dumpfile("sync_down_counter.vcd");
        $dumpvars(1, tb_down_counter);
		$display(" time | reset |  q");
		$monitor("%5t |   %b   | %04b", $time, reset, q);
        #12 reset = 0;
        #200 $finish;
    end
endmodule


// Testbench for the Mod-10 counter
module tb_mod10_counter;
    reg clk = 0;
    reg reset = 1;
    wire [3:0] q;
    mod10_counter dut (.clk(clk), .reset(reset), .q(q));
    always #5 clk = ~clk;
    initial begin
        $dumpfile("mod10_counter.vcd");
        $dumpvars(1, tb_mod10_counter);
		$display(" time | reset |  q");
		$monitor("%5t |   %b   | %04b", $time, reset, q);
        #12 reset = 0;
        #200 $finish;
    end
endmodule


// Testbench for the up/down counter
module tb_updown_counter;
    reg clk = 0;
    reg reset = 1;
    reg mode = 1;
    wire [3:0] q;
    sync_updown_counter dut (
        .clk(clk), .reset(reset), .mode(mode), .q(q)
    );
    always #5 clk = ~clk;
    initial begin
        $dumpfile("sync_updown_counter.vcd");
        $dumpvars(1, tb_updown_counter);
		$display(" time | reset | mode |  q");
		$monitor("%5t |   %b   |  %b   | %04b", $time, reset, mode, q);
        #12 reset = 0;  // Start counting up
        #100 mode = 0;  // Switch to counting down
        #100 $finish;
    end
endmodule

