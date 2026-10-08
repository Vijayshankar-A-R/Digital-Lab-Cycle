module fa (
	output d, brwo,
	input a, b, brwi
);
	assign d = a ^ b ^ brwi;
	assign brwo = ~a & b | ~a & brwi | b & brwi;
endmodule

module fa_tb;
	reg a, b, brwi;
	wire d, brwo;

	fa uut(d, brwo, a, b, brwi);

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, fa_tb);

		$display("A\tB\tBrwi\tBrwo\tD");
		$monitor("%b\t%b\t%b\t%b\t%b", a, b, brwi, brwo, d);

		a = 0; b = 0; brwi = 0; #1;
		brwi = 1; #1;
		b = 1; brwi = 0; #1;
		brwi = 1; #1;
		a = 1; b = 0; brwi = 0; #1;
		brwi = 1; #1;
		b = 1; brwi = 0; #1;
		brwi = 1; #1;

		$finish;
	end
endmodule
