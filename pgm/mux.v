module mux (
	output reg y,
	input s1, s0,
	input a, b, c, d
);
	always @(*) begin
		case ({s1, s0})
		2'b00: y = a;
		2'b01: y = b;
		2'b10: y = c;
		2'b11: y = d;
		endcase
	end
endmodule

module mux_tb;
	reg a, b, c, d, s1, s0;
	wire y;

	mux uut(y, s1, s0, a, b, c, d);

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, mux_tb);

		a = 0; b = 1; c = 0; d = 1;
		$display("A\tB\tC\tD");
		$display("%b\t%b\t%b\t%b", a, b, c, d);

		$display("\nS1\tS0\tY");
		$monitor("%b\t%b\t%b", s1, s0, y);

		s1 = 0;
		s0 = 0; #2;

		s0 = 1; #2;

		s1 = 1;
		s0 = 0; #2;

		s0 = 1; #2;

		$finish;
	end
endmodule
