module dff (
	output reg q, qb,
	input d, rst, clk
);
	initial begin
		q <= 1'b0;
		qb <= 1'b1;
	end
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			q <= 1'b0;
			qb <= 1'b1;
		end
		else begin
			q <= d;
			qb <= ~d;
		end
	end
endmodule

module dff_tb;
	reg clk, rst, d;
	wire q, qb;

	dff uut(q, qb, d, rst, clk);

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, dff_tb);

		$display("Time\tClk\tRst\tD\tQ\t~Q");
		$monitor("%1t\t%b\t%b\t%b\t%b\t%b", $time, clk, rst, d, q, qb);

		clk = 0; rst = 0; d = 1; #1;
		clk = 1; #1;
		d = 0;
		clk = 0; #1;
		clk = 1; #1;
		d = 1; clk = 0; #1;
		clk = 1; #1;

		// now test reset
		rst = 1; #1;

		$finish;
	end
endmodule
