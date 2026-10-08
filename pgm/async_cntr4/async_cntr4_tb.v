`timescale 1ns/1ps

module async_cntr4_tb;

    reg clk;
    wire [3:0] cnt;

    async_counter4 uut(
        .clk (clk),
        .cnt (cnt)
    );

    always #5 clk = ~clk;    // 10ns clock period

    initial begin
        clk = 1'b0;
        $dumpfile("wave.vcd");
        $dumpvars(0, async_cntr4_tb);


        #200;
        $finish;
    end
endmodule
