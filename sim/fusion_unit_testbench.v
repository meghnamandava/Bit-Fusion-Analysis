module fusion_unit_testbench();
    reg [7:0] in;
    reg [7:0] weight;
    wire [15:0] psum_fwd;
    reg [3:0] in_width;
    reg [3:0] weight_width;
    reg s_in;
    reg s_weight;
    integer i;
    integer j;

    fusion_unit fu0(
        .in(in),
        .weight(weight),
        .in_width(in_width),
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

        /*s_weight = 1;
        s_in = 1;
        in = 2'b10;
        weight = 2'b10;
        #10;
        if (psum_fwd != (i*j)) $display("Multiplicands: -2, -2, Correct: 100, Output: %b", psum_fwd);
        */     

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

        in_width = 4;
        weight_width = 4;
        s_weight = 1;
        s_in = 1;
        in = 8'b00001011;
        weight = 8'b00000110;
        #10
        $display("Psum: %b", psum_fwd);


        $finish();
        //$vcdplusoff;
    end

endmodule