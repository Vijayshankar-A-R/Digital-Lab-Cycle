module basic_gates (
    output n, o, an, x, no, na, xn,
    input a, b
);    
	not	(n, a);
	or (o, a, b);
	and (an, a, b);
	xor (x, a, b);
	nor (no, a, b);
	nand (na, a, b);
	xnor (xn, a, b);
endmodule

module bg_tb;
	reg a, b;
	wire n, o, an, x, no, na, xn;

	basic_gates uut(n, o, an, x, no, na, xn, a, b);

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, bg_tb);

		$display("A\tB|\tNOT_A\tOR\tAND\tXOR\tNOR\tNAND\tXNOR");
		$monitor("%b\t%b|\t%b\t%b\t%b\t%b\t%b\t%b\t%b", a, b, n, o, an, x, no, na, xn);

		a = 0; b = 0; #5;
		b = 1; #5;
		a = 1; b = 0; #5;
		b = 1; #5;

		$finish;
	end
endmodule
