module dmux (
	output reg a, b, c, d,
	input s1, s0,
	input y
);
	always @(*) begin
		a = 0; b = 0; c = 0; d = 0;
		case ({s1, s0})
		2'b00: a = y;
		2'b01: b = y;
		2'b10: c = y;
		2'b11: d = y;
		endcase
	end
endmodule

module mux_tb;
	reg y, s1, s0;
	wire a, b, c, d;

	dmux uut(a, b, c, d, s1, s0, y);

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, mux_tb);

		y = 1;
		$display("Y: %b", y);

		$display("\nS1\tS0\tA\tB\tC\tD");
		$monitor("%b\t%b\t%b\t%b\t%b\t%b", s1, s0, a, b, c, d);

		s1 = 0;
		s0 = 0; #2;

		s0 = 1; #2;

		s1 = 1;
		s0 = 0; #2;

		s0 = 1; #2;

		$finish;
	end
endmodule
