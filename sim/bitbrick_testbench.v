module bitbrick_testbench();
    reg [2:0] x;
    reg [2:0] y;
    wire [9:0] p;
    integer i;
    integer j;
    integer a;

    bitbrick bitbrick0(
        .x(x[1:0]),
        .s_x(x[2]),
        .y(y[1:0]),
        .s_y(y[2]),
        .shift(0),
        .prod(p)
    );

    initial begin
        //$vcdpluson;
        `ifdef IVERILOG
            $dumpfile("bitbrick_testbench.fst");
            $dumpvars(0,bitbrick_testbench);
        `endif

        for (i = 0; i <= 3; i = i + 1) begin
            for (j = 0; j <= 3; j = j + 1) begin
                x = i;
                y = j;
                #10;
                if ((i*j) != p) $display("Multiplicands: %d, %d, Correct: %d, Output: %d", i, j, (i*j), p);
            end
        end

        for (i = -2; i <= 1; i = i + 1) begin
            for (j = -2; j <= 1; j = j + 1) begin
                x = i;
                y = j;
                a = i*j;
                #10;
                if (a[5:0] != p[5:0]) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, a[5:0], p[5:0]);
            end
        end

        i = 3'b111;
        j = 3'b110;
        x = i;
        y = j;
        #10
        $display("Multiplicands: -2, -2, Correct: 4, Output: %b", p << 2);

        i = 3'b001;
        j = 3'b110;
        x = i;
        y = j;
        #10
        $display("Multiplicands: -1, -1, Correct: 1, Output: %b", p );
        $display("%b", (($signed(p) << 8) >>> 8));

        i = 3'b111;
        j = 3'b110;
        x = i;
        y = j;
        #10
        $display("Multiplicands: 1, -1, Correct: -1, Output: %b", p << 4);

        i = 3'b001;
        j = 3'b110;
        x = i; 
        y = j;
        #10
        $display("Multiplicands: -2, -1, Correct: 2, Output: %b", p << 2);


        // for (i = 0; i < 3; i = i + 1) begin
        //     for (j = 0; j < 3; j = j + 1) begin
        //         x[2] = 1;
        //         y[2] = 1;
        //         x[1:0] = i;
        //         y[1:0] = j;
        //         #10;
        //         $display("Multiplicands: %d, %d, Correct: %d, Output: %b", i, j, (i*j), p);
        //     end
        // end

        $finish();
        //$vcdplusoff;
    end

endmodule