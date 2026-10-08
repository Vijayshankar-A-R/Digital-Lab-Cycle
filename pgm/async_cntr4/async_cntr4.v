module async_counter4(
    input wire          clk,
    output reg [3:0]    cnt
);
    // initialise to 0
    initial begin
        cnt = 4'b0;
    end

    always @(negedge ~clk) begin
        cnt[0] <= ~cnt[0];
    end

    always @(negedge ~cnt[0]) begin
        cnt[1] <= ~cnt[1];
    end

    always @(negedge ~cnt[1]) begin
        cnt[2] <= ~cnt[2];
    end

    always @(negedge ~cnt[2]) begin
        cnt[3] <= ~cnt[3];
    end

endmodule
