module fa (
	output s, c,
	input a, b, cin
);
	assign s = a ^ b ^ cin;
	assign c = a & b | a & cin | b & cin;
endmodule

module fa_tb;
	reg a, b, cin;
	wire s, c;

	fa uut(s, c, a, b, cin);

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, fa_tb);

		$display("A\tB\tCin\tCout\tS");
		$monitor("%b\t%b\t%b\t%b\t%b", a, b, cin, c, s);

		a = 0; b = 0; cin = 0; #1;
		cin = 1; #1;
		b = 1; cin = 0; #1;
		cin = 1; #1;
		a = 1; b = 0; cin = 0; #1;
		cin = 1; #1;
		b = 1; cin = 0; #1;
		cin = 1; #1;

		$finish;
	end
endmodule
