module ha (
	output s, c,
	input a, b
);
	assign s = a ^ b;
	assign c = a & b;
endmodule

module ha_tb;
	reg a, b;
	wire s, c;

	ha uut (s, c, a, b);

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, ha_tb);

		$display("A\tB\tC\tS");
		$monitor("%b\t%b\t%b\t%b", a, b, c, s);

		a = 0; b = 0; #5;
		b = 1; #5;
		a = 1; b = 0; #5;
		b = 1; #5;

		$finish;
	end
endmodule
