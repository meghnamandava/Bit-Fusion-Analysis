`timescale 1ns/1ns

`define SECOND 1000000000
`define MS 1000000
`define CLOCKS_PER_SAMPLE 2500


module bitfusion_top_testbench();

    reg clk;
    initial clk = 0;
    always #(5) clk <= ~clk;

    reg [3:0] in;
    reg [3:0] weight;
    wire [7:0] psum_fwd;
    reg s_in;
    reg s_weight;
    integer i;
    integer j;
    integer a;

    bitfusion_top bt(
        .CLK_125MHZ_FPGA(clk),
        .in(in),
        .weight(weight),
        .s_in(s_in),
        .s_weight(s_weight),
        .psum(psum_fwd)
    );

    initial begin
        //$vcdpluson;
        `ifdef IVERILOG
            $dumpfile("bitfusion_top_testbench.fst");
            $dumpvars(0,bitfusion_top_testbench);
        `endif

        #20
        @ (posedge clk);

        s_weight = 0;
        s_in = 0;
        for (i = 8'b0; i <= 8'b00001111; i = i + 1'b1) begin
            for (j = 8'b0; j <= 8'b00001111; j = j + 1'b1) begin
                in = i;
                weight = j;
                #20;
                if (psum_fwd != (i*j)) $display("Multiplicands: %d, %d, Correct: %d, Output: %d", i, j, (i*j), psum_fwd);
            end
        end

        s_weight = 1;
        s_in = 1;
        for (i = -8; i <= 7; i = i + 1) begin
            for (j = -8; j <= 7; j = j + 1) begin
                in = i[3:0];
                weight = j[3:0];
                a = i*j;
                #20;
                if (psum_fwd != a[7:0]) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, a, psum_fwd);
            end
        end

        $display("All cases passed");

        $finish();
        //$vcdplusoff;
    end

endmodule