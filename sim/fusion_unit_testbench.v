`timescale 1ns/1ns

`define SECOND 1000000000
`define MS 1000000
`define CLOCKS_PER_SAMPLE 2500

module fusion_unit_testbench();

    reg clk;
    initial clk = 0;
    always #(5) clk <= ~clk;

    reg [7:0] in;
    reg [7:0] weight;
    wire [51:0] psum_fwd;
    reg [51:0] psum_in;
    reg [3:0] in_width;
    reg [3:0] weight_width;
    reg s_in;
    reg s_weight;
    integer i;
    integer j;
    integer a;

    fusion_unit fu0(
        .clk(clk),
        .in(in),
        .weight(weight),
        .in_width(in_width),
        .psum_in(psum_in),
        .weight_width(weight_width),
        .s_in(s_in),
        .s_weight(s_weight),
        .psum_fwd(psum_fwd)
    );

    initial begin
        //$vcdpluson;
        `ifdef IVERILOG
            $dumpfile("fusion_unit_testbench.fst");
            $dumpvars(0,fusion_unit_testbench);
        `endif

        #20
        @ (posedge clk);

        psum_in = 52'b0;
        in_width = 1;
        weight_width = 1;
        s_weight = 0;
        s_in = 0;
        for (i = 8'b0; i <= 8'b00000001; i = i + 1'b1) begin
            for (j = 8'b0; j <= 8'b00000001; j = j + 1'b1) begin
                in = i;
                weight = j;
                #10;
                if (psum_fwd != (i*j)) $display("Multiplicands: %d, %d, Correct: %d, Output: %d", i, j, (i*j), psum_fwd);
            end
        end

        in_width = 2;
        weight_width = 2;
        s_weight = 0;
        s_in = 0;
        for (i = 8'b0; i <= 8'b00000011; i = i + 1'b1) begin
            for (j = 8'b0; j <= 8'b00000011; j = j + 1'b1) begin
                in = i;
                weight = j;
                #10;
                if (psum_fwd != (i*j)) $display("Multiplicands: %d, %d, Correct: %d, Output: %d", i, j, (i*j), psum_fwd);
            end
        end    

        in_width = 4;
        weight_width = 4;
        s_weight = 0;
        s_in = 0;
        for (i = 8'b0; i <= 8'b00001111; i = i + 1'b1) begin
            for (j = 8'b0; j <= 8'b00001111; j = j + 1'b1) begin
                in = i;
                weight = j;
                #10;
                if (psum_fwd != (i*j)) $display("Multiplicands: %d, %d, Correct: %d, Output: %d", i, j, (i*j), psum_fwd);
            end
        end

        in_width = 8;
        weight_width = 8;
        s_weight = 0;
        s_in = 0;
        for (i = 8'b0; i <= 8'b11111111; i = i + 1'b1) begin
            for (j = 8'b0; j <= 8'b11111111; j = j + 1'b1) begin
                in = i;
                weight = j;
                #10;
                if (psum_fwd != (i*j)) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, (i*j), psum_fwd);
            end
        end 

        in_width = 2;
        weight_width = 4;
        s_weight = 0;
        s_in = 0;
        for (i = 8'b0; i <= 8'b00000011; i = i + 1'b1) begin
            for (j = 8'b0; j <= 8'b00001111; j = j + 1'b1) begin
                in = i;
                weight = j;
                #10;
                if (psum_fwd != (i*j)) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, (i*j), psum_fwd);
            end
        end 
        
        in_width = 4;
        weight_width = 2;
        s_weight = 0;
        s_in = 0;
        for (i = 8'b0; i <= 8'b00001111; i = i + 1'b1) begin
            for (j = 8'b0; j <= 8'b00000011; j = j + 1'b1) begin
                in = i;
                weight = j;
                #10;
                if (psum_fwd != (i*j)) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, (i*j), psum_fwd);
            end
        end 

        in_width = 4;
        weight_width = 8;
        s_weight = 0;
        s_in = 0;
        for (i = 8'b0; i <= 8'b00001111; i = i + 1'b1) begin
            for (j = 8'b0; j <= 8'b11111111; j = j + 1'b1) begin
                in = i;
                weight = j;
                #10;
                if (psum_fwd != (i*j)) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, (i*j), psum_fwd);
            end
        end

        in_width = 8;
        weight_width = 4;
        s_weight = 0;
        s_in = 0;
        for (i = 8'b0; i <= 8'b11111111; i = i + 1'b1) begin
            for (j = 8'b0; j <= 8'b00001111; j = j + 1'b1) begin
                in = i;
                weight = j;
                #10;
                if (psum_fwd != (i*j)) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, (i*j), psum_fwd);
            end
        end

        in_width = 8;
        weight_width = 2;
        s_weight = 0;
        s_in = 0;
        for (i = 8'b0; i <= 8'b11111111; i = i + 1'b1) begin
            for (j = 8'b0; j <= 8'b00000011; j = j + 1'b1) begin
                in = i;
                weight = j;
                #10;
                if (psum_fwd != (i*j)) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, (i*j), psum_fwd);
            end
        end

        in_width = 2;
        weight_width = 8;
        s_weight = 0;
        s_in = 0;
        for (i = 8'b0; i <= 8'b00000011; i = i + 1'b1) begin
            for (j = 8'b0; j <= 8'b11111111; j = j + 1'b1) begin
                in = i;
                weight = j;
                #10;
                if (psum_fwd != (i*j)) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, (i*j), psum_fwd);
            end
        end

        in_width = 8;
        weight_width = 8;
        s_weight = 1;
        s_in = 1;
        for (i = -128; i <= 127; i = i + 1) begin
            for (j = -128; j <= 127; j = j + 1) begin
                in = i[7:0];
                weight = j[7:0];
                a = i*j;
                #10;
                if (psum_fwd[31:0] != a[31:0]) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, a, psum_fwd);
            end
        end

        in_width = 8;
        weight_width = 8;
        s_weight = 1;
        s_in = 0;
        for (i = 0; i <= 255; i = i + 1) begin
            for (j = -128; j <= 127; j = j + 1) begin
                in = i[7:0];
                weight = j[7:0];
                a = i*j;
                #10;
                if (psum_fwd[31:0] != a[31:0]) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, a, psum_fwd);
            end
        end

        in_width = 4;
        weight_width = 4;
        s_weight = 1;
        s_in = 1;
        for (i = -8; i <= 7; i = i + 1) begin
            for (j = -8; j <= 7; j = j + 1) begin
                in = i[3:0];
                weight = j[3:0];
                a = i*j;
                #10;
                if (psum_fwd[25:0] != a[25:0]) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, a, psum_fwd);
            end
        end

        in_width = 8;
        weight_width = 4;
        s_weight = 1;
        s_in = 1;
        for (i = -128; i <= 127; i = i + 1) begin
            for (j = -8; j <= 7; j = j + 1) begin
                in = i[7:0];
                weight = j[3:0];
                a = i*j;
                #10;
                if (psum_fwd[25:0] != a[25:0]) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, a, psum_fwd);
            end
        end

        in_width = 4;
        weight_width = 8;
        s_in = 1;
        s_weight = 0;
        for (i = -8; i <= 7; i = i + 1) begin
            for (j = 0; j <= 255; j = j + 1) begin
                in = i[3:0];
                weight = j[7:0];
                a = i*j;
                #10;
                if (psum_fwd[31:0] != a[31:0]) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, a, psum_fwd);
            end
        end

        in_width = 2;
        weight_width = 4;
        s_weight = 1;
        s_in = 1;
        for (i = -2; i <= 1; i = i + 1) begin
            for (j = -8; j <= 7; j = j + 1) begin
                in = i[1:0];
                weight = j[3:0];
                a = i*j;
                #10;
                if (psum_fwd[25:0] != a[25:0]) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, a, psum_fwd);
            end
        end

        in_width = 4;
        weight_width = 2;
        s_weight = 1;
        s_in = 1;
        for (i = -8; i <= 7; i = i + 1) begin
            for (j = -2; j <= 1; j = j + 1) begin
                in = i[3:0];
                weight = j[1:0];
                a = i*j;
                #10;
                if (psum_fwd[12:0] != a[12:0]) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, a, psum_fwd);
            end
        end

        in_width = 4;
        weight_width = 8;
        s_in = 1;
        s_weight = 0;
        for (i = -8; i <= 7; i = i + 1) begin
            for (j = 0; j <= 255; j = j + 1) begin
                in = i[3:0];
                weight = j[7:0];
                a = i*j;
                #10;
                if (psum_fwd[31:0] != a[31:0]) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, a, psum_fwd);
            end
        end

        in_width = 2;
        weight_width = 8;
        s_weight = 1;
        s_in = 1;
        for (i = -2; i <= 1; i = i + 1) begin
            for (j = -128; j <= 127; j = j + 1) begin
                in = i[1:0];
                weight = j[7:0];
                a = i*j;
                #10;
                if (psum_fwd[31:0] != a[31:0]) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, a, psum_fwd);
            end
        end

        in_width = 8;
        weight_width = 2;
        s_weight = 1;
        s_in = 1;
        for (i = -128; i <= 127; i = i + 1) begin
            for (j = -2; j <= 1; j = j + 1) begin
                in = i[7:0];
                weight = j[1:0];
                a = i*j;
                #10;
                if (psum_fwd[12:0] != a[12:0]) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, a, psum_fwd);
            end
        end

        in_width = 2;
        weight_width = 2;
        s_weight = 1;
        s_in = 1;
        for (i = -2; i <= 1; i = i + 1) begin
            for (j = -2; j <= 1; j = j + 1) begin
                in = i[1:0];
                weight = j[1:0];
                a = i*j;
                #10;
                if (psum_fwd[12:0] != a[12:0]) $display("Multiplicands: %d, %d, Correct: %b, Output: %b", i, j, a, psum_fwd);
            end
        end

        
        in_width = 2;
        weight_width = 2;
        s_weight = 0;
        s_in = 0;
        in = 8'b11100100;
        weight = 8'b11100100;
        #10
        if (psum_fwd[12:0] != 0) $display("Correct: 0, Output: %d", psum_fwd[12:0]);
        if (psum_fwd[25:13] != 6) $display("Correct: 6, Output: %d", psum_fwd[25:13]);
        if (psum_fwd[38:26] != 12) $display("Correct: 12, Output: %d", psum_fwd[38:26]);
        if (psum_fwd[51:39] != 18) $display("Correct: 18, Output: %d", psum_fwd[51:39]);

        in_width = 4;
        weight_width = 2;
        s_weight = 0;
        s_in = 0;
        in = 8'b11010100;
        weight = 8'b11100100;
        #10
        if (psum_fwd[12:0] != 0) $display("Correct: 0, Output: %d", psum_fwd[12:0]);
        if (psum_fwd[25:13] != 17) $display("Correct: 17, Output: %d", psum_fwd[25:13]);
        if (psum_fwd[38:26] != 34) $display("Correct: 34, Output: %d", psum_fwd[38:26]);
        if (psum_fwd[51:39] != 51) $display("Correct: 51, Output: %d", psum_fwd[51:39]);
        
        psum_in = psum_fwd;//{13'b110011, 13'b100010, 13'b10001, 13'b0};
        in_width = 8;
        weight_width = 2;
        s_weight = 0;
        s_in = 0;
        in = 8'b10001001;
        weight = 8'b11100100;
        #10
        if (psum_fwd[12:0] != 0) $display("Correct: 0, Output: %d", psum_fwd[12:0]);
        if (psum_fwd[25:13] != 154) $display("Correct: 154, Output: %d", psum_fwd[25:13]);
        if (psum_fwd[38:26] != 308) $display("Correct: 308, Output: %d", psum_fwd[38:26]);
        if (psum_fwd[51:39] != 462) $display("Correct: 462, Output: %d", psum_fwd[51:39]);
        

        $finish();
        //$vcdplusoff;
    end

endmodule