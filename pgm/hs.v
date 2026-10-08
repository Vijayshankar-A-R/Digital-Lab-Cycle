module ha (
	output d, brwo,
	input a, b
);
	assign d = a ^ b;
	assign brwo = ~a & b;
endmodule

module ha_tb;
	reg a, b;
	wire d, brwo;

	ha uut (d, brwo, a, b);

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, ha_tb);

		$display("A\tB\tBo\tD");
		$monitor("%b\t%b\t%b\t%b", a, b, brwo, d);

		a = 0; b = 0; #5;
		b = 1; #5;
		a = 1; b = 0; #5;
		b = 1; #5;

		$finish;
	end
endmodule
